-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 26, 2025 at 04:57 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wt24`
--

-- --------------------------------------------------------

--
-- Table structure for table `korisniks`
--

CREATE TABLE `korisniks` (
  `id` int(11) NOT NULL,
  `ime` varchar(255) NOT NULL,
  `prezime` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `admin` tinyint(1) DEFAULT 0,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `korisniks`
--

INSERT INTO `korisniks` (`id`, `ime`, `prezime`, `email`, `password`, `admin`, `createdAt`, `updatedAt`) VALUES
(2, 'User', 'User', 'user', '$2b$10$wpC/MqMeKGlDIPw2cQSzmOoxolPPwZzTFhmHV59xNM596yATE0tWa', 0, '2025-01-21 23:48:20', '2025-01-21 23:48:20'),
(3, 'Admin', 'Admin', 'admin', '$2b$10$S07WQyXIu/bdLUuZGY.HsuhuQIfMsC1R9OaW6wdgPrMJ/U2ek0x3S', 1, '2025-01-24 16:08:08', '2025-01-24 16:08:08');

-- --------------------------------------------------------

--
-- Table structure for table `nekretninas`
--

CREATE TABLE `nekretninas` (
  `id` int(11) NOT NULL,
  `naziv` varchar(255) NOT NULL,
  `lokacija` varchar(255) NOT NULL,
  `kvadratura` float NOT NULL,
  `cijena` float NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `tip_nekretnine` varchar(255) NOT NULL,
  `tip_grijanja` varchar(255) NOT NULL,
  `godina_izgradnje` int(11) NOT NULL,
  `datum_objave` datetime NOT NULL,
  `opis` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nekretninas`
--

INSERT INTO `nekretninas` (`id`, `naziv`, `lokacija`, `kvadratura`, `cijena`, `createdAt`, `updatedAt`, `tip_nekretnine`, `tip_grijanja`, `godina_izgradnje`, `datum_objave`, `opis`) VALUES
(1, 'Useljiv stan Sarajevo', 'Novo Sarajevo', 58, 232000, '2025-01-22 00:40:18', '2025-01-22 00:53:00', 'Stan', 'plin', 2019, '2023-10-01 07:00:00', 'Sociis natoque penatibus.'),
(2, 'Mali poslovni prostor', 'Centar', 20, 70000, '2025-01-22 00:40:18', '2025-01-22 00:40:18', 'Poslovni prostor', 'struja', 2005, '2023-08-20 07:00:00', 'Magnis dis parturient montes.'),
(3, 'Useljiv stan Sarajevo', 'Novo Sarajevo', 58, 232000, '2025-01-22 00:40:18', '2025-01-22 00:40:18', 'Stan moj novi', 'plin', 2018, '2022-10-01 07:00:00', 'Sociis natoque penatibus.'),
(4, 'Useljiv stan Sarajevo', 'Novo Sarajevo', 58, 232000, '2025-01-22 00:40:18', '2025-01-22 00:40:18', 'Stan', 'plin', 2022, '2024-10-01 07:00:00', 'Sociis natoque penatibus.'),
(5, 'Useljiv stan Sarajevo', 'Novo Sarajevo', 58, 232000, '2025-01-22 00:40:18', '2025-01-22 00:40:18', 'Stan', 'plin', 2019, '2025-10-01 07:00:00', 'Sociis natoque penatibus.'),
(7, 'Useljiv stan Sarajevo', 'Novo Sarajevo', 58, 232000, '2025-01-22 00:40:18', '2025-01-22 00:40:18', 'Stan', 'plin', 2019, '2020-10-01 07:00:00', 'Sociis natoque penatibus.'),
(8, 'Useljiv stan Sarajevo', 'Novo Sarajevo', 58, 232000, '2025-01-22 00:40:18', '2025-01-22 00:40:18', 'Stan', 'plin', 2019, '2011-10-01 07:00:00', 'Sociis natoque penatibus.');

-- --------------------------------------------------------

--
-- Table structure for table `ponudas`
--

