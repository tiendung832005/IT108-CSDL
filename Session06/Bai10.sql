-- Xóa lịch hẹn đã qua liên quan đến bác sĩ "Phan Huong"
DELETE FROM appointments
WHERE DoctorID = (SELECT DoctorID FROM doctors WHERE FullName = 'Phan Huong')
  AND AppointmentDate < NOW();

-- Hiển thị lại danh sách lịch hẹn để kiểm chứng
SELECT 
    a.AppointmentID, 
    p.FullName AS PatientName, 
    d.FullName AS DoctorName, 
    a.AppointmentDate, 
    a.Status
FROM appointments a
JOIN patients p ON a.PatientID = p.PatientID
JOIN doctors d ON a.DoctorID = d.DoctorID
ORDER BY a.AppointmentDate;

-- Cập nhật trạng thái lịch hẹn trong tương lai thành "Dang chờ"
UPDATE appointments
SET Status = 'Dang chờ'
WHERE PatientID = (SELECT PatientID FROM patients WHERE FullName = 'Nguyen Van An')
  AND DoctorID = (SELECT DoctorID FROM doctors WHERE FullName = 'Phan Huong')
  AND AppointmentDate >= NOW();

-- Hiển thị lại danh sách lịch hẹn để kiểm chứng
SELECT 
    a.AppointmentID, 
    p.FullName AS PatientName, 
    d.FullName AS DoctorName, 
    a.AppointmentDate, 
    a.Status
FROM appointments a
JOIN patients p ON a.PatientID = p.PatientID
JOIN doctors d ON a.DoctorID = d.DoctorID
ORDER BY a.AppointmentDate;

SELECT 
    p.FullName AS PatientName,
    d.FullName AS DoctorName,
    a.AppointmentDate,
    m.Diagnosis
FROM 
    appointments a
JOIN 
    patients p ON a.PatientID = p.PatientID
JOIN 
    doctors d ON a.DoctorID = d.DoctorID
JOIN 
    medicalrecords m ON a.PatientID = m.PatientID AND a.DoctorID = m.DoctorID
WHERE 
    (SELECT COUNT(*) 
     FROM appointments a2
     WHERE a2.PatientID = a.PatientID AND a2.DoctorID = a.DoctorID) >= 2
ORDER BY 
    p.FullName, d.FullName, a.AppointmentDate;

SELECT 
    CONCAT('BỆNH NHÂN: ', UPPER(p.FullName), ' - BÁC SĨ: ', UPPER(d.FullName)) AS PatientDoctorInfo,
    a.AppointmentDate,
    m.Diagnosis,
    a.Status
FROM 
    appointments a
JOIN 
    patients p ON a.PatientID = p.PatientID
JOIN 
    doctors d ON a.DoctorID = d.DoctorID
JOIN 
    medicalrecords m ON a.PatientID = m.PatientID AND a.DoctorID = m.DoctorID
ORDER BY 
    a.AppointmentDate ASC;

SELECT 
    CONCAT('BỆNH NHÂN: ', UPPER(p.FullName), ' - BÁC SĨ: ', UPPER(d.FullName)) AS PatientDoctorInfo,
    a.AppointmentDate,
    m.Diagnosis,
    a.Status
FROM 
    appointments a
JOIN 
    patients p ON a.PatientID = p.PatientID
JOIN 
    doctors d ON a.DoctorID = d.DoctorID
JOIN 
    medicalrecords m ON a.PatientID = m.PatientID AND a.DoctorID = m.DoctorID
ORDER BY 
    a.AppointmentDate ASC;

