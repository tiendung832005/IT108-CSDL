CREATE TABLE tblPhim (
    PhimID INT PRIMARY KEY AUTO_INCREMENT,
    Ten_phim NVARCHAR(30),
    Loai_phim NVARCHAR(25),
    Thoi_gian INT
);

CREATE TABLE tblPhong (
    PhongID INT PRIMARY KEY AUTO_INCREMENT,
    Ten_phong NVARCHAR(20),
    Trang_thai TINYINT
);

CREATE TABLE tblGhe (
    GheID INT PRIMARY KEY AUTO_INCREMENT,
    PhongID INT,
    So_ghe VARCHAR(10),
    FOREIGN KEY (PhongID) REFERENCES tblPhong(PhongID) ON DELETE CASCADE
);

CREATE TABLE tblVe (
    PhimID INT,
    GheID INT,
    Ngay_chieu DATETIME,
    Trang_thai NVARCHAR(20),
    FOREIGN KEY (PhimID) REFERENCES tblPhim(PhimID) ON DELETE CASCADE,
    FOREIGN KEY (GheID) REFERENCES tblGhe(GheID) ON DELETE CASCADE
);
INSERT INTO tblPhim (Ten_phim, Loai_phim, Thoi_gian) VALUES
('Em bé Hà Nội', 'Tâm lý', 90),
('Nhiệm vụ bất khả thi', 'Hành động', 100),
('Dị nhân', 'Viễn tưởng', 90),
('Cuốn theo chiều gió', 'Tình cảm', 120);

INSERT INTO tblPhong (Ten_phong, Trang_thai) VALUES
('Phòng chiếu 1', 1),
('Phòng chiếu 2', 1),
('Phòng chiếu 3', 0);

INSERT INTO tblGhe (PhongID, So_ghe) VALUES
(1, 'A3'),
(1, 'B5'),
(2, 'A7'),
(2, 'D1'),
(3, 'T2');

INSERT INTO tblVe (PhimID, GheID, Ngay_chieu, Trang_thai) VALUES
(1, 1, '2008-10-20', 'Đã bán'),
(1, 3, '2008-11-20', 'Đã bán'),
(1, 4, '2008-12-23', 'Đã bán'),
(2, 1, '2009-02-14', 'Đã bán'),
(3, 1, '2009-02-14', 'Đã bán'),
(2, 5, '2009-03-08', 'Chưa bán'),
(2, 3, '2009-03-08', 'Chưa bán');

SELECT * FROM tblPhim ORDER BY Thoi_gian;

SELECT Ten_phim FROM tblPhim ORDER BY Thoi_gian DESC LIMIT 1;

SELECT Ten_phim FROM tblPhim ORDER BY Thoi_gian ASC LIMIT 1;

SELECT So_ghe FROM tblGhe WHERE So_ghe LIKE 'A%';

ALTER TABLE tblPhong MODIFY COLUMN Trang_thai VARCHAR(25);


DELIMITER //
CREATE PROCEDURE UpdateAndShowPhong()
BEGIN
    UPDATE tblPhong 
    SET Trang_thai = CASE 
        WHEN Trang_thai = '0' THEN 'Đang sửa'
        WHEN Trang_thai = '1' THEN 'Đang sử dụng'
        ELSE 'Unknown'
    END;
    
    SELECT * FROM tblPhong;
END //
DELIMITER ;
CALL UpdateAndShowPhong();

SELECT Ten_phim FROM tblPhim WHERE LENGTH(Ten_phim) > 15 AND LENGTH(Ten_phim) < 25;


SELECT CONCAT(Ten_phong, ' - ', Trang_thai) AS 'Trạng thái phòng chiếu' FROM tblPhong;

CREATE VIEW tblRank AS
SELECT ROW_NUMBER() OVER (ORDER BY Ten_phim) AS STT, Ten_phim, Thoi_gian FROM tblPhim;

ALTER TABLE tblPhim ADD COLUMN Mo_ta NVARCHAR(255);

UPDATE tblPhim SET Mo_ta = CONCAT('Đây là bộ phim thể loại ', Loai_phim);
SELECT * FROM tblPhim;

UPDATE tblPhim SET Mo_ta = REPLACE(Mo_ta, 'bộ phim', 'film');
SELECT * FROM tblPhim;

ALTER TABLE tblGhe DROP FOREIGN KEY tblGhe_ibfk_1;
ALTER TABLE tblVe DROP FOREIGN KEY tblVe_ibfk_1;
ALTER TABLE tblVe DROP FOREIGN KEY tblVe_ibfk_2;

DELETE FROM tblGhe;

SELECT Ngay_chieu, DATE_ADD(Ngay_chieu, INTERVAL 5000 MINUTE) AS 'Ngày chiếu +5000 phút' FROM tblVe;