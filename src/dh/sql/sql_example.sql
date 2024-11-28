DROP DATABASE `project`;
CREATE database `project`;
USE `project`;

CREATE TABLE `patient` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(32) NOT NULL,
    `sex` VARCHAR(16) NOT NULL,
    `birth` DATE NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `medical_record` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `patient_id` INT NOT NULL,
    `date` DATE NOT NULL,
    `diagnosis` TEXT NOT NULL,
    `treatment` TEXT NOT NULL,
    `notes` TEXT,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`patient_id`) REFERENCES `patient`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `reference` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(64) NOT NULL,
    `author` VARCHAR(64) NOT NULL,
    `image_path` VARCHAR(256) NOT NULL,
    `notes` TEXT,
    `src` VARCHAR(256) NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `patient` (`name`, `sex`, `birth`, `created_at`)
VALUES
('Trump', 'Male', '1947-06-14', CURRENT_TIMESTAMP),
('Biden', 'Male', '1943-11-20', CURRENT_TIMESTAMP),
('JeongUn', 'Male', '1985-01-08', CURRENT_TIMESTAMP),
('Putin', 'Male', '1953-10-07', CURRENT_TIMESTAMP),
('Ping', 'Female', '1989-11-23', CURRENT_TIMESTAMP);

-- Trump's records
INSERT INTO `medical_record` (`patient_id`, `date`, `diagnosis`, `treatment`, `notes`)
VALUES
(1, '2023-08-10', 'Chronic headaches', 'Prescribed painkillers', 'Reported frequent migraines over the last 2 years'),
(1, '2023-10-22', 'Vision problems', 'Referred to neurology', 'Complaints of blurred vision and dizziness'),
(1, '2023-11-01', 'Neck pain', 'Physical therapy recommended', 'Experiencing neck stiffness and pain'),
(1, '2023-12-05', 'Shortness of breath', 'Lung x-ray ordered', 'Patient reported difficulty breathing after exertion'),
(1, '2024-01-10', 'Numbness in left hand', 'Neurological evaluation', 'Temporary numbness in left hand'),
(1, '2024-02-15', 'Dizziness', 'Blood pressure check', 'Vertigo and lightheadedness upon standing'),
(1, '2024-03-01', 'Chronic fatigue', 'Blood work scheduled', 'Patient complains of ongoing fatigue'),
(1, '2024-04-10', 'Memory loss', 'Cognitive testing', 'Difficulty remembering recent events and names'),
(1, '2024-05-20', 'Confusion and disorientation', 'Brain scan recommended', 'Episodes of confusion and difficulty focusing'),
(1, '2024-06-15', 'Severe headache', 'MRI scheduled', 'Headache worsened over the past week'),
(1, '2024-07-01', 'Speech difficulty', 'Referral to speech therapy', 'Difficulty articulating words during conversations'),
(1, '2024-08-15', 'Depression', 'Mental health evaluation', 'Mood swings and lack of motivation'),
(1, '2024-09-10', 'Severe fatigue', 'Referral to oncologist', 'Fatigue not improving despite rest'),
(1, '2024-10-05', 'Vision loss in right eye', 'Ophthalmology consultation', 'Vision progressively worsened in right eye'),
(1, '2024-10-20', 'Brain tumor suspicion', 'MRI scheduled', 'Neurological tests suggested possible tumor'),
(1, '2024-11-10', 'Brain tumor suspicion', 'MRI scheduled', 'Neurological tests suggested possible tumor'),
(1, '2024-11-12', 'Headaches and nausea', 'Neurology follow-up', 'Patient reporting worsening symptoms'),
(1, '2024-11-15', 'Brain tumor confirmed', 'Surgical consultation', 'MRI confirmed presence of brain tumor'),
(1, '2024-11-18', 'Pre-surgery consultation', 'Surgical planning', 'Consultation with neurosurgeon for upcoming surgery');

