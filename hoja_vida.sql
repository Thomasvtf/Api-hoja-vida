-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-09-2026 a las 03:26:01
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `hoja_vida`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursos`
--

CREATE TABLE `cursos` (
  `id` int(11) NOT NULL,
  `hoja_vida_id` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cursos`
--

INSERT INTO `cursos` (`id`, `hoja_vida_id`, `nombre`) VALUES
(2, 1, 'English does work II'),
(3, 1, 'English does work III'),
(4, 1, 'English does work level I'),
(5, 1, 'React'),
(6, 2, 'English work level I');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudios`
--

CREATE TABLE `estudios` (
  `id` int(11) NOT NULL,
  `hoja_vida_id` int(11) NOT NULL,
  `nivel` varchar(100) DEFAULT NULL,
  `institucion` varchar(150) DEFAULT NULL,
  `titulo` varchar(150) DEFAULT NULL,
  `anio_graduacion` year(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estudios`
--

INSERT INTO `estudios` (`id`, `hoja_vida_id`, `nivel`, `institucion`, `titulo`, `anio_graduacion`) VALUES
(2, 1, 'tecnologo', 'sena', 'tecnologo', '2025'),
(3, 1, 'curso bocetacion', 'sena', 'curso bocetacion', '2026'),
(4, 1, 'bachiller', 'externado simon bolivar', 'bachiller', '2023'),
(8, 2, 'tecnico', 'sena', 'tecnico', '2024');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `experiencias`
--

CREATE TABLE `experiencias` (
  `id` int(11) NOT NULL,
  `hoja_vida_id` int(11) NOT NULL,
  `empresa` varchar(150) NOT NULL,
  `cargo` varchar(100) DEFAULT NULL,
  `tiempo` varchar(100) DEFAULT NULL,
  `funciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `experiencias`
--

INSERT INTO `experiencias` (`id`, `hoja_vida_id`, `empresa`, `cargo`, `tiempo`, `funciones`) VALUES
(1, 1, 'omni.pro', 'Desarrollador', '1 año', 'Desarrollo de front-end'),
(3, 1, 'bia energy', 'Desarrollador', '1 año', 'Desarrollador front-end'),
(4, 2, 'sena', 'desarrollador', '1 año', 'desarrollo de front-end y back-end');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `habilidades`
--

CREATE TABLE `habilidades` (
  `id` int(11) NOT NULL,
  `experiencias_id` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `habilidades`
--

INSERT INTO `habilidades` (`id`, `experiencias_id`, `nombre`) VALUES
(2, 1, 'Aprendizaje rápido'),
(3, 1, 'aprendizaje rapido'),
(5, 4, 'comunicacion'),
(7, 4, 'diseño');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `hojas_vida`
--

CREATE TABLE `hojas_vida` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `edad` int(11) DEFAULT NULL,
  `ciudad` varchar(100) DEFAULT NULL,
  `correo` varchar(150) NOT NULL,
  `fotografia` varchar(255) DEFAULT NULL,
  `programa` varchar(150) DEFAULT NULL,
  `ficha` varchar(20) DEFAULT NULL,
  `jornada` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `hojas_vida`
--

INSERT INTO `hojas_vida` (`id`, `nombre`, `edad`, `ciudad`, `correo`, `fotografia`, `programa`, `ficha`, `jornada`) VALUES
(1, 'Thomas', 19, 'Bogotá', 'thomas@gmail.com', 'foto', 'ADSO', '2222', 'diurna'),
(2, 'Daniela', 21, 'bogota', 'dani@gmail.com', 'foto', 'ADSO', '2217', 'diurna');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hoja_vida_id` (`hoja_vida_id`);

--
-- Indices de la tabla `estudios`
--
ALTER TABLE `estudios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hoja_vida_id` (`hoja_vida_id`);

--
-- Indices de la tabla `experiencias`
--
ALTER TABLE `experiencias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hoja_vida_id` (`hoja_vida_id`);

--
-- Indices de la tabla `habilidades`
--
ALTER TABLE `habilidades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `experiencias_id` (`experiencias_id`);

--
-- Indices de la tabla `hojas_vida`
--
ALTER TABLE `hojas_vida`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD UNIQUE KEY `id` (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cursos`
--
ALTER TABLE `cursos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `estudios`
--
ALTER TABLE `estudios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `experiencias`
--
ALTER TABLE `experiencias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `habilidades`
--
ALTER TABLE `habilidades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `hojas_vida`
--
ALTER TABLE `hojas_vida`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD CONSTRAINT `cursos_ibfk_1` FOREIGN KEY (`hoja_vida_id`) REFERENCES `hojas_vida` (`id`);

--
-- Filtros para la tabla `estudios`
--
ALTER TABLE `estudios`
  ADD CONSTRAINT `estudios_ibfk_1` FOREIGN KEY (`hoja_vida_id`) REFERENCES `hojas_vida` (`id`);

--
-- Filtros para la tabla `experiencias`
--
ALTER TABLE `experiencias`
  ADD CONSTRAINT `experiencias_ibfk_1` FOREIGN KEY (`hoja_vida_id`) REFERENCES `hojas_vida` (`id`);

--
-- Filtros para la tabla `habilidades`
--
ALTER TABLE `habilidades`
  ADD CONSTRAINT `habilidades_ibfk_1` FOREIGN KEY (`experiencias_id`) REFERENCES `experiencias` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
