USE clinic_db;

SELECT
    CONSTRAINT_NAME AS ForeignKeyName,
    TABLE_NAME AS TableName
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_TYPE = 'FOREIGN KEY'
  AND TABLE_SCHEMA = 'clinic_db'
ORDER BY CONSTRAINT_NAME;


CREATE DATABASE IF NOT EXISTS clinic_db;
USE clinic_db;
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS Invoices;
DROP TABLE IF EXISTS MedicalRecords;
DROP TABLE IF EXISTS Appointments;
DROP TABLE IF EXISTS Doctors;
DROP TABLE IF EXISTS Specialties;

CREATE TABLE Specialties (
    SpecialtyID INT NOT NULL PRIMARY KEY,
    Description VARCHAR(100) NOT NULL
);


DROP TABLE IF EXISTS Patients;

CREATE TABLE Patients (
   PatientID INT NOT NULL PRIMARY KEY,
    Name VARCHAR(20) NOT NULL,
    Gender VARCHAR(10),
    BloodType VARCHAR(5),
    DateOfBirth DATE,
    NationalID VARCHAR(30) 
);



DROP TABLE IF EXISTS Staff;

CREATE TABLE Staff (
    StaffID INT NOT NULL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Role VARCHAR(50),
    HireDate DATE
);



DROP TABLE IF EXISTS ExamRooms;

CREATE TABLE ExamRooms (
    RoomID INT NOT NULL PRIMARY KEY,
    RoomType VARCHAR(50),
    Floor INT
);




CREATE TABLE Doctors (
    DoctorID INT NOT NULL PRIMARY KEY,
    SpecialtyID INT NOT NULL,
    Name VARCHAR(20) NOT NULL,
    Phone VARCHAR(20),
    LicenseNumber VARCHAR(50),

    FOREIGN KEY (SpecialtyID) REFERENCES Specialties(SpecialtyID)
);





DROP TABLE IF EXISTS Appointments;

CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    RoomID INT,
    StaffID INT,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (RoomID) REFERENCES ExamRooms(RoomID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);



CREATE TABLE MedicalRecords (
    RecordID INT NOT NULL PRIMARY KEY,
    AppointmentID INT NOT NULL,
    Diagnosis TEXT,
    FollowUpDate DATE,

    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);



CREATE TABLE Invoices (
    InvoiceID INT NOT NULL,
    AppointmentID INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod VARCHAR(30),
    PRIMARY KEY (InvoiceID),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);



DROP TABLE IF EXISTS Medications;

CREATE TABLE Medications (
    MedicationID INT NOT NULL PRIMARY KEY,
    MedicationName VARCHAR(100) NOT NULL,
    StockQuantity INT DEFAULT 0
);



DROP TABLE IF EXISTS Prescriptions;

CREATE TABLE Prescriptions (
    PrescriptionID INT NOT NULL PRIMARY KEY,
    RecordID INT NOT NULL,

    FOREIGN KEY (RecordID) REFERENCES MedicalRecords(RecordID)
);



DROP TABLE IF EXISTS PrescriptionItems;

CREATE TABLE PrescriptionItems (
    PrescriptionID INT NOT NULL,
    MedicationID INT NOT NULL,
    Dosage VARCHAR(100),
    Quantity INT NOT NULL,

    PRIMARY KEY (PrescriptionID, MedicationID),

    FOREIGN KEY (PrescriptionID) REFERENCES Prescriptions(PrescriptionID),

    FOREIGN KEY (MedicationID) REFERENCES Medications(MedicationID)
);

#DML
USE clinic_db;

INSERT INTO Specialties (SpecialtyID, Description)
VALUES
(1, 'Dentistry'),
(2, 'Cardiology'),
(3, 'Dermatology'),
(4, 'Pediatrics'),
(5, 'Orthopedics');




INSERT INTO Patients
(PatientID, Name, Gender, BloodType, DateOfBirth, NationalID)
VALUES
(1, 'Ahmed Mohamed', 'Male', 'A+', '2000-05-15', '12345678901234'),
(2, 'Sara Ali', 'Female', 'O+', '1998-08-20', '22345678901234'),
(3, 'Omar Hassan', 'Male', 'B+', '1995-02-10', '32345678901234'),
(4, 'Mona Ahmed', 'Female', 'AB+', '2002-11-25', '42345678901234'),
(5, 'Youssef Samir', 'Male', 'O-', '1990-07-12', '52345678901234');




INSERT INTO ExamRooms (RoomID, RoomType, Floor)
VALUES
(1, 'Dental Room', 1),
(2, 'Cardiology Room', 2),
(3, 'Skin Examination Room', 1),
(4, 'Pediatric Room', 3),
(5, 'Orthopedic Room', 2);