-- Biden's records
INSERT INTO `medical_record` (`patient_id`, `date`, `diagnosis`, `treatment`, `notes`)
VALUES
(2, '2022-05-22', 'Sleep apnea', 'CPAP therapy', 'Severe snoring and daytime fatigue'),
(2, '2022-07-10', 'Joint pain', 'Anti-inflammatory medications', 'Reported pain in knees and shoulders'),
(2, '2022-09-01', 'Frequent urination', 'Urine test', 'Increased frequency of urination, especially at night'),
(2, '2022-10-15', 'Shortness of breath', 'Chest X-ray', 'Difficulty breathing during light activities'),
(2, '2023-01-12', 'Memory issues', 'Neurocognitive tests', 'Family history of dementia raised concerns'),
(2, '2023-02-05', 'Chronic fatigue', 'Blood work', 'Fatigue despite regular sleep schedule'),
(2, '2023-04-01', 'Difficulty sleeping', 'Sleep study ordered', 'Patient reported difficulty falling asleep and staying asleep'),
(2, '2023-06-10', 'Back pain', 'Physical therapy', 'Chronic lower back pain worsened over the last few months'),
(2, '2023-07-25', 'Severe headaches', 'Neurological consultation', 'Recurring headaches with no known trigger'),
(2, '2023-08-30', 'Numbness in legs', 'Neurology referral', 'Loss of sensation in both legs for brief periods'),
(2, '2023-09-20', 'Cognitive decline', 'Memory screening', 'Noticing forgetfulness and confusion'),
(2, '2023-10-12', 'Stomach pain', 'Gastroscopy', 'Chronic abdominal discomfort and bloating'),
(2, '2024-01-05', 'Dizziness', 'Blood pressure monitoring', 'Lightheadedness upon standing'),
(2, '2024-02-22', 'Vision impairment', 'Eye exam', 'Blurred vision in left eye'),
(2, '2024-03-10', 'Difficulty swallowing', 'Speech therapy', 'Occasional choking on food and liquids'),
(2, '2024-05-01', 'Brain tumor suspicion', 'MRI scheduled', 'Neurologist raised concerns about tumor based on symptoms'),
(2, '2024-06-15', 'Brain tumor confirmed', 'Surgery scheduled', 'MRI confirmed presence of mass in the brain'),
(2, '2024-07-10', 'Post-surgery follow-up', 'Radiation therapy recommended', 'Recovery after surgery'),
(2, '2024-11-12', 'Brain tumor diagnosis', 'Biopsy performed', 'MRI revealed mass in frontal lobe');


-- JeongUn's records
INSERT INTO `medical_record` (`patient_id`, `date`, `diagnosis`, `treatment`, `notes`)
VALUES
(3, '2020-12-01', 'Hypertension', 'Antihypertensive drugs', 'Elevated blood pressure over 6 months'),
(3, '2021-02-15', 'Headaches', 'Pain management', 'Occasional headaches, no known triggers'),
(3, '2021-04-10', 'Vision blurriness', 'Referral to ophthalmologist', 'Vision loss in both eyes for brief periods'),
(3, '2021-07-05', 'Memory loss', 'Neurological tests', 'Difficulty recalling recent events'),
(3, '2021-10-20', 'Dizziness', 'Vertigo medication', 'Lightheadedness and dizziness while standing'),
(3, '2022-01-15', 'Severe fatigue', 'Blood tests', 'Ongoing fatigue despite adequate rest'),
(3, '2022-03-20', 'Confusion', 'Brain scan', 'Confused about time and places'),
(3, '2022-06-10', 'Severe headaches', 'MRI recommended', 'Chronic headaches not responding to medication'),
(3, '2022-09-05', 'Speech difficulty', 'Speech therapy', 'Difficulty articulating words'),
(3, '2022-11-20', 'Balance issues', 'Physical therapy', 'Patient had trouble maintaining balance while walking'),
(3, '2023-01-10', 'Hand tremors', 'Neurological evaluation', 'Uncontrollable shaking in hands'),
(3, '2023-03-15', 'Chronic dizziness', 'Medication adjustment', 'Episodes of vertigo throughout the day'),
(3, '2023-06-10', 'Nausea', 'Gastrointestinal evaluation', 'Ongoing nausea without a clear cause'),
(3, '2023-08-01', 'Severe headache', 'Neurology follow-up', 'Headaches worsening, medication ineffective'),
(3, '2023-10-05', 'Brain tumor suspicion', 'MRI scheduled', 'Concerns raised by neurologist'),
(3, '2024-01-10', 'Brain tumor confirmed', 'Surgical consultation', 'MRI confirmed glioblastoma'),
(3, '2024-02-01', 'Post-surgery check-up', 'Chemotherapy planned', 'Follow-up consultation for chemotherapy planning'),
(3, '2024-03-10', 'Post-treatment monitoring', 'Radiation therapy scheduled', 'Ongoing treatment for brain tumor');


