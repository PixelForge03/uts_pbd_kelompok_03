-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 03, 2026 at 10:53 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `uts_pbd_kelompok_04`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `hitung_nilai_akhir` ()   BEGIN

    UPDATE nilai_praktikum
    SET nilai_akhir =
        (nilai_tugas * 0.30) +
        (nilai_kuis * 0.30) +
        (nilai_uts * 0.40);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `isi_log_nilai` ()   BEGIN

    INSERT INTO log_rekap_nilai (
        nim,
        kode_mk,
        nilai_akhir,
        grade,
        bobot,
        status_lulus,
        keterangan,
        waktu_proses
    )
    SELECT
        nim,
        kode_mk,
        nilai_akhir,
        grade,
        bobot,
        status_lulus,
        'Rekap berhasil',
        NOW()
    FROM nilai_praktikum;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rekap_nilai_per_mk` (IN `p_kode_mk` VARCHAR(10))   BEGIN

    SELECT
        nim,
        kode_mk,
        nilai_akhir,
        grade,
        status_lulus
    FROM nilai_praktikum
    WHERE kode_mk = p_kode_mk;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rekap_semua_nilai` ()   BEGIN

    UPDATE nilai_praktikum
    SET nilai_akhir =
        (nilai_tugas * 0.30) +
        (nilai_kuis * 0.30) +
        (nilai_uts * 0.40);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampil_nim_cursor` ()   BEGIN

    DECLARE done INT DEFAULT FALSE;
    DECLARE v_nim VARCHAR(10);

    DECLARE cur CURSOR FOR
        SELECT nim FROM mahasiswa;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = TRUE;

    OPEN cur;

    read_loop: LOOP

        FETCH cur INTO v_nim;

        IF done THEN
            LEAVE read_loop;
        END IF;

    END LOOP;

    CLOSE cur;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tentukan_bobot` ()   BEGIN

    UPDATE nilai_praktikum np
    JOIN grade_nilai gn
        ON np.grade = gn.grade
    SET np.bobot = gn.bobot;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tentukan_grade` ()   BEGIN

    UPDATE nilai_praktikum
    SET grade =
    CASE
        WHEN nilai_akhir BETWEEN 93.00 AND 100.00 THEN 'A'
        WHEN nilai_akhir BETWEEN 85.00 AND 92.99 THEN 'A-'
        WHEN nilai_akhir BETWEEN 81.00 AND 84.99 THEN 'B+'
        WHEN nilai_akhir BETWEEN 75.00 AND 80.99 THEN 'B'
        WHEN nilai_akhir BETWEEN 71.00 AND 74.99 THEN 'B-'
        WHEN nilai_akhir BETWEEN 66.00 AND 70.99 THEN 'C+'
        WHEN nilai_akhir BETWEEN 61.00 AND 65.99 THEN 'C'
        WHEN nilai_akhir BETWEEN 56.00 AND 60.99 THEN 'C-'
        WHEN nilai_akhir BETWEEN 40.00 AND 55.99 THEN 'D'
        ELSE 'E'
    END;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tentukan_status` ()   BEGIN

    UPDATE nilai_praktikum
    SET status_lulus =
    CASE
        WHEN grade IN ('A','A-','B+','B','B-','C+','C')
        THEN 'LULUS'
        ELSE 'TIDAK LULUS'
    END;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tes` ()   BEGIN
    SELECT 'Hello World';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `test_cursor` ()   BEGIN

    DECLARE done INT DEFAULT FALSE;
    DECLARE v_nim VARCHAR(10);

    DECLARE cur CURSOR FOR
        SELECT nim FROM mahasiswa;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = TRUE;

    OPEN cur;

    read_loop: LOOP

        FETCH cur INTO v_nim;

        IF done THEN
            LEAVE read_loop;
        END IF;

    END LOOP;

    CLOSE cur;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `dosen`
--

CREATE TABLE `dosen` (
  `kode_dosen` varchar(10) NOT NULL,
  `nama_dosen` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dosen`
--