INSERT INTO Staff (StaffID, Name, Role, HireDate)
VALUES
(1, 'Mariam Adel', 'Receptionist', '2022-01-10'),
(2, 'Hany Mostafa', 'Nurse', '2021-05-15'),
(3, 'Nour Ahmed', 'Accountant', '2023-03-20'),
(4, 'Khaled Samy', 'Assistant', '2020-09-01'),
(5, 'Salma Tarek', 'Receptionist', '2024-02-12');




INSERT INTO Doctors
(DoctorID, SpecialtyID, Name, Phone, LicenseNumber)
VALUES
(1, 1, 'Dr. Ahmed Khaled', '01011111111', 'DOC1001'),
(2, 2, 'Dr. Sara Mahmoud', '01022222222', 'DOC1002'),
(3, 3, 'Dr. Mohamed Ali', '01033333333', 'DOC1003'),
(4, 4, 'Dr. Heba Samir', '01044444444', 'DOC1004'),
(5, 5, 'Dr. Yasser Omar', '01055555555', 'DOC1005');



INSERT INTO Appointments
(AppointmentID, PatientID, DoctorID, RoomID, StaffID,
 AppointmentDate, AppointmentTime)
VALUES
(1, 1, 1, 1, 1, '2026-11-23', '10:00:00'),
(2, 2, 2, 2, 2, '2026-11-23', '11:00:00'),
(3, 3, 3, 3, 1, '2026-11-24', '12:00:00'),
(4, 4, 4, 4, 5, '2026-11-24', '13:00:00'),
(5, 5, 5, 5, 4, '2026-11-25', '14:00:00');




INSERT INTO Invoices
(InvoiceID, AppointmentID, Amount, PaymentMethod)
VALUES
(1, 1, 500, 'Cash'),
(2, 2, 700, 'Visa'),
(3, 3, 400, 'Cash'),
(4, 4, 350, 'Credit Card'),
(5, 5, 600, 'Cash');




INSERT INTO MedicalRecords
(RecordID, AppointmentID, Diagnosis, FollowUpDate)
VALUES
(1, 1, 'Tooth Decay', '2026-12-01'),
(2, 2, 'High Blood Pressure', '2026-12-05'),
(3, 3, 'Skin Allergy', '2026-12-03'),
(4, 4, 'Common Cold', '2026-12-02'),
(5, 5, 'Knee Pain', '2026-12-10');




INSERT INTO Prescriptions
(PrescriptionID, RecordID)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);




INSERT INTO Medications
(MedicationID, MedicationName, StockQuantity)
VALUES
(1, 'Paracetamol', 100),
(2, 'Amoxicillin', 80),
(3, 'Ibuprofen', 60),
(4, 'Vitamin C', 120),
(5, 'Antihistamine', 50);




UPDATE Patients
SET Name = 'Ahmed Mohamed Ali'
WHERE PatientID = 1;




UPDATE Patients
SET BloodType = 'B+'
WHERE PatientID = 2;




UPDATE Doctors
SET Phone = '01112345678'
WHERE DoctorID = 1;




UPDATE Appointments
SET AppointmentDate = '2026-11-26'
WHERE AppointmentID = 1;




UPDATE Appointments
SET AppointmentTime = '15:00:00'
WHERE AppointmentID = 2;




UPDATE Invoices
SET Amount = 600
WHERE InvoiceID = 1;




UPDATE MedicalRecords
SET Diagnosis = 'Severe Tooth Decay'
WHERE RecordID = 1;




UPDATE MedicalRecords
SET FollowUpDate = '2026-12-15'
WHERE RecordID = 2;



UPDATE Medications
SET StockQuantity = 150
WHERE MedicationID = 1;




UPDATE Staff
SET Role = 'Senior Nurse'
WHERE StaffID = 2;



DELETE FROM Prescriptions
WHERE PrescriptionID = 5;




DELETE FROM MedicalRecords
WHERE RecordID = 5;




DELETE FROM Invoices
WHERE InvoiceID = 5;



DELETE FROM Appointments
WHERE AppointmentID = 5;




DELETE FROM Patients
WHERE PatientID = 5;




DELETE FROM Doctors
WHERE DoctorID = 5;




DELETE FROM ExamRooms
WHERE RoomID = 5;




DELETE FROM Staff
WHERE StaffID = 4;




DELETE FROM Specialties
WHERE SpecialtyID = 5;




DELETE FROM Medications
WHERE MedicationID = 5;



SELECT *
FROM Patients;




SELECT *
FROM Doctors;




SELECT *
FROM Appointments;




SELECT *
FROM Patients
WHERE Gender = 'Female';



SELECT *
FROM Patients
WHERE DateOfBirth > '2000-01-01';