-- Putin's records
INSERT INTO `medical_record` (`patient_id`, `date`, `diagnosis`, `treatment`, `notes`)
VALUES
(4, '2021-06-15', 'Vertigo', 'Physical therapy', 'Symptoms of imbalance and dizziness'),
(4, '2021-08-01', 'Back pain', 'Spinal x-ray', 'Back pain that worsened with movement'),
(4, '2021-10-10', 'Fatigue', 'Blood test ordered', 'Chronic fatigue without an obvious cause'),
(4, '2021-12-20', 'Memory issues', 'Neuropsychological evaluation', 'Memory lapses over the past few months'),
(4, '2022-02-15', 'Depression', 'Mental health evaluation', 'Mood swings and sadness for weeks'),
(4, '2022-05-10', 'Headaches', 'Neurology referral', 'Persistent headaches, no known cause'),
(4, '2022-08-15', 'Joint pain', 'Rheumatology referral', 'Pain in knees and elbows, difficulty moving'),
(4, '2022-10-05', 'Severe dizziness', 'Neurological exam', 'Severe dizziness and lightheadedness'),
(4, '2023-01-01', 'Vision impairment', 'Eye exam', 'Complaints of blurred vision'),
(4, '2023-03-10', 'Chronic fatigue', 'Blood work scheduled', 'Ongoing fatigue despite rest'),
(4, '2023-05-25', 'Memory loss', 'Neurology follow-up', 'Increasing forgetfulness'),
(4, '2023-07-12', 'Tremors', 'Neurological evaluation', 'Uncontrollable hand tremors'),
(4, '2023-09-05', 'Balance issues', 'Physical therapy', 'Difficulty walking without support'),
(4, '2023-11-01', 'Nausea', 'MRI scheduled', 'Persistent nausea without vomiting'),
(4, '2023-12-15', 'Brain tumor suspicion', 'MRI recommended', 'Neurologist suggested a possible tumor'),
(4, '2024-01-10', 'Brain tumor confirmed', 'Surgery scheduled', 'MRI confirmed presence of mass in the temporal lobe'),
(4, '2024-02-20', 'Post-surgery follow-up', 'Radiation therapy scheduled', 'Recovery after surgery, planning radiation'),
(4, '2024-04-10', 'Post-treatment monitoring', 'Chemotherapy planned', 'Follow-up for chemotherapy planning');

-- Ping's records
INSERT INTO `medical_record` (`patient_id`, `date`, `diagnosis`, `treatment`, `notes`)
VALUES
(5, '2021-02-01', 'Chronic migraines', 'Prescribed migraine medication', 'Frequent migraines, especially after stress'),
(5, '2021-04-10', 'Neck pain', 'Physical therapy', 'Pain in the neck and shoulders after long hours of work'),
(5, '2021-06-15', 'Fatigue', 'Blood tests', 'Tiredness despite adequate sleep, feeling drained'),
(5, '2021-08-01', 'Nausea', 'Gastrointestinal tests', 'Persistent nausea without vomiting, especially in the mornings'),
(5, '2021-10-05', 'Back pain', 'Physical therapy', 'Lower back pain after sitting for long periods'),
(5, '2021-12-10', 'Memory loss', 'Neuropsychological evaluation', 'Occasional forgetfulness and difficulty recalling recent events'),
(5, '2022-02-25', 'Headaches', 'Neurology referral', 'Chronic headaches with occasional visual disturbances'),
(5, '2022-04-20', 'Vision problems', 'Ophthalmologist consultation', 'Blurred vision in the left eye, especially at night'),
(5, '2022-06-15', 'Joint pain', 'Rheumatology referral', 'Pain and stiffness in the wrists and knees'),
(5, '2022-08-05', 'Dizziness', 'Neurological examination', 'Frequent dizziness, especially when standing up quickly'),
(5, '2022-09-25', 'Memory issues', 'Cognitive testing', 'Difficulty remembering recent conversations and appointments'),
(5, '2023-01-10', 'Fatigue and shortness of breath', 'Chest X-ray and blood tests', 'Experiencing fatigue and shortness of breath with light physical activity'),
(5, '2023-03-05', 'Tremors', 'Neurological evaluation', 'Mild tremors in the hands, worse when stressed'),
(5, '2023-05-15', 'Chronic headaches', 'Neurological consultation', 'Ongoing headaches, unresponsive to pain medications'),
(5, '2023-07-10', 'Speech difficulties', 'Speech therapy', 'Slurred speech and difficulty articulating words'),
(5, '2023-09-05', 'Balance issues', 'Physical therapy referral', 'Difficulty maintaining balance, prone to falls'),
(5, '2023-11-01', 'Brain tumor suspicion', 'MRI ordered', 'Neurologist suspects a possible brain tumor based on symptoms'),
(5, '2024-01-15', 'Brain tumor confirmed', 'Surgical consultation', 'MRI confirmed presence of mass in the brain, surgery recommended'),
(5, '2024-03-01', 'Post-surgery follow-up', 'Radiation therapy scheduled', 'Patient recovering from brain surgery, planning for radiation therapy'),
(5, '2024-04-25', 'Post-treatment evaluation', 'Chemotherapy planned', 'Follow-up consultation for chemotherapy planning after surgery');

-- reference
INSERT INTO `reference` (`title`, `author`, `image_path`, `src`,`notes`)
VALUES 
('Principles of Neurology', 'Allan H. Ropper, Martin A. Samuels, Joshua Klein', 'static/Principles_of_neurology.png', 'static/Principles_of_neurology.pdf','내용없음');

