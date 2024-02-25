-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le :  Dim 25 fév. 2024 à 21:29
-- Version du serveur :  10.1.36-MariaDB
-- Version de PHP :  5.6.38

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `app`
--

-- --------------------------------------------------------

--
-- Structure de la table `code`
--

CREATE TABLE `code` (
  `id` int(11) NOT NULL,
  `Code` int(10) NOT NULL,
  `disease` varchar(300) DEFAULT NULL,
  `login` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `code`
--

INSERT INTO `code` (`id`, `Code`, `disease`, `login`) VALUES
(17, 123, 'disease', 'wa'),
(18, 1234, 'disease', 'sa'),
(31, 123456, 'nothing', 'saz'),
(32, 12, 'nothing', 'az');

-- --------------------------------------------------------

--
-- Structure de la table `groupe`
--

CREATE TABLE `groupe` (
  `id` int(11) NOT NULL,
  `Code` int(11) DEFAULT NULL,
  `message` varchar(10000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `groupe`
--

INSERT INTO `groupe` (`id`, `Code`, `message`) VALUES
(55, 123, 'Hello!'),
(73, 123, 'Hy'),
(130, 1234, 'hy '),
(131, 0, '');

-- --------------------------------------------------------

--
-- Structure de la table `reminder`
--

CREATE TABLE `reminder` (
  `id` int(10) NOT NULL,
  `Code` varchar(20) NOT NULL,
  `med_name` varchar(50) NOT NULL,
  `nombre_de_fois` int(10) NOT NULL,
  `avant_apres` varchar(10) NOT NULL,
  `time1` time(5) NOT NULL,
  `time2` time(5) NOT NULL,
  `time3` time(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `reminder`
--

INSERT INTO `reminder` (`id`, `Code`, `med_name`, `nombre_de_fois`, `avant_apres`, `time1`, `time2`, `time3`) VALUES
(5, '', '', 0, '', '00:00:00.00000', '00:00:00.00000', '00:00:00.00000'),
(6, '123', 'dolip', 2, 'after', '16:15:00.00000', '12:00:00.00000', '00:00:00.00000'),
(7, '123', 'saz', 2, 'before', '18:22:00.00000', '00:00:00.00000', '00:00:00.00000');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `code`
--
ALTER TABLE `code`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `groupe`
--
ALTER TABLE `groupe`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `reminder`
--
ALTER TABLE `reminder`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `code`
--
ALTER TABLE `code`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT pour la table `groupe`
--
ALTER TABLE `groupe`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=132;

--
-- AUTO_INCREMENT pour la table `reminder`
--
ALTER TABLE `reminder`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