SELECT *
FROM Medications
WHERE StockQuantity > 50;




SELECT *
FROM Invoices
WHERE Amount > 400;




SELECT *
FROM Appointments
WHERE AppointmentDate = '2026-11-23';



SELECT *
FROM Patients
ORDER BY Name ASC;




SELECT * FROM Invoices ORDER BY Amount DESC LIMIT 5;




SELECT
    P.Name AS PatientName,
    A.AppointmentDate,
    A.AppointmentTime
FROM Patients P
INNER JOIN Appointments A
ON P.PatientID = A.PatientID;




SELECT
    D.Name AS DoctorName,
    S.Description AS Specialty
FROM Doctors D
INNER JOIN Specialties S
ON D.SpecialtyID = S.SpecialtyID;




SELECT
    A.AppointmentID,
    D.Name AS DoctorName,
    A.AppointmentDate,
    A.AppointmentTime
FROM Appointments A
INNER JOIN Doctors D
ON A.DoctorID = D.DoctorID;




SELECT
    A.AppointmentID,
    R.RoomType,
    R.Floor
FROM Appointments A
INNER JOIN ExamRooms R
ON A.RoomID = R.RoomID;


SELECT
    A.AppointmentID,
    S.Name AS StaffName,
    S.Role
FROM Appointments A
INNER JOIN Staff S
ON A.StaffID = S.StaffID;




SELECT
    P.Name AS PatientName,
    I.Amount,
    I.PaymentMethod
FROM Patients P
INNER JOIN Appointments A
ON P.PatientID = A.PatientID
INNER JOIN Invoices I
ON A.AppointmentID = I.AppointmentID;



SELECT
    P.Name AS PatientName,
    MR.Diagnosis,
    MR.FollowUpDate
FROM Patients P
INNER JOIN Appointments A
ON P.PatientID = A.PatientID
INNER JOIN MedicalRecords MR
ON A.AppointmentID = MR.AppointmentID;


SELECT
    PR.PrescriptionID,
    MR.Diagnosis,
    MR.FollowUpDate
FROM Prescriptions PR
INNER JOIN MedicalRecords MR
ON PR.RecordID = MR.RecordID;


SELECT COUNT(*) AS TotalPatients
FROM Patients;


SELECT SUM(Amount) AS TotalRevenue
FROM Invoices;


SELECT AVG(Amount) AS AverageInvoice
FROM Invoices;




SELECT MAX(Amount) AS MaximumInvoice
FROM Invoices;



SELECT MIN(Amount) AS MinimumInvoice
FROM Invoices;




SELECT
    DoctorID,
    COUNT(*) AS TotalAppointments
FROM Appointments
GROUP BY DoctorID;




SELECT
    Gender,
    COUNT(*) AS TotalPatients
FROM Patients
GROUP BY Gender;



SELECT
    PaymentMethod,
    SUM(Amount) AS TotalRevenue
FROM Invoices
GROUP BY PaymentMethod;




SELECT
    MedicationName,
    SUM(StockQuantity) AS TotalStock
FROM Medications
GROUP BY MedicationName;




SELECT
    DoctorID,
    COUNT(*) AS TotalAppointments
FROM Appointments
GROUP BY DoctorID
HAVING COUNT(*) > 1;




SELECT
    PaymentMethod,
    SUM(Amount) AS TotalRevenue
FROM Invoices
GROUP BY PaymentMethod
HAVING SUM(Amount) > 500;




SELECT
    Gender,
    COUNT(*) AS TotalPatients
FROM Patients
GROUP BY Gender
HAVING COUNT(*) > 2;




SELECT *
FROM Patients
WHERE PatientID IN
(
    SELECT PatientID
    FROM Appointments
);




SELECT *
FROM Invoices
WHERE Amount >
(
    SELECT AVG(Amount)
    FROM Invoices
);



SELECT *
FROM Doctors
WHERE DoctorID IN
(
    SELECT DoctorID
    FROM Appointments
);




SELECT *
FROM Medications
WHERE StockQuantity >
(
    SELECT AVG(StockQuantity)
    FROM Medications
);

USE clinic_db;

SELECT
    A.AppointmentID,
    A.AppointmentDate,
    A.AppointmentTime,
    P.Name AS PatientName,
    D.Name AS DoctorName,
    S.Description AS Specialty,
    ER.RoomType,
    ER.Floor
FROM Appointments A
INNER JOIN Patients P ON A.PatientID = P.PatientID
INNER JOIN Doctors D ON A.DoctorID = D.DoctorID
INNER JOIN Specialties S ON D.SpecialtyID = S.SpecialtyID
LEFT JOIN ExamRooms ER ON A.RoomID = ER.RoomID
ORDER BY A.AppointmentDate, A.AppointmentTime;

