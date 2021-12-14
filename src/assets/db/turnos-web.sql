-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-12-2021 a las 10:10:46
-- Versión del servidor: 10.4.21-MariaDB
-- Versión de PHP: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `turnos-web`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `deporte`
--

CREATE TABLE `deporte` (
  `id_deporte` int(11) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `anticipacion` int(6) NOT NULL,
  `usuarios_por_turno` int(6) NOT NULL,
  `desactivado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `deporte`
--

INSERT INTO `deporte` (`id_deporte`, `descripcion`, `anticipacion`, `usuarios_por_turno`, `desactivado`) VALUES
(1, 'BASKET', 6, 10, 0),
(2, 'GYMNASIO', 3, 5, 0),
(3, 'PADDLE', 2, 10, 0),
(4, 'GOLF', 2, 5, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `feriados_cerrado`
--

CREATE TABLE `feriados_cerrado` (
  `id_fecha` int(11) NOT NULL,
  `id_deporte` int(11) NOT NULL,
  `f_cierre` date NOT NULL COMMENT 'Fecha en que se encuetra cerrado ',
  `anual` tinyint(1) NOT NULL COMMENT 'es para saber si el anio que viene se repite a la misma fecha (dia)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarios`
--

CREATE TABLE `horarios` (
  `id_horario` int(11) NOT NULL,
  `id_deporte` int(11) NOT NULL,
  `d_desde` int(1) NOT NULL,
  `d_hasta` int(1) NOT NULL,
  `d_hora` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `h_hora` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `horarios`
--

INSERT INTO `horarios` (`id_horario`, `id_deporte`, `d_desde`, `d_hasta`, `d_hora`, `h_hora`) VALUES
(1, 2, 1, 6, '2021-12-02 08:58:10', '2021-12-02 13:00:00'),
(2, 2, 1, 5, '2021-12-02 13:00:00', '2021-12-02 19:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `turnos`
--

CREATE TABLE `turnos` (
  `id_turno` int(11) NOT NULL,
  `id_deportet` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `f_turno` datetime NOT NULL,
  `cancelado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `mail` varchar(100) NOT NULL,
  `clave` varchar(8) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `domicilio` varchar(100) NOT NULL,
  `f_nacimiento` date NOT NULL,
  `telefono` varchar(50) NOT NULL,
  `bloqueado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `deporte`
--
ALTER TABLE `deporte`
  ADD PRIMARY KEY (`id_deporte`);

--
-- Indices de la tabla `feriados_cerrado`
--
ALTER TABLE `feriados_cerrado`
  ADD PRIMARY KEY (`id_fecha`),
  ADD KEY `id_deporte` (`id_deporte`);

--
-- Indices de la tabla `horarios`
--
ALTER TABLE `horarios`
  ADD PRIMARY KEY (`id_horario`),
  ADD KEY `id_deporte` (`id_deporte`);

--
-- Indices de la tabla `turnos`
--
ALTER TABLE `turnos`
  ADD PRIMARY KEY (`id_turno`),
  ADD KEY `id_deportet` (`id_deportet`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_usuario_2` (`id_usuario`),
  ADD KEY `id_usuario_3` (`id_usuario`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `mail` (`mail`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `deporte`
--
ALTER TABLE `deporte`
  MODIFY `id_deporte` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `feriados_cerrado`
--
ALTER TABLE `feriados_cerrado`
  MODIFY `id_fecha` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `horarios`
--
ALTER TABLE `horarios`
  MODIFY `id_horario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `turnos`
--
ALTER TABLE `turnos`
  MODIFY `id_turno` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `horarios`
--
ALTER TABLE `horarios`
  ADD CONSTRAINT `horarios_ibfk_1` FOREIGN KEY (`id_deporte`) REFERENCES `deporte` (`id_deporte`);

--
-- Filtros para la tabla `turnos`
--
ALTER TABLE `turnos`
  ADD CONSTRAINT `turnos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `turnos_ibfk_2` FOREIGN KEY (`id_deportet`) REFERENCES `deporte` (`id_deporte`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