CREATE TABLE `ponudas` (
  `id` int(11) NOT NULL,
  `tekst` text NOT NULL,
  `cijenaPonude` float NOT NULL,
  `datumPonude` datetime NOT NULL,
  `odbijenaPonuda` tinyint(1) DEFAULT 0,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `korisnikId` int(11) DEFAULT NULL,
  `nekretninaId` int(11) DEFAULT NULL,
  `parentPonudaId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ponudas`
--

INSERT INTO `ponudas` (`id`, `tekst`, `cijenaPonude`, `datumPonude`, `odbijenaPonuda`, `createdAt`, `updatedAt`, `korisnikId`, `nekretninaId`, `parentPonudaId`) VALUES
(2, 'Ponuda za nekretninu', 100000, '2023-10-01 00:00:00', 0, '2025-01-24 15:50:08', '2025-01-24 15:50:08', 2, 5, NULL),
(3, 'asd', 3, '2025-01-25 00:00:00', 0, '2025-01-24 23:23:54', '2025-01-24 23:23:54', 3, 1, NULL),
(4, 'Prva ponuda', 10, '2025-01-29 00:00:00', 0, '2025-01-24 23:38:52', '2025-01-24 23:38:52', 3, 4, NULL),
(11, 'Test', 10000000, '2025-01-25 00:00:00', 0, '2025-01-24 23:56:22', '2025-01-24 23:56:22', 3, 5, 2),
(13, 'Finalna ponuda test', 100000000, '2025-01-25 00:00:00', 0, '2025-01-25 00:05:11', '2025-01-25 00:05:11', 2, 5, 2),
(15, 'asd', 121212000, '2025-01-25 00:00:00', 0, '2025-01-25 00:20:34', '2025-01-25 00:20:34', 2, 7, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `upits`
--

CREATE TABLE `upits` (
  `id` int(11) NOT NULL,
  `tekst` text NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `korisnikId` int(11) DEFAULT NULL,
  `nekretninaId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `upits`
--

INSERT INTO `upits` (`id`, `tekst`, `createdAt`, `updatedAt`, `korisnikId`, `nekretninaId`) VALUES
(2, 'Phasellus viverra nulla.', '2025-01-22 00:53:00', '2025-01-22 00:53:00', 2, 1),
(3, 'Integer tincidunt.', '2025-01-22 00:53:00', '2025-01-22 00:53:00', 2, 2),
(6, 'Ovo je testni upit', '2025-01-24 16:22:14', '2025-01-24 16:22:14', 2, 1),
(9, 'asd', '2025-01-24 19:28:21', '2025-01-24 19:28:21', 2, 1),
(11, 'testni upit 100ti', '2025-01-24 19:49:06', '2025-01-24 19:49:06', 2, 1),
(13, 'asd', '2025-01-24 23:23:25', '2025-01-24 23:23:25', 3, 1),
(14, 'Prva upit', '2025-01-24 23:38:17', '2025-01-24 23:38:17', 3, 4),
(15, 'Test upita', '2025-01-24 23:52:22', '2025-01-24 23:52:22', 2, 5),
(16, 'Drugi upit test', '2025-01-24 23:56:49', '2025-01-24 23:56:49', 3, 5),
(17, 'finalni test', '2025-01-25 00:03:51', '2025-01-25 00:03:51', 2, 5),
(18, 'Test finalni upita', '2025-01-25 00:10:35', '2025-01-25 00:10:35', 2, 5),
(19, 'Prvi upit test', '2025-01-25 00:18:54', '2025-01-25 00:18:54', 2, 7);

-- --------------------------------------------------------

--
-- Table structure for table `zahtjevs`
--

CREATE TABLE `zahtjevs` (
  `id` int(11) NOT NULL,
  `tekst` text NOT NULL,
  `trazeniDatum` datetime NOT NULL,
  `odobren` tinyint(1) DEFAULT 0,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `korisnikId` int(11) DEFAULT NULL,
  `nekretninaId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `zahtjevs`
--

INSERT INTO `zahtjevs` (`id`, `tekst`, `trazeniDatum`, `odobren`, `createdAt`, `updatedAt`, `korisnikId`, `nekretninaId`) VALUES
(1, 'Zahtjev za pregledom nekretnine ODGOVOR ADMINA: Odobreno', '2025-10-01 00:00:00', 1, '2025-01-22 13:08:43', '2025-01-22 13:10:53', 2, 1),
(6, 'Test dodavanja zahtjeva', '2025-01-25 00:00:00', 0, '2025-01-24 19:54:29', '2025-01-24 19:54:29', 2, 1),
(8, 'Test Zahtjeva', '2025-01-25 00:00:00', 0, '2025-01-24 23:52:36', '2025-01-24 23:52:36', 2, 5),
(9, 'Zahtijev drugi test', '2025-01-25 00:00:00', 0, '2025-01-24 23:57:06', '2025-01-24 23:57:06', 3, 5),
(10, 'asd', '2025-01-26 00:00:00', 0, '2025-01-25 00:10:21', '2025-01-25 00:10:21', 2, 5),
(13, 'Prvi zahtjev234', '2025-01-27 00:00:00', 0, '2025-01-25 00:29:36', '2025-01-25 00:29:36', 2, 7);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `korisniks`
--
ALTER TABLE `korisniks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `email_2` (`email`),
  ADD UNIQUE KEY `email_3` (`email`),
  ADD UNIQUE KEY `email_4` (`email`),
  ADD UNIQUE KEY `email_5` (`email`),
  ADD UNIQUE KEY `email_6` (`email`);

--
-- Indexes for table `nekretninas`
--
ALTER TABLE `nekretninas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ponudas`
--
ALTER TABLE `ponudas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `korisnikId` (`korisnikId`),
  ADD KEY `nekretninaId` (`nekretninaId`),
  ADD KEY `parentPonudaId` (`parentPonudaId`);

--
-- Indexes for table `upits`
--
ALTER TABLE `upits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `korisnikId` (`korisnikId`),
  ADD KEY `nekretninaId` (`nekretninaId`);

--
-- Indexes for table `zahtjevs`
--
ALTER TABLE `zahtjevs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `korisnikId` (`korisnikId`),
  ADD KEY `nekretninaId` (`nekretninaId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `korisniks`
--
ALTER TABLE `korisniks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `nekretninas`
--
ALTER TABLE `nekretninas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `ponudas`
--
ALTER TABLE `ponudas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `upits`
--
ALTER TABLE `upits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `zahtjevs`
--
ALTER TABLE `zahtjevs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ponudas`
--
ALTER TABLE `ponudas`
  ADD CONSTRAINT `Ponudas_korisnikId_foreign_idx` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Ponudas_nekretninaId_foreign_idx` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Ponudas_parentPonudaId_foreign_idx` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_1` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_10` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_100` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_101` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_102` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_103` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_104` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_105` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_106` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_107` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_108` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_109` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_11` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_110` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_111` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_112` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_113` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_114` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_115` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_116` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_117` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_118` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_119` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_12` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_120` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_121` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_122` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_123` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_124` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_125` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_126` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_127` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_128` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_129` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_13` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_130` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_131` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_132` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_133` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_134` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_135` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_136` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_137` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_138` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_139` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_14` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_140` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_141` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_142` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_143` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_144` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_145` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_146` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_147` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_148` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_149` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_15` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_150` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_151` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_152` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_153` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_154` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_155` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_156` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_157` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_158` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_159` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_16` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_160` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_161` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_162` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_163` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_164` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_165` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_166` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_167` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_168` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_169` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_17` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_170` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_171` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_172` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_173` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_174` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_175` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_176` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_177` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_178` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_179` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_18` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_180` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_181` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_182` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_183` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_184` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_185` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_186` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_187` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_188` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_189` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_19` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_190` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_191` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_192` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_193` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_194` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_195` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_2` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_20` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_21` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_22` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_23` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_24` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_25` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_26` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_27` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_28` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_29` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_3` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_30` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_31` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_32` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_33` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_34` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_35` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_36` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_37` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_38` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_39` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_4` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_40` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_41` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_42` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_43` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_44` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_45` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_46` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_47` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_48` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_49` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_5` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_50` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_51` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_52` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_53` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_54` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_55` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_56` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_57` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_58` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_59` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_6` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_60` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_61` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_62` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_63` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_64` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_65` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_66` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_67` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_68` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_69` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_7` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_70` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_71` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_72` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_73` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_74` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_75` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_76` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_77` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_78` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_79` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_8` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_80` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_81` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_82` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_83` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_84` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_85` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_86` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_87` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_88` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_89` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_9` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_90` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_91` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_92` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_93` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_94` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_95` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_96` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_97` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_98` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ponudas_ibfk_99` FOREIGN KEY (`parentPonudaId`) REFERENCES `ponudas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `upits`
--
ALTER TABLE `upits`
  ADD CONSTRAINT `Upits_korisnikId_foreign_idx` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Upits_nekretninaId_foreign_idx` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_1` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_10` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_100` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_101` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_102` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_103` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_104` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_105` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_106` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_107` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_108` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_109` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_11` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_110` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_111` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_112` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_113` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_114` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_115` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_116` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_117` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_118` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_119` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_12` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_120` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_121` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_122` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_123` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_124` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_125` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_126` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_127` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_128` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_129` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_13` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_130` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_14` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_15` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_16` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_17` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_18` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_19` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_2` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_20` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_21` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_22` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_23` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_24` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_25` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_26` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_27` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_28` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_29` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_3` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_30` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_31` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_32` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_33` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_34` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_35` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_36` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_37` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_38` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_39` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_4` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_40` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_41` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_42` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_43` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_44` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_45` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_46` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_47` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_48` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_49` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_5` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_50` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_51` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_52` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_53` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_54` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_55` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_56` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_57` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_58` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_59` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_6` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_60` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_61` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_62` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_63` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_64` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_65` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_66` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_67` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_68` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_69` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_7` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_70` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_71` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_72` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_73` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_74` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_75` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_76` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_77` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_78` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_79` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_8` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_80` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_81` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_82` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_83` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_84` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_85` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_86` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_87` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_88` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_89` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_9` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_90` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_91` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_92` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_93` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_94` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_95` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_96` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_97` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_98` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `upits_ibfk_99` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `zahtjevs`
--
ALTER TABLE `zahtjevs`
  ADD CONSTRAINT `Zahtjevs_korisnikId_foreign_idx` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Zahtjevs_nekretninaId_foreign_idx` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_1` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_10` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_100` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_101` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_102` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_103` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_104` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_105` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_106` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_107` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_108` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_109` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_11` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_110` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_111` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_112` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_113` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_114` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_115` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_116` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_117` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_118` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_119` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_12` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_120` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_121` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_122` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_123` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_124` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_125` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_126` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_127` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_128` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_129` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_13` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_130` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_14` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_15` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_16` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_17` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_18` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_19` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_2` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_20` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_21` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_22` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_23` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_24` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_25` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_26` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_27` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_28` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_29` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_3` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_30` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_31` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_32` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_33` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_34` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_35` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_36` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_37` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_38` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_39` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_4` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_40` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_41` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_42` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_43` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_44` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_45` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_46` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_47` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_48` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_49` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_5` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_50` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_51` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_52` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_53` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_54` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_55` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_56` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_57` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_58` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_59` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_6` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_60` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_61` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_62` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_63` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_64` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_65` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_66` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_67` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_68` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_69` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_7` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_70` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_71` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_72` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_73` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_74` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_75` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_76` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_77` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_78` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_79` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_8` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_80` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_81` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_82` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_83` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_84` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_85` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_86` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_87` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_88` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_89` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_9` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_90` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_91` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_92` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_93` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_94` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_95` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_96` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_97` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_98` FOREIGN KEY (`nekretninaId`) REFERENCES `nekretninas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `zahtjevs_ibfk_99` FOREIGN KEY (`korisnikId`) REFERENCES `korisniks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