USE clinic_db;

SELECT
    P.PatientID,
    P.Name AS PatientName,
    A.AppointmentID,
    A.AppointmentDate,
    MR.Diagnosis,
    MR.FollowUpDate,
    I.InvoiceID,
    I.Amount AS InvoiceAmount,
    I.PaymentMethod
FROM Patients P
INNER JOIN Appointments A ON P.PatientID = A.PatientID
LEFT JOIN MedicalRecords MR ON A.AppointmentID = MR.AppointmentID
LEFT JOIN Invoices I ON A.AppointmentID = I.AppointmentID
ORDER BY A.AppointmentDate DESC, P.Name ASC;



USE clinic_db;

SELECT
    P.PatientID,
    P.Name AS PatientName,
    A.AppointmentDate,
    MR.Diagnosis,
    PR.PrescriptionID,
    M.MedicationName,
    PI.Dosage,
    PI.Quantity
FROM Prescriptions PR
INNER JOIN MedicalRecords MR ON PR.RecordID = MR.RecordID
INNER JOIN Appointments A ON MR.AppointmentID = A.AppointmentID
INNER JOIN Patients P ON A.PatientID = P.PatientID
INNER JOIN PrescriptionItems PI ON PR.PrescriptionID = PI.PrescriptionID
INNER JOIN Medications M ON PI.MedicationID = M.MedicationID
ORDER BY PR.PrescriptionID, M.MedicationName;



USE clinic_db;

-- Search patients by partial name
SELECT
    PatientID,
    Name,
    Gender,
    BloodType,
    DateOfBirth,
    NationalID
FROM Patients
WHERE Name LIKE '%Ahmed%';


SELECT
    D.DoctorID,
    D.Name AS DoctorName,
    S.Description AS Specialty,
    D.Phone,
    D.LicenseNumber
FROM Doctors D
INNER JOIN Specialties S ON D.SpecialtyID = S.SpecialtyID
WHERE D.Name LIKE '%Sara%';


SELECT
    A.AppointmentID,
    A.AppointmentDate,
    A.AppointmentTime,
    P.Name AS PatientName,
    D.Name AS DoctorName
FROM Appointments A
INNER JOIN Patients P ON A.PatientID = P.PatientID
INNER JOIN Doctors D ON A.DoctorID = D.DoctorID
WHERE A.AppointmentDate BETWEEN '2026-11-23' AND '2026-11-26'
ORDER BY A.AppointmentDate, A.AppointmentTime;


SELECT
    A.AppointmentID,
    A.AppointmentDate,
    A.AppointmentTime,
    P.Name AS PatientName,
    ER.RoomType
FROM Appointments A
INNER JOIN Patients P ON A.PatientID = P.PatientID
LEFT JOIN ExamRooms ER ON A.RoomID = ER.RoomID
WHERE A.DoctorID = 1
ORDER BY A.AppointmentDate, A.AppointmentTime;


SELECT
    MedicationID,
    MedicationName,
    StockQuantity
FROM Medications
WHERE StockQuantity < 70
ORDER BY StockQuantity ASC;

USE clinic_db;


SELECT
    S.SpecialtyID,
    S.Description AS Specialty,
    COALESCE(SUM(I.Amount), 0) AS TotalRevenue
FROM Specialties S
LEFT JOIN Doctors D ON S.SpecialtyID = D.SpecialtyID
LEFT JOIN Appointments A ON D.DoctorID = A.DoctorID
LEFT JOIN Invoices I ON A.AppointmentID = I.AppointmentID
GROUP BY S.SpecialtyID, S.Description
ORDER BY TotalRevenue DESC;


SELECT
    D.DoctorID,
    D.Name AS DoctorName,
    COALESCE(SUM(I.Amount), 0) AS TotalRevenue
FROM Doctors D
LEFT JOIN Appointments A ON D.DoctorID = A.DoctorID
LEFT JOIN Invoices I ON A.AppointmentID = I.AppointmentID
GROUP BY D.DoctorID, D.Name
ORDER BY TotalRevenue DESC;


SELECT
    ER.RoomID,
    ER.RoomType,
    ER.Floor,
    COUNT(A.AppointmentID) AS TotalAppointments
FROM ExamRooms ER
LEFT JOIN Appointments A ON ER.RoomID = A.RoomID
GROUP BY ER.RoomID, ER.RoomType, ER.Floor
ORDER BY ER.Floor, ER.RoomID;

SELECT
    P.PatientID,
    P.Name,
    P.Gender,
    P.DateOfBirth
FROM Patients P
LEFT JOIN Appointments A ON P.PatientID = A.PatientID
WHERE A.AppointmentID IS NULL;