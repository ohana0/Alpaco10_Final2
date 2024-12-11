import os
import io
from fastapi import FastAPI, Request, HTTPException, Form
from fastapi.responses import HTMLResponse, Response
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
import nibabel as nib
import numpy as np
from PIL import Image
from skimage import measure
import plotly.graph_objects as go
from plotly.offline import plot
import uvicorn
from sqlalchemy import create_engine

app = FastAPI()

# Mount the static directory
app.mount("/static", StaticFiles(directory="static"), name="static")

# Set up templates
templates = Jinja2Templates(directory="templates")

#db연결
db_connection = create_engine("mysql://root:root@127.0.0.1:3306/test?charset=utf8mb4")

# Global variables to store NIfTI data
nifti_data = {}
nifti_header = {}

@app.on_event("startup")
def load_nifti_files():
    global nifti_data, nifti_header
    t1_path = os.path.join("static", "BraTS2021_00000_t1.nii.gz")
    seg_path = os.path.join("static", "BraTS2021_00000_seg.nii.gz")
    
    try:
        t1_img = nib.load(t1_path)
        nifti_data['t1'] = t1_img.get_fdata()
        nifti_header['t1'] = t1_img.header
    except Exception as e:
        print(f"Error loading T1 NIfTI file: {e}")
        nifti_data['t1'] = None
    
    try:
        seg_img = nib.load(seg_path)
        nifti_data['seg'] = seg_img.get_fdata()
        nifti_header['seg'] = seg_img.header
    except Exception as e:
        print(f"Error loading Segmentation NIfTI file: {e}")
        nifti_data['seg'] = None

def create_combined_image(view: str, index: int) -> Image.Image:
    """
    Creates a combined image with T1 and Segmentation overlaid.
    """
    if 't1' not in nifti_data or 'seg' not in nifti_data:
        raise HTTPException(status_code=404, detail="Data not available.")
    
    t1_data = nifti_data['t1']
    seg_data = nifti_data['seg']
    
    if t1_data.shape != seg_data.shape:
        raise HTTPException(status_code=400, detail="T1 and Segmentation data shapes do not match.")
    
    if view == 'axial':
        t1_slice = t1_data[:, :, index]
        seg_slice = seg_data[:, :, index]
    elif view == 'coronal':
        t1_slice = t1_data[:, index, :]
        seg_slice = seg_data[:, index, :]
    elif view == 'sagittal':
        t1_slice = t1_data[index, :, :]
        seg_slice = seg_data[index, :, :]
    else:
        raise HTTPException(status_code=400, detail="Invalid view type.")
    
    # Normalize T1 slice to 0-255
    t1_min, t1_max = np.min(t1_slice), np.max(t1_slice)
    t1_normalized = (t1_slice - t1_min) / (t1_max - t1_min) if t1_max > t1_min else t1_slice
    t1_uint8 = np.uint8(255 * t1_normalized)
    base_img = Image.fromarray(t1_uint8).convert("L")
    
    # Create overlay
    seg_mask = seg_slice > 0
    overlay = Image.new("RGBA", base_img.size, (255, 0, 0, 0))
    overlay_data = overlay.load()
    for y in range(seg_slice.shape[0]):
        for x in range(seg_slice.shape[1]):
            if seg_mask[y, x]:
                overlay_data[x, y] = (255, 0, 0, 100)  # Semi-transparent red
    
    # Combine T1 and overlay
    combined_img = base_img.convert("RGBA")
    combined_img.alpha_composite(overlay)
    return combined_img

@app.get("/slice/{view}/{index}.png")
def get_combined_image(view: str, index: int):
    """
    API endpoint to get a combined image with T1 and segmentation overlay.
    """
    img = create_combined_image(view, index)
    buf = io.BytesIO()
    img.save(buf, format="PNG")
    return Response(content=buf.getvalue(), media_type="image/png")




