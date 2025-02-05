SELECT 
    CONCAT(p.FullName, ' (', YEAR(a.AppointmentDate) - YEAR(p.DateOfBirth), ') - ', d.FullName) AS PatientDoctorInfo,
    a.AppointmentDate,
    m.Diagnosis
FROM appointments a
JOIN patients p ON a.PatientID = p.PatientID
JOIN doctors d ON a.DoctorID = d.DoctorID
JOIN medicalrecords m ON a.PatientID = m.PatientID AND a.DoctorID = m.DoctorID
ORDER BY a.AppointmentDate ASC;

SELECT p.FullName AS PatientName, YEAR(a.AppointmentDate) - YEAR(p.DateOfBirth) AS AgeAtAppointment,a.AppointmentDate,
    CASE 
        WHEN YEAR(a.AppointmentDate) - YEAR(p.DateOfBirth) > 50 THEN 'Nguy cơ cao'
        WHEN YEAR(a.AppointmentDate) - YEAR(p.DateOfBirth) BETWEEN 30 AND 50 THEN 'Nguy cơ trung bình'
        ELSE 'Nguy cơ thấp'
    END AS RiskLevel
FROM appointments a
JOIN patients p ON a.PatientID = p.PatientID
ORDER BY a.AppointmentDate ASC;

DELETE FROM appointments
WHERE PatientID IN (
    SELECT a.PatientID
    FROM appointments a
    JOIN patients p ON a.PatientID = p.PatientID
    JOIN doctors d ON a.DoctorID = d.DoctorID
    WHERE YEAR(a.AppointmentDate) - YEAR(p.DateOfBirth) > 30
    AND d.Specialization IN ('Noi Tong Quat', 'Chan Thuong Chinh Hinh')
);

SELECT p.FullName AS PatientName, d.Specialization, YEAR(a.AppointmentDate) - YEAR(p.DateOfBirth) AS AgeAtAppointment
FROM appointments a
JOIN patients p ON a.PatientID = p.PatientID
JOIN doctors d ON a.DoctorID = d.DoctorID
ORDER BY a.AppointmentDate ASC;


