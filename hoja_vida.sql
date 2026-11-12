-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-11-2026 a las 17:21:48
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

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
(1, 3, 'React'),
(2, 3, 'python');

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
(1, 3, '', 'la aurora', 'bachiller academico', '2024');

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
(1, 3, 'bia energy', 'desarrolladora web', '1 año', 'desarrollo de front_end');

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
(1, 1, 'comunicacion'),
(2, 1, 'desarrollo');

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
  `jornada` varchar(50) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `hojas_vida`
--

INSERT INTO `hojas_vida` (`id`, `nombre`, `edad`, `ciudad`, `correo`, `fotografia`, `programa`, `ficha`, `jornada`, `usuario_id`) VALUES
(1, 'Low', 36, 'nuevo mundo', 'low@gmail.com', 'foto', 'ADSO', '2222', 'diurna', NULL),
(2, 'Low', 36, 'nuevo mundo', 'low@gmail.com', 'foto', 'ADSO', '2222', 'diurna', NULL),
(3, 'Daniela', 21, 'bogota', 'dani@gmail.com', 'blob:http://localhost:5173/73f1041d-79be-4035-a569-b031a7a988ce', 'ADSO', '2222', 'mixta', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `rol` enum('aprendiz','administrador') NOT NULL DEFAULT 'aprendiz',
  `estado` tinyint(1) NOT NULL DEFAULT 1,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `correo`, `password`, `rol`, `estado`, `fecha_creacion`) VALUES
(1, 'Daniela', 'dani@gmail.com', 'nose22012025', 'aprendiz', 0, '2026-11-10 05:00:00'),
(2, 'Thomas', 'thomas@gmail.com', 'nose22012025', 'aprendiz', 0, '2026-11-11 05:00:00'),
(3, 'Thomas Vargas', 'thomasv@gmail.com', 'nose22012025', 'aprendiz', 0, '2026-11-11 05:00:00'),
(4, 'Cobyto', 'cobyto@gmail.com', 'scrypt:32768:8:1$EoRpbJ6FqOSYi997$14522e953fc16ae450b03bc4bcbcc8d77404efb21129094eedbdff6034c3965f631c61b8c4b833803a8efbfb63e375b2c8602489f8eba3969a1fe6a74ce093b3', '', 1, '2026-11-12 16:19:02');

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
  ADD UNIQUE KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cursos`
--
ALTER TABLE `cursos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `estudios`
--
ALTER TABLE `estudios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `experiencias`
--
ALTER TABLE `experiencias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `habilidades`
--
ALTER TABLE `habilidades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `hojas_vida`
--
ALTER TABLE `hojas_vida`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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

--
-- Filtros para la tabla `hojas_vida`
--
ALTER TABLE `hojas_vida`
  ADD CONSTRAINT `fk_hoja_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
