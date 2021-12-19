-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-12-2021 a las 11:18:40
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
-- Estructura de tabla para la tabla `consultas`
--

CREATE TABLE `consultas` (
  `id_consulta` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `mail` varchar(200) NOT NULL,
  `mensaje` varchar(255) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `consultas`
--

INSERT INTO `consultas` (`id_consulta`, `nombre`, `apellido`, `mail`, `mensaje`, `fecha`) VALUES
(1, 'Francisco', 'Stuven', 'frano@stuven.com', 'Esta es la primer prueba de contacto.  consulta', '2021-12-12 20:42:28'),
(2, 'Francisco', 'Stuven', 'frano@stuven.com', 'Esta es la prueba para ver si guarda la fecha de la consulta', '2021-12-12 00:00:00');

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

--
-- Volcado de datos para la tabla `feriados_cerrado`
--

INSERT INTO `feriados_cerrado` (`id_fecha`, `id_deporte`, `f_cierre`, `anual`) VALUES
(1, 2, '2021-12-06', 0),
(2, 2, '2021-12-07', 0),
(3, 2, '2021-12-08', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarios`
--

CREATE TABLE `horarios` (
  `id_horario` int(11) NOT NULL,
  `id_deporte` int(11) NOT NULL,
  `d_desde` int(1) NOT NULL,
  `d_hasta` int(1) NOT NULL,
  `d_hora` time NOT NULL,
  `h_hora` time NOT NULL,
  `intervalo` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `horarios`
--

INSERT INTO `horarios` (`id_horario`, `id_deporte`, `d_desde`, `d_hasta`, `d_hora`, `h_hora`, `intervalo`) VALUES
(1, 2, 1, 5, '08:00:00', '14:00:00', 30),
(2, 2, 1, 5, '17:00:00', '20:00:00', 30);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `turnos`
--

CREATE TABLE `turnos` (
  `id_turno` int(11) NOT NULL,
  `id_deporte` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `f_turno` datetime NOT NULL,
  `cancelado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `turnos`
--

INSERT INTO `turnos` (`id_turno`, `id_deporte`, `id_usuario`, `f_turno`, `cancelado`) VALUES
(3, 2, 1, '2021-12-09 08:30:00', 0),
(4, 2, 2, '2021-12-09 10:00:00', 0),
(5, 2, 2, '2021-12-09 12:00:00', 0),
(6, 2, 2, '2021-12-10 11:00:00', 0),
(7, 2, 3, '2021-12-10 12:00:00', 0),
(8, 2, 7, '2021-12-10 13:00:00', 0),
(9, 2, 4, '2021-12-10 13:00:00', 0),
(10, 2, 5, '2021-12-10 13:00:00', 0),
(11, 2, 3, '2021-12-10 17:34:31', 0),
(12, 2, 6, '2021-12-10 13:00:00', 0),
(13, 2, 6, '2021-12-13 09:00:00', 0);

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
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `mail`, `clave`, `nombre`, `domicilio`, `f_nacimiento`, `telefono`, `bloqueado`) VALUES
(1, 'frano@gmail.com', '1234', 'Francisco Stuven', 'av. del mar 23235', '1967-03-19', '662377281', 0),
(2, 'fran@tc.en', '1234', 'Francisquito Stuven', 'las carretas 234', '1988-06-18', '9938477363', 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `consultas`
--
ALTER TABLE `consultas`
  ADD PRIMARY KEY (`id_consulta`);

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
  ADD KEY `id_deportet` (`id_deporte`),
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
-- AUTO_INCREMENT de la tabla `consultas`
--
ALTER TABLE `consultas`
  MODIFY `id_consulta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `deporte`
--
ALTER TABLE `deporte`
  MODIFY `id_deporte` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `feriados_cerrado`
--
ALTER TABLE `feriados_cerrado`
  MODIFY `id_fecha` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `horarios`
--
ALTER TABLE `horarios`
  MODIFY `id_horario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `turnos`
--
ALTER TABLE `turnos`
  MODIFY `id_turno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