INSERT INTO `dosen` (`kode_dosen`, `nama_dosen`, `email`) VALUES
('DS001', 'Abdul Malik', 'malik@kampus.ac.id'),
('DS002', 'Budi Santoso', 'budi@kampus.ac.id');

-- --------------------------------------------------------

--
-- Table structure for table `grade_nilai`
--

CREATE TABLE `grade_nilai` (
  `grade` varchar(5) NOT NULL,
  `bobot` decimal(4,2) DEFAULT NULL,
  `nilai_bawah` decimal(5,2) DEFAULT NULL,
  `nilai_atas` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `grade_nilai`
--

INSERT INTO `grade_nilai` (`grade`, `bobot`, `nilai_bawah`, `nilai_atas`) VALUES
('A', 4.00, 93.00, 100.00),
('A-', 3.75, 85.00, 92.99),
('B', 3.25, 75.00, 80.99),
('B+', 3.50, 81.00, 84.99),
('B-', 3.00, 71.00, 74.99),
('C', 2.50, 61.00, 65.99),
('C+', 2.75, 66.00, 70.99),
('C-', 2.00, 56.00, 60.99),
('D', 1.00, 40.00, 55.99),
('E', 0.00, 0.00, 39.99);

-- --------------------------------------------------------

--
-- Table structure for table `log_rekap_nilai`
--

CREATE TABLE `log_rekap_nilai` (
  `id_log` int(11) NOT NULL,
  `nim` varchar(10) DEFAULT NULL,
  `kode_mk` varchar(10) DEFAULT NULL,
  `nilai_akhir` decimal(5,2) DEFAULT NULL,
  `grade` varchar(5) DEFAULT NULL,
  `bobot` decimal(4,2) DEFAULT NULL,
  `status_lulus` varchar(20) DEFAULT NULL,
  `keterangan` varchar(100) DEFAULT NULL,
  `waktu_proses` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `log_rekap_nilai`
--

INSERT INTO `log_rekap_nilai` (`id_log`, `nim`, `kode_mk`, `nilai_akhir`, `grade`, `bobot`, `status_lulus`, `keterangan`, `waktu_proses`) VALUES
(1, '230001', 'MK001', 85.50, 'A-', 3.75, 'LULUS', 'Rekap berhasil', '2026-06-01 20:58:07'),
(2, '230002', 'MK001', 75.50, 'B', 3.25, 'LULUS', 'Rekap berhasil', '2026-06-01 20:58:07'),
(3, '230003', 'MK001', 92.60, 'A-', 3.75, 'LULUS', 'Rekap berhasil', '2026-06-01 20:58:07'),
(4, '230004', 'MK001', 65.50, 'C', 2.50, 'LULUS', 'Rekap berhasil', '2026-06-01 20:58:07'),
(5, '230005', 'MK001', 55.50, 'D', 1.00, 'TIDAK LULUS', 'Rekap berhasil', '2026-06-01 20:58:07'),
(6, '230006', 'MK002', 87.60, 'A-', 3.75, 'LULUS', 'Rekap berhasil', '2026-06-01 20:58:07'),
(7, '230007', 'MK002', 78.90, 'B', 3.25, 'LULUS', 'Rekap berhasil', '2026-06-01 20:58:07'),
(8, '230008', 'MK002', 67.90, 'C+', 2.75, 'LULUS', 'Rekap berhasil', '2026-06-01 20:58:07'),
(9, '230009', 'MK002', 57.90, 'C-', 2.00, 'TIDAK LULUS', 'Rekap berhasil', '2026-06-01 20:58:07'),
(10, '230010', 'MK002', 40.50, 'D', 1.00, 'TIDAK LULUS', 'Rekap berhasil', '2026-06-01 20:58:07'),
(11, '230011', 'MK003', 96.50, 'A', 4.00, 'LULUS', 'Rekap berhasil', '2026-06-01 20:58:07'),
(12, '230012', 'MK003', 82.20, 'B+', 3.50, 'LULUS', 'Rekap berhasil', '2026-06-01 20:58:07'),
(13, '230013', 'MK003', 74.20, 'B-', 3.00, 'LULUS', 'Rekap berhasil', '2026-06-01 20:58:07'),
(14, '230014', 'MK003', 69.20, 'C+', 2.75, 'LULUS', 'Rekap berhasil', '2026-06-01 20:58:07'),
(15, '230015', 'MK003', 60.20, 'C-', 2.00, 'TIDAK LULUS', 'Rekap berhasil', '2026-06-01 20:58:07'),
(16, '230016', 'MK001', 50.50, 'D', 1.00, 'TIDAK LULUS', 'Rekap berhasil', '2026-06-01 20:58:07'),
(17, '230017', 'MK002', 80.00, 'B', 3.25, 'LULUS', 'Rekap berhasil', '2026-06-01 20:58:07'),
(18, '230018', 'MK003', 87.90, 'A-', 3.75, 'LULUS', 'Rekap berhasil', '2026-06-01 20:58:07'),
(19, '230019', 'MK001', 64.20, 'C', 2.50, 'LULUS', 'Rekap berhasil', '2026-06-01 20:58:07'),
(20, '230020', 'MK002', 94.20, 'A', 4.00, 'LULUS', 'Rekap berhasil', '2026-06-01 20:58:07'),
(32, '230001', 'MK001', 85.50, 'A-', 3.75, 'LULUS', 'Rekap berhasil', '2026-06-01 21:11:37'),
(33, '230002', 'MK001', 75.50, 'B', 3.25, 'LULUS', 'Rekap berhasil', '2026-06-01 21:11:37'),
(34, '230003', 'MK001', 92.60, 'A-', 3.75, 'LULUS', 'Rekap berhasil', '2026-06-01 21:11:37'),
(35, '230004', 'MK001', 65.50, 'C', 2.50, 'LULUS', 'Rekap berhasil', '2026-06-01 21:11:37'),
(36, '230005', 'MK001', 55.50, 'D', 1.00, 'TIDAK LULUS', 'Rekap berhasil', '2026-06-01 21:11:37'),
(37, '230006', 'MK002', 87.60, 'A-', 3.75, 'LULUS', 'Rekap berhasil', '2026-06-01 21:11:37'),
(38, '230007', 'MK002', 78.90, 'B', 3.25, 'LULUS', 'Rekap berhasil', '2026-06-01 21:11:37'),
(39, '230008', 'MK002', 67.90, 'C+', 2.75, 'LULUS', 'Rekap berhasil', '2026-06-01 21:11:37'),
(40, '230009', 'MK002', 57.90, 'C-', 2.00, 'TIDAK LULUS', 'Rekap berhasil', '2026-06-01 21:11:37'),
(41, '230010', 'MK002', 40.50, 'D', 1.00, 'TIDAK LULUS', 'Rekap berhasil', '2026-06-01 21:11:37'),
(42, '230011', 'MK003', 96.50, 'A', 4.00, 'LULUS', 'Rekap berhasil', '2026-06-01 21:11:37'),
(43, '230012', 'MK003', 82.20, 'B+', 3.50, 'LULUS', 'Rekap berhasil', '2026-06-01 21:11:37'),
(44, '230013', 'MK003', 74.20, 'B-', 3.00, 'LULUS', 'Rekap berhasil', '2026-06-01 21:11:37'),
(45, '230014', 'MK003', 69.20, 'C+', 2.75, 'LULUS', 'Rekap berhasil', '2026-06-01 21:11:37'),
(46, '230015', 'MK003', 60.20, 'C-', 2.00, 'TIDAK LULUS', 'Rekap berhasil', '2026-06-01 21:11:37'),
(47, '230016', 'MK001', 50.50, 'D', 1.00, 'TIDAK LULUS', 'Rekap berhasil', '2026-06-01 21:11:37'),
(48, '230017', 'MK002', 80.00, 'B', 3.25, 'LULUS', 'Rekap berhasil', '2026-06-01 21:11:37'),
(49, '230018', 'MK003', 87.90, 'A-', 3.75, 'LULUS', 'Rekap berhasil', '2026-06-01 21:11:37'),
(50, '230019', 'MK001', 64.20, 'C', 2.50, 'LULUS', 'Rekap berhasil', '2026-06-01 21:11:37'),
(51, '230020', 'MK002', 94.20, 'A', 4.00, 'LULUS', 'Rekap berhasil', '2026-06-01 21:11:37');

-- --------------------------------------------------------

--
-- Table structure for table `mahasiswa`
--

CREATE TABLE `mahasiswa` (
  `nim` varchar(10) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `kelas` varchar(20) DEFAULT NULL,
  `angkatan` year(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mahasiswa`
--

INSERT INTO `mahasiswa` (`nim`, `nama`, `kelas`, `angkatan`) VALUES
('230001', 'Andi Saputra', 'IF-A', '2023'),
('230002', 'Budi Pratama', 'IF-A', '2023'),
('230003', 'Citra Lestari', 'IF-A', '2023'),
('230004', 'Dewi Anggraini', 'IF-A', '2023'),
('230005', 'Eko Prasetyo', 'IF-A', '2023'),
('230006', 'Fajar Hidayat', 'IF-B', '2023'),
('230007', 'Gina Marlina', 'IF-B', '2023'),
('230008', 'Hendra Wijaya', 'IF-B', '2023'),
('230009', 'Intan Permata', 'IF-B', '2023'),
('230010', 'Joko Susanto', 'IF-B', '2023'),
('230011', 'Kartika Sari', 'IF-C', '2023'),
('230012', 'Lukman Hakim', 'IF-C', '2023'),
('230013', 'Maya Putri', 'IF-C', '2023'),
('230014', 'Nanda Saputri', 'IF-C', '2023'),
('230015', 'Oki Setiawan', 'IF-C', '2023'),
('230016', 'Putri Ayu', 'IF-D', '2023'),
('230017', 'Rian Maulana', 'IF-D', '2023'),
('230018', 'Siti Nurhaliza', 'IF-D', '2023'),
('230019', 'Teguh Firmansyah', 'IF-D', '2023'),
('230020', 'Yuni Kartika', 'IF-D', '2023');

-- --------------------------------------------------------

--
-- Table structure for table `mata_kuliah`
--

CREATE TABLE `mata_kuliah` (
  `kode_mk` varchar(10) NOT NULL,
  `nama_mk` varchar(100) DEFAULT NULL,
  `sks` int(11) DEFAULT NULL,
  `semester` int(11) DEFAULT NULL,
  `kode_dosen` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mata_kuliah`
--

INSERT INTO `mata_kuliah` (`kode_mk`, `nama_mk`, `sks`, `semester`, `kode_dosen`) VALUES
('MK001', 'Pemrograman Basis Data', 3, 4, 'DS001'),
('MK002', 'Basis Data Lanjut', 3, 4, 'DS001'),
('MK003', 'Pemrograman Web', 3, 4, 'DS002');

-- --------------------------------------------------------

--
-- Table structure for table `nilai_praktikum`
--

CREATE TABLE `nilai_praktikum` (
  `id_nilai` int(11) NOT NULL,
  `nim` varchar(10) DEFAULT NULL,
  `kode_mk` varchar(10) DEFAULT NULL,
  `nilai_tugas` decimal(5,2) DEFAULT NULL,
  `nilai_kuis` decimal(5,2) DEFAULT NULL,
  `nilai_uts` decimal(5,2) DEFAULT NULL,
  `nilai_akhir` decimal(5,2) DEFAULT NULL,
  `grade` varchar(5) DEFAULT NULL,
  `bobot` decimal(4,2) DEFAULT NULL,
  `status_lulus` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nilai_praktikum`
--

INSERT INTO `nilai_praktikum` (`id_nilai`, `nim`, `kode_mk`, `nilai_tugas`, `nilai_kuis`, `nilai_uts`, `nilai_akhir`, `grade`, `bobot`, `status_lulus`) VALUES
(1, '230001', 'MK001', 80.00, 85.00, 90.00, 85.50, 'A-', 3.75, 'LULUS'),
(2, '230002', 'MK001', 70.00, 75.00, 80.00, 75.50, 'B', 3.25, 'LULUS'),
(3, '230003', 'MK001', 90.00, 92.00, 95.00, 92.60, 'A-', 3.75, 'LULUS'),
(4, '230004', 'MK001', 60.00, 65.00, 70.00, 65.50, 'C', 2.50, 'LULUS'),
(5, '230005', 'MK001', 50.00, 55.00, 60.00, 55.50, 'D', 1.00, 'TIDAK LULUS'),
(6, '230006', 'MK002', 88.00, 84.00, 90.00, 87.60, 'A-', 3.75, 'LULUS'),
(7, '230007', 'MK002', 76.00, 79.00, 81.00, 78.90, 'B', 3.25, 'LULUS'),
(8, '230008', 'MK002', 65.00, 68.00, 70.00, 67.90, 'C+', 2.75, 'LULUS'),
(9, '230009', 'MK002', 55.00, 58.00, 60.00, 57.90, 'C-', 2.00, 'TIDAK LULUS'),
(10, '230010', 'MK002', 35.00, 40.00, 45.00, 40.50, 'D', 1.00, 'TIDAK LULUS'),
(11, '230011', 'MK003', 95.00, 96.00, 98.00, 96.50, 'A', 4.00, 'LULUS'),
(12, '230012', 'MK003', 82.00, 80.00, 84.00, 82.20, 'B+', 3.50, 'LULUS'),
(13, '230013', 'MK003', 72.00, 74.00, 76.00, 74.20, 'B-', 3.00, 'LULUS'),
(14, '230014', 'MK003', 67.00, 69.00, 71.00, 69.20, 'C+', 2.75, 'LULUS'),
(15, '230015', 'MK003', 58.00, 60.00, 62.00, 60.20, 'C-', 2.00, 'TIDAK LULUS'),
(16, '230016', 'MK001', 45.00, 50.00, 55.00, 50.50, 'D', 1.00, 'TIDAK LULUS'),
(17, '230017', 'MK002', 78.00, 82.00, 80.00, 80.00, 'B', 3.25, 'LULUS'),
(18, '230018', 'MK003', 85.00, 88.00, 90.00, 87.90, 'A-', 3.75, 'LULUS'),
(19, '230019', 'MK001', 62.00, 64.00, 66.00, 64.20, 'C', 2.50, 'LULUS'),
(20, '230020', 'MK002', 92.00, 94.00, 96.00, 94.20, 'A', 4.00, 'LULUS');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dosen`
--
ALTER TABLE `dosen`
  ADD PRIMARY KEY (`kode_dosen`);

--
-- Indexes for table `grade_nilai`
--
ALTER TABLE `grade_nilai`
  ADD PRIMARY KEY (`grade`);

--
-- Indexes for table `log_rekap_nilai`
--
ALTER TABLE `log_rekap_nilai`
  ADD PRIMARY KEY (`id_log`);

--
-- Indexes for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`nim`);

--
-- Indexes for table `mata_kuliah`
--
ALTER TABLE `mata_kuliah`
  ADD PRIMARY KEY (`kode_mk`),
  ADD KEY `kode_dosen` (`kode_dosen`);

--
-- Indexes for table `nilai_praktikum`
--
ALTER TABLE `nilai_praktikum`
  ADD PRIMARY KEY (`id_nilai`),
  ADD KEY `nim` (`nim`),
  ADD KEY `kode_mk` (`kode_mk`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `log_rekap_nilai`
--
ALTER TABLE `log_rekap_nilai`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `nilai_praktikum`
--
ALTER TABLE `nilai_praktikum`
  MODIFY `id_nilai` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `mata_kuliah`
--
ALTER TABLE `mata_kuliah`
  ADD CONSTRAINT `mata_kuliah_ibfk_1` FOREIGN KEY (`kode_dosen`) REFERENCES `dosen` (`kode_dosen`);

--
-- Constraints for table `nilai_praktikum`
--
ALTER TABLE `nilai_praktikum`
  ADD CONSTRAINT `nilai_praktikum_ibfk_1` FOREIGN KEY (`nim`) REFERENCES `mahasiswa` (`nim`),
  ADD CONSTRAINT `nilai_praktikum_ibfk_2` FOREIGN KEY (`kode_mk`) REFERENCES `mata_kuliah` (`kode_mk`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
