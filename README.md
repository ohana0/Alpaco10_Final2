# Alpaco10 Final Project  
## 알파코캠퍼스 2조

### 🧠 **주제**  
**뇌종양 분석과 RAG를 활용한 자동 의학 소견 생성 시스템 구축**  
- **목표**:  
  - MRI 사진에서 3D segmentation 모델로 뇌종양 발견
  - 전문서적 전체 PDF에서 관련 지식 정보 추출
  - 이를 통합하여 자동으로 **Medical Letter** 생성

---

### 📂 **Dataset**
- **BRATZ 데이터셋**: 뇌종양 MRI 이미지 데이터
- **PubMed Conversation 데이터셋**: 의학 논문 및 연구 대화 데이터
- **Brain Section 데이터셋**: 뇌 MRI의 세부 절단면 이미지 데이터

---

### 🧑‍💻 **Model**
- **UNet**: 뇌 MRI에서 종양 영역을 정확하게 분리
- **SwinUnetR**: 스윈트랜스포머 기반의 고도화된 U-Net 모델
- **Gemma2-2B**: 의료 관련 정보 추출을 위한 GPT 모델
- **Llama3**: 대규모 언어 모델로 의학적 질문에 대한 답변 생성

---

### ⚙️ **Tech Stack**
- **Programming Language**: Python
- **Deep Learning Framework**: PyTorch
- **Web Framework**: FastAPI
- **Database**:
  - MySQL
  - SQLite
  - PostgreSQL
- **Medical Imaging Tools**: AAL, 3D Slicer
- **RAG (Retrieval-Augmented Generation)**: 텍스트 생성과 외부 정보 검색을 결합한 모델

---

### 📄 **Overview**
이 프로젝트는 뇌종양의 MRI 이미지 분석과, 이를 기반으로 생성된 데이터를 의학적 소견으로 변환하는 자동 시스템을 구축하는 것을 목표로 합니다. **3D segmentation**을 사용하여 뇌종양을 정확하게 식별하고, **RAG** 기술을 통해 관련 의학 지식을 통합하여 최종적으로 **Medical Letter**를 자동으로 생성합니다.

---

### 📑 **Installation**
1. **Clone the repository**:
    ```bash
    git clone https://github.com/yourusername/Alpaco10_Final_Project.git
    ```

2. **Install Dependencies**:
    ```bash
    pip install -r requirements.txt
    ```

---

### 🚀 **Usage**
- **Run the application**:
    ```bash
    uvicorn main:app --reload
    ```
    FastAPI 서버가 실행되며, 웹 인터페이스를 통해 결과를 확인할 수 있습니다.

---

### 📝 **License**
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