def create_3d_view() -> str:
    """
    Generates a 3D view with T1 data in translucent gray and segmentation in red,
    minimizing top margin and centering the brain vertically.
    """
    t1_data = nifti_data.get('t1')
    seg_data = nifti_data.get('seg')
    if t1_data is None or seg_data is None:
        raise HTTPException(status_code=404, detail="Data not available.")

    # Threshold for T1 data visualization
    t1_threshold = np.percentile(t1_data, 50)  # Use median for T1
    verts_t1, faces_t1, normals_t1, _ = measure.marching_cubes(t1_data, level=t1_threshold)

    # Threshold for Segmentation data visualization
    seg_mask = seg_data > 0  # Segmentation mask for values greater than 0
    seg_coords = np.column_stack(np.nonzero(seg_mask)).astype(np.float64)  # Convert to float64 for calculations

    # Calculate center of the brain (bounding box center)
    x_center = (verts_t1[:, 0].min() + verts_t1[:, 0].max()) / 2
    y_center = (verts_t1[:, 1].min() + verts_t1[:, 1].max()) / 2
    z_center = (verts_t1[:, 2].min() + verts_t1[:, 2].max()) / 2

    # Adjust vertex positions to center the brain
    z_lift = 80  # Adjust this value to lift the brain vertically
    verts_t1[:, 0] -= x_center
    verts_t1[:, 1] -= y_center
    verts_t1[:, 2] -= (z_center - z_lift)  # Lift the brain upwards
    seg_coords[:, 0] -= x_center
    seg_coords[:, 1] -= y_center
    seg_coords[:, 2] -= (z_center - z_lift)  # Lift segmentation points upwards

    # Create 3D plot
    fig = go.Figure()

    # Add T1 data (translucent gray)
    fig.add_trace(go.Mesh3d(
        x=verts_t1[:, 0],
        y=verts_t1[:, 1],
        z=verts_t1[:, 2],
        i=faces_t1[:, 0],
        j=faces_t1[:, 1],
        k=faces_t1[:, 2],
        color="lightgray",  # Translucent gray for T1 data
        opacity=0.3,  # Set transparency
        name="T1 Data"
    ))

    # Add Segmentation data (red points)
    fig.add_trace(go.Scatter3d(
        x=seg_coords[:, 0],
        y=seg_coords[:, 1],
        z=seg_coords[:, 2],
        mode='markers',
        marker=dict(size=2, color='red'),  # Red for segmentation points
        name='Segmentation Points'
    ))

    # Adjust camera position, Scene domain, and minimize top margin
    fig.update_layout(
        scene=dict(
            domain=dict(x=[0, 1], y=[0, 1]),  # Use full width and height for the scene
            xaxis=dict(title='X', backgroundcolor="black", color="white", gridcolor="gray"),
            yaxis=dict(title='Y', backgroundcolor="black", color="white", gridcolor="gray"),
            zaxis=dict(
                title='Z',
                backgroundcolor="black",
                color="white",
                gridcolor="gray",
                range=[0, 260]  # Adjust Z-axis range to lift the brain
            ),
            aspectmode="data",  # Adjust aspect ratio based on data
            camera=dict(
                eye=dict(x=0.5, y=0.8, z=2.0),  # Adjust camera distance
                center=dict(x=0, y=0, z=0.3)  # Center the brain in the scene
            ),
        ),
        paper_bgcolor="black",
        plot_bgcolor="black",
        margin=dict(l=0, r=0, t=0, b=0),  # Remove all external margins
        width=700,
        height=250
    )

    return plot(fig, output_type='div', include_plotlyjs=False)

@app.get("/", response_class=HTMLResponse)
async def read_root(request: Request):
    """
    Renders the main page with 3D view and slice viewers.
    """
    t1_data = nifti_data.get('t1')
    if t1_data is None:
        return HTMLResponse(content="<h1>Error loading data.</h1>", status_code=500)
    
    axial_max = t1_data.shape[2] - 1
    coronal_max = t1_data.shape[1] - 1
    sagittal_max = t1_data.shape[0] - 1
    initial_axial = axial_max // 2
    initial_coronal = coronal_max // 2
    initial_sagittal = sagittal_max // 2
    plot_div = create_3d_view()
    
    return templates.TemplateResponse("3Dslicer.html", {
        "request": request,
        "axial_max": axial_max,
        "coronal_max": coronal_max,
        "sagittal_max": sagittal_max,
        "initial_axial": initial_axial,
        "initial_coronal": initial_coronal,
        "initial_sagittal": initial_sagittal,
        "plot_div": plot_div
    })
