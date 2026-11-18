-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-11-2026 a las 01:14:45
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
(1, 1, 'Arquitectura de Microservicios con Docker'),
(2, 1, 'TypeScript Avanzado'),
(3, 2, 'Prototipado Interactivo y Sistemas de Diseño'),
(4, 2, 'Maquetación Web con HTML5 y CSS3'),
(5, 3, 'Administración de Bases de Datos PostgreSQL y MySQL'),
(6, 3, 'Seguridad en Aplicaciones Web'),
(7, 4, 'Fundamentos de Computación en la Nube AWS'),
(8, 4, 'Automatización con Scripts en Python'),
(9, 5, 'Desarrollo de APIs REST con Flask y JWT'),
(10, 5, 'Metodologías Ágiles Scrum');

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
(1, 1, 'Tecnólogo', 'SENA - Centro de Electricidad, Electrónica y Telecomunicaciones', 'Análisis y Desarrollo de Software', '2026'),
(2, 2, 'Tecnólogo', 'SENA - Centro de Servicios y Gestión Empresarial', 'Desarrollo de Medios Gráficos Visuales', '2026'),
(3, 3, 'Tecnólogo', 'SENA - Centro Industrial de Mantenimiento Integral', 'Análisis y Desarrollo de Software', '2025'),
(4, 4, 'Tecnólogo', 'SENA - Centro para la Industria Petroquímica', 'Implementación de Infraestructura de Tecnologías de la Información', '2026'),
(5, 5, 'Tecnólogo', 'SENA - Centro de Diseño e Innovación Tecnológica Industrial', 'Análisis y Desarrollo de Software', '2026');

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
(1, 1, 'NubeAndina Tech', 'Desarrollador Full Stack Junior', '9 meses', 'Desarrollo de módulos web en React y mantenimiento de endpoints en Python.'),
(2, 2, 'Agencia Pixelado', 'Diseñadora UI', '7 meses', 'Creación de wireframes, guías de estilo y diseño de interfaces móviles.'),
(3, 3, 'Sistemas Santander SAS', 'Analista de Base de Datos Junior', '1 año', 'Optimización de consultas SQL, respaldos y migración de datos.'),
(4, 4, 'Logística Portuaria TIC', 'Asistente de Infraestructura Cloud', '8 meses', 'Despliegue de servidores virtuales, monitoreo de servicios y soporte nivel 2.'),
(5, 5, 'Cafetech Soluciones', 'Desarrollador Backend Python', '11 meses', 'Integración de pasarelas de pago, autenticación con tokens y pruebas unitarias.');

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
(1, 1, 'TypeScript'),
(2, 1, 'Docker'),
(3, 1, 'Liderazgo'),
(4, 2, 'UI Design'),
(5, 2, 'CSS3'),
(6, 2, 'Empatía con el usuario'),
(7, 3, 'SQL'),
(8, 3, 'Modelado de datos'),
(9, 3, 'Pensamiento analítico'),
(10, 4, 'AWS'),
(11, 4, 'Automatización'),
(12, 4, 'Adaptabilidad'),
(13, 5, 'Python'),
(14, 5, 'Scrum'),
(15, 5, 'Gestión del tiempo');

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
(1, 'Alejandro Mendoza', 21, 'Bogotá', 'alejandro.mendoza@gmail.com', 'alejandro.jpg', 'ADSO', '2890201', 'Diurna', 1),
(2, 'Natalia Herrera', 20, 'Medellín', 'natalia.herrera@gmail.com', 'natalia.jpg', 'Desarrollo de Medios Gráficos Visuales', '2890202', 'Mixta', 2),
(3, 'Diego Montoya', 23, 'Bucaramanga', 'diego.montoya@gmail.com', 'diego.jpg', 'ADSO', '2890203', 'Nocturna', 3),
(4, 'Paula Jiménez', 22, 'Cartagena', 'paula.jimenez@gmail.com', 'paula.jpg', 'Implementación de Infraestructura de TI', '2890204', 'Diurna', 4),
(5, 'Felipe Ríos', 25, 'Pereira', 'felipe.rios@gmail.com', 'felipe.jpg', 'ADSO', '2890205', 'Fines de semana', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `rol` enum('aprendiz','reclutador') NOT NULL DEFAULT 'aprendiz',
  `estado` tinyint(1) NOT NULL DEFAULT 1,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `correo`, `password`, `rol`, `estado`, `fecha_creacion`) VALUES
(1, 'alejandro mendoza', 'alejandro.mendoza@gmail.com', 'scrypt:32768:8:1$mnsFIj6BFhPVmeV6$0130a467c3981f4c2d0a8551a5fa434f1756560375905b6d93c5dba83eeac50f86548efc9d548308dea0d7ab596bf3f8e7d02d703dce1b738c162b87431802ff', 'aprendiz', 1, '2026-11-18 00:09:24'),
(2, 'natalia herrera', 'natalia.herrera@gmail.com', 'scrypt:32768:8:1$zn8nP4F0XF9QoVa0$679a8109c0be734eacb34e4af716d22aab3ce9a49afce2542526416539a37d7da93ed780c064f036fa9683d3208716bc43a9bd8f2455a28751a7f7f64367d14b', 'aprendiz', 1, '2026-11-18 00:09:24'),
(3, 'diego montoya', 'diego.montoya@gmail.com', 'scrypt:32768:8:1$3j6tZltarQXwRqT0$994c64269cef79b340a9d02d25b28947ec1bab99a648dc5ff9b4b8ef17572317748be1a77ffb007c1c2d227290bacc7f46f9bed123861a76addfdf47cdf26ae8', 'aprendiz', 1, '2026-11-18 00:09:24'),
(4, 'paula jiménez', 'paula.jimenez@gmail.com', 'scrypt:32768:8:1$VB7rbE3NRq7ak6CJ$a9e56f7d9f89dfa9f758010affe76eb88180f88b8da4ca4bc59339f090f507ea244b18b48f15bb1014947f0de7ee96c409596895c9031c56edbad4e4fe8b1339', 'aprendiz', 1, '2026-11-18 00:09:25'),
(5, 'felipe ríos', 'felipe.rios@gmail.com', 'scrypt:32768:8:1$bXsSYb0EcyJllC7B$58d6f56cea518181f5722435d56355050dca36f08b6a0edf830a73922c01fe84f8522a87dd2847fe1a52e673ae828ed03e1d0c424060a14ab8e0d1d1a1e95735', 'aprendiz', 1, '2026-11-18 00:09:25'),
(6, 'laura reclutadora', 'laura.reclutadora@gmail.com', 'scrypt:32768:8:1$zy3bEUufQjQ8vQlf$e69876fa5140670c6c6790b4aa49f7ac461298cbf818356ac68a2828f6422f41c6266a09c8831d857b754d387abbfe1b52e6e954e5e50435e6d2c37a384e52b4', 'reclutador', 1, '2026-11-18 00:09:25');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `estudios`
--
ALTER TABLE `estudios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `experiencias`
--
ALTER TABLE `experiencias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `habilidades`
--
ALTER TABLE `habilidades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `hojas_vida`
--
ALTER TABLE `hojas_vida`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
