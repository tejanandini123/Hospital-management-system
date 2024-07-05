
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender CHAR(1)
);


CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Specialty VARCHAR(100)
);


CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE,
    Reason VARCHAR(255),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);


CREATE TABLE Treatments (
    TreatmentID INT PRIMARY KEY,
    AppointmentID INT,
    TreatmentDescription VARCHAR(255),
    TreatmentDate DATE,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);


-- Inserting data into Patients table
INSERT INTO Patients (PatientID, FirstName, LastName, DateOfBirth, Gender)
VALUES
(1, 'Patient1', 'Patient1', '1985-06-15', 'F'),
(2, 'Patient2', 'Patient2', '1990-09-23', 'M'),
(3, 'Patient3', 'Patient3', '2000-12-10', 'M');

-- Inserting data into Doctors table
INSERT INTO Doctors (DoctorID, FirstName, LastName, Specialty)
VALUES
(1, 'Dr. Emily', 'Davis', 'Cardiology'),
(2, 'Dr. John', 'Williams', 'Neurology'),
(3, 'Dr. Sarah', 'Taylor', 'Orthopedics');

-- Inserting data into Appointments table
INSERT INTO Appointments (AppointmentID, PatientID, DoctorID, AppointmentDate, Reason)
VALUES
(1, 1, 1, '2022-01-15', 'Checkup'),
(2, 2, 2, '2022-02-20', 'Consultation'),
(3, 3, 3, '2022-03-25', 'Follow-up');

-- Inserting data into Treatments table
INSERT INTO Treatments (TreatmentID, AppointmentID, TreatmentDescription, TreatmentDate)
VALUES
(1, 1, 'Blood Test', '2022-01-16'),
(2, 2, 'MRI Scan', '2022-02-21'),
(3, 3, 'Physical Therapy', '2022-03-26');


-- Retrieve patient appointments
SELECT a.AppointmentID, p.FirstName AS PatientFirstName, p.LastName AS PatientLastName, d.FirstName AS DoctorFirstName, d.LastName AS DoctorLastName, a.AppointmentDate, a.Reason
FROM Appointments a
JOIN Patients p ON a.PatientID = p.PatientID
JOIN Doctors d ON a.DoctorID = d.DoctorID;

-- Get treatment details for specific patient
SELECT t.TreatmentID, t.TreatmentDescription, t.TreatmentDate
FROM Treatments t
JOIN Appointments a ON t.AppointmentID = a.AppointmentID
WHERE a.PatientID = 1;

-- Find doctors with the most appointments
SELECT d.FirstName, d.LastName, COUNT(a.AppointmentID) AS NumberOfAppointments
FROM Doctors d
JOIN Appointments a ON d.DoctorID = a.DoctorID
GROUP BY d.DoctorID, d.FirstName, d.LastName
ORDER BY NumberOfAppointments DESC;

