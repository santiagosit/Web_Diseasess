-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 04-05-2025 a las 19:05:02
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
-- Base de datos: `agro_expertos`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_enfermedades_enfermedad`
--

CREATE TABLE `app_enfermedades_enfermedad` (
  `id` bigint(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `caracteristicas` longtext NOT NULL,
  `descripcion` longtext NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `app_enfermedades_enfermedad`
--

INSERT INTO `app_enfermedades_enfermedad` (`id`, `nombre`, `caracteristicas`, `descripcion`, `estado`) VALUES
(3, 'Tizón del maíz', 'Manchas negras en hojas y tallos', 'Causado por el hongo Exserohilum turcicum, afecta el maíz en condiciones húmedas.', 'Verificada'),
(4, 'Mildiu', 'Polvo blanco en la superficie de las hojas', 'Afecta vides y cucurbitáceas. Se desarrolla en climas húmedos y fríos.', 'Verificada'),
(5, 'Antracnosis', 'Lesiones oscuras hundidas en frutos y hojas', 'Causada por hongos del género Colletotrichum. Muy común en frutales tropicales.', 'Verificada'),
(6, 'Royas', 'Pústulas anaranjadas o marrones en el envés de las hojas', 'Hongos del género Puccinia. Atacan café, trigo y frijol.', 'Verificada'),
(7, 'Mancha angular', 'Manchas angulosas con halo amarillo', 'Bacteria que afecta frijol y otras leguminosas. Se transmite por agua y herramientas.', 'Verificada'),
(8, 'Fusariosis', 'Marchitez vascular y pudrición de raíz', 'Enfermedad causada por Fusarium oxysporum. Muy común en solanáceas.', 'Verificada'),
(9, 'Mancha púrpura', 'Manchas violáceas en hojas y tallos', 'Causada por Alternaria porri, afecta cebolla y ajo.', 'Verificada'),
(10, 'Podredumbre gris', 'Moho gris sobre flores y frutos', 'Botrytis cinerea afecta principalmente fresas, uvas y tomates.', 'En proceso'),
(11, 'Cancro bacteriano', 'Lesiones hundidas con exudado amarillento', 'Bacteria Clavibacter michiganensis. Afecta tomate y pimiento.', 'En proceso'),
(12, 'Virosis del pepino', 'Moteado y deformación foliar', 'Virus como el CMV transmitido por pulgones.', 'Verificada'),
(13, 'Mancha bacteriana', 'Lesiones acuosas que se tornan necróticas', 'Xanthomonas campestris en tomate y pimentón.', 'Verificada'),
(14, 'Oídio', 'Polvo blanco sobre hojas y brotes', 'Erysiphe spp. en cucurbitáceas y rosales.', 'En proceso'),
(15, 'Tizón temprano', 'Manchas concéntricas en hojas', 'Alternaria solani. Afecta papa y tomate.', 'Verificada'),
(16, 'Tizón tardío', 'Manchas acuosas y mal olor', 'Phytophthora infestans. Destruye rápidamente papa y tomate.', 'Verificada'),
(17, 'Mancha café del banano', 'Puntos marrones que se agrandan y necrosan', 'Mycosphaerella fijiensis, hongo que reduce la producción.', 'Verificada'),
(18, 'Escoba de bruja', 'Brotes anormales en ramificaciones', 'Moniliophthora perniciosa. Grave en cacao.', 'En proceso'),
(19, 'Mancha de asfalto', 'Manchas negras brillantes', 'Guignardia bidwellii, afecta hojas de vid.', 'Verificada'),
(20, 'Enanismo amarillo de la cebada', 'Hojas amarillas y acortamiento de tallo', 'Virus transmitido por pulgones. Causa pérdidas en cereales.', 'Verificada'),
(21, 'Mosaico del tabaco', 'Moteado verde claro y oscuro en hojas', 'Virus muy resistente que afecta a muchas solanáceas.', 'En proceso'),
(22, 'Mancha negra de los cítricos', 'Puntos negros con halo amarillo', 'Guignardia citricarpa. Provoca rechazo en exportación.', 'Verificada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_tratamientos_tratamiento`
--

CREATE TABLE `app_tratamientos_tratamiento` (
  `id` bigint(20) NOT NULL,
  `fecha_creacion` date NOT NULL,
  `descripcion` longtext NOT NULL,
  `duracion_total` int(11) NOT NULL,
  `dias_mejora` varchar(100) NOT NULL,
  `estado` varchar(20) NOT NULL,
  `recomendaciones` longtext DEFAULT NULL,
  `enfermedad_id` bigint(20) NOT NULL,
  `experto_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_usuarios_usuario`
--

CREATE TABLE `app_usuarios_usuario` (
  `id` bigint(20) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `rol` varchar(10) NOT NULL,
  `estado` varchar(10) NOT NULL,
  `especialidad` varchar(100) DEFAULT NULL,
  `dependencia` varchar(100) DEFAULT NULL,
  `documentos` varchar(100) DEFAULT NULL,
  `es_superadmin` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `app_usuarios_usuario`
--

INSERT INTO `app_usuarios_usuario` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `rol`, `estado`, `especialidad`, `dependencia`, `documentos`, `es_superadmin`) VALUES
(3, 'pbkdf2_sha256$600000$AZql2f9TjdRyy975AutSoL$W4nmtFdyxcH7P7Z41JMRtbkPZWRiyevDvh6GqjLxmzE=', '2025-04-30 20:56:59.131295', 1, 'Admin', 'SuperAdmin', '', 'herrerajohan2306@gmail.com', 1, 1, '2025-04-30 01:38:04.772030', 'admin', 'activo', NULL, NULL, '', 1),
(7, 'pbkdf2_sha256$600000$PyQwvuCst8pbFxXgmX7gcr$XIrmePm/S/YUGp3JShH5Z4zgSWj8R85PjFsXHak6YbE=', '2025-04-30 15:36:44.924292', 0, 'Karol', 'Karol', 'Rodriguez', 'karol@gmail.com', 0, 1, '2025-04-30 15:36:23.057195', 'admin', 'activo', NULL, NULL, '', 0),
(8, 'pbkdf2_sha256$600000$P7Ftd7y18wkm0z3gloJtbR$zZBad6LM21DXZeDwnm+hX+dASiXs9DFCKXlMeI1dcQM=', '2025-04-30 21:05:13.947390', 0, 'Johan', 'Johan', 'Herrera', 'herrerajohan2306@gmail.com', 0, 1, '2025-04-30 15:37:36.756920', 'experto', 'activo', 'Fitomejoramiento', 'Universidad', 'documentos/AbriryLeerArchivos_CTLa77U.pdf', 0),
(9, 'pbkdf2_sha256$600000$K8FQyFx3A7JhUNk6R7xGjc$EH2XC/iAmpMrXIZnpArX8SLtcdRRHmahaa5qCE873SA=', '2025-04-30 20:23:33.892965', 0, 'AnaPerez', 'Ana', 'Pérez', 'ana.perez@dominio.com', 0, 1, '2025-04-30 20:19:17.693757', 'experto', 'activo', 'Fitomejoramiento', 'Universidad', 'documentos/Plano_Oficina.jpg', 0),
(10, 'pbkdf2_sha256$600000$YLpVNpxbi6UIjdWG1AnKtB$xkVHhOIEstuFk7yt7Ljo5ASYtSi2w8rMUrGwnQprqsk=', NULL, 0, 'CarlosLopez', 'Carlos', 'López', 'carlos.lopez@gmail.com', 0, 1, '2025-04-30 20:25:32.590513', 'experto', 'inactivo', 'Control biológico', 'Independiente', 'documentos/Plano_Oficina_wNbO34O.jpg', 0),
(11, 'pbkdf2_sha256$600000$YBaIgVd4Awktsj0lw1RaGE$EENdN3cQxOdWMrOwLUNgeFYsY2bC5jyu0MJSqnHg8wk=', NULL, 0, 'SofiaGomez', 'Sofía', 'Gómez', 'sofia.gomez@gmail.com', 0, 1, '2025-04-30 20:26:36.800560', 'experto', 'inactivo', 'Cultivos protegidos', 'Externo', 'documentos/Plano_Oficina_t3w4Gqp.jpg', 0),
(12, 'pbkdf2_sha256$600000$yV9rYnb50EC0E2OkYTcndC$t7cqRGnOPBo5TrkuQ68Hse6wgQtYa//qI6aBtSJ+AP8=', NULL, 0, 'JuanRodriguez', 'Juan', 'Rodríguez', 'juan.rodriguez@gmail.com', 0, 1, '2025-04-30 20:28:29.117412', 'experto', 'activo', 'Producción de semillas', 'Universidad', 'documentos/Plano_Oficina_MybZnKZ.jpg', 0),
(13, 'pbkdf2_sha256$600000$VkHUGlfFFOnEqCuLC0VSxD$4HOPvEFAHb6Oya1ksHkQCRpWvcmdAjwwZOSH6mI+BuM=', NULL, 0, 'MariaVargas', 'María', 'Vargas', 'maria.vargas@gmail.com', 0, 1, '2025-04-30 20:29:46.613604', 'experto', 'pendiente', 'Control de plagas', 'Independiente', 'documentos/Plano_Oficina_lusKrJo.jpg', 0),
(14, 'pbkdf2_sha256$600000$29jO9ADpwGLYmIrFbjNHhx$HYZPAykiIGXSAB1tfxR75i12uqP2She/SYieW0KsVQ8=', NULL, 0, 'PedroSanchez', 'Pedro', 'Sánchez', 'pedro.sanchez@gmail.com', 0, 1, '2025-04-30 20:30:51.474681', 'experto', 'pendiente', 'Genética vegetal', 'Independiente', 'documentos/Plano_Oficina_Epw3jwj.jpg', 0),
(15, 'pbkdf2_sha256$600000$ubI0XWEciGc4jgN5e9aIgc$X+nlkNDeXoFio/wKh1Lb4tn1JivQBR0L8SdVLeOZ0m4=', NULL, 0, 'LauraTorres', 'Laura', 'Torres', 'laura.torres@gmail.com', 0, 1, '2025-04-30 20:32:08.038856', 'experto', 'pendiente', 'Fitopatología', 'Universidad', 'documentos/Plano_Oficina_H4YqbPV.jpg', 0),
(16, 'pbkdf2_sha256$600000$kXElB677p8iHimOdBYUew1$XoyQmQ0Y9VLlBU0pSlsc5EMwAfulc5phk9NcfEJV78U=', NULL, 0, 'DiegoCastro', 'Diego', 'Castro', 'diego.castro@gmail.com', 0, 1, '2025-04-30 20:32:52.062772', 'experto', 'pendiente', 'Edafología', 'Externo', 'documentos/Plano_Oficina_FwvOUx7.jpg', 0),
(17, 'pbkdf2_sha256$600000$q2Rk8UQJax72JTBnFXE8ua$2ORhYcBPndzytTGgfwdt3EUdicImtExibw83qn4EGuk=', NULL, 0, 'IsabelNunez', 'Isabel', 'Nuñez', 'isabel.nunez@gmail.com', 0, 1, '2025-04-30 20:34:02.173666', 'experto', 'pendiente', 'Protección forestal', 'Independiente', 'documentos/AbriryLeerArchivos_KaqWfv4.pdf', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_usuarios_usuario_groups`
--

CREATE TABLE `app_usuarios_usuario_groups` (
  `id` bigint(20) NOT NULL,
  `usuario_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_usuarios_usuario_user_permissions`
--

CREATE TABLE `app_usuarios_usuario_user_permissions` (
  `id` bigint(20) NOT NULL,
  `usuario_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_validaciones_cuestionario`
--

CREATE TABLE `app_validaciones_cuestionario` (
  `id` bigint(20) NOT NULL,
  `puntaje` decimal(5,2) NOT NULL,
  `aprobado` tinyint(1) NOT NULL,
  `fecha` datetime(6) NOT NULL,
  `experto_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `app_validaciones_cuestionario`
--

INSERT INTO `app_validaciones_cuestionario` (`id`, `puntaje`, `aprobado`, `fecha`, `experto_id`) VALUES
(4, 100.00, 1, '2025-04-30 15:38:07.317448', 8),
(5, 10.00, 0, '2025-04-30 20:24:16.837794', 9),
(10, 80.00, 1, '2025-04-30 15:40:33.000000', 9),
(11, 90.00, 1, '2025-04-30 15:40:33.000000', 10),
(12, 75.00, 1, '2025-04-30 15:40:33.000000', 11),
(13, 100.00, 1, '2025-04-30 15:40:33.000000', 12);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add user', 6, 'add_usuario'),
(22, 'Can change user', 6, 'change_usuario'),
(23, 'Can delete user', 6, 'delete_usuario'),
(24, 'Can view user', 6, 'view_usuario'),
(25, 'Can add cuestionario', 7, 'add_cuestionario'),
(26, 'Can change cuestionario', 7, 'change_cuestionario'),
(27, 'Can delete cuestionario', 7, 'delete_cuestionario'),
(28, 'Can view cuestionario', 7, 'view_cuestionario'),
(29, 'Can add tratamiento', 8, 'add_tratamiento'),
(30, 'Can change tratamiento', 8, 'change_tratamiento'),
(31, 'Can delete tratamiento', 8, 'delete_tratamiento'),
(32, 'Can view tratamiento', 8, 'view_tratamiento'),
(33, 'Can add enfermedad', 9, 'add_enfermedad'),
(34, 'Can change enfermedad', 9, 'change_enfermedad'),
(35, 'Can delete enfermedad', 9, 'delete_enfermedad'),
(36, 'Can view enfermedad', 9, 'view_enfermedad');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(9, 'app_enfermedades', 'enfermedad'),
(8, 'app_tratamientos', 'tratamiento'),
(6, 'app_usuarios', 'usuario'),
(7, 'app_validaciones', 'cuestionario'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'contenttypes', 'contenttype'),
(5, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-04-29 16:54:51.300799'),
(2, 'contenttypes', '0002_remove_content_type_name', '2025-04-29 16:54:51.386438'),
(3, 'auth', '0001_initial', '2025-04-29 16:54:51.627932'),
(4, 'auth', '0002_alter_permission_name_max_length', '2025-04-29 16:54:51.679862'),
(5, 'auth', '0003_alter_user_email_max_length', '2025-04-29 16:54:51.685452'),
(6, 'auth', '0004_alter_user_username_opts', '2025-04-29 16:54:51.690270'),
(7, 'auth', '0005_alter_user_last_login_null', '2025-04-29 16:54:51.696870'),
(8, 'auth', '0006_require_contenttypes_0002', '2025-04-29 16:54:51.699376'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2025-04-29 16:54:51.705142'),
(10, 'auth', '0008_alter_user_username_max_length', '2025-04-29 16:54:51.711497'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2025-04-29 16:54:51.717071'),
(12, 'auth', '0010_alter_group_name_max_length', '2025-04-29 16:54:51.729752'),
(13, 'auth', '0011_update_proxy_permissions', '2025-04-29 16:54:51.735857'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2025-04-29 16:54:51.741012'),
(15, 'app_usuarios', '0001_initial', '2025-04-29 16:54:52.052847'),
(16, 'admin', '0001_initial', '2025-04-29 16:54:52.182977'),
(17, 'admin', '0002_logentry_remove_auto_add', '2025-04-29 16:54:52.190792'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2025-04-29 16:54:52.198748'),
(19, 'sessions', '0001_initial', '2025-04-29 16:54:52.227109'),
(20, 'app_validaciones', '0001_initial', '2025-04-29 17:07:55.187216'),
(21, 'app_enfermedades', '0001_initial', '2025-04-30 02:44:07.650695'),
(22, 'app_tratamientos', '0001_initial', '2025-04-30 02:44:08.003190'),
(23, 'app_usuarios', '0002_usuario_es_superadmin', '2025-04-30 03:03:09.489612');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('ccdtle3t3lq0kf3gk4klfq36k39wp9we', '.eJxVjMEOwiAQRP-FsyHLUhQ8eu83kF2WStXQpLQn47_bJj1oMqd5b-atIq1LiWvLcxxFXZVXp9-OKT1z3YE8qN4nnaa6zCPrXdEHbbqfJL9uh_t3UKiVbY3GX1BI_BkY3EBgt9gBkYMk10GSjgmStS6gJWNMQgeQg2MnHLKozxfVlDem:1uAEcD:hKkAEdBbpWvbrcX5QBQQu_tQNgWKm9AKfs3xq7_1WiY', '2025-05-14 21:05:13.953744');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `app_enfermedades_enfermedad`
--
ALTER TABLE `app_enfermedades_enfermedad`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `app_tratamientos_tratamiento`
--
ALTER TABLE `app_tratamientos_tratamiento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_tratamientos_tra_enfermedad_id_fe2a1c4a_fk_app_enfer` (`enfermedad_id`),
  ADD KEY `app_tratamientos_tra_experto_id_fa40eab0_fk_app_usuar` (`experto_id`);

--
-- Indices de la tabla `app_usuarios_usuario`
--
ALTER TABLE `app_usuarios_usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indices de la tabla `app_usuarios_usuario_groups`
--
ALTER TABLE `app_usuarios_usuario_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `app_usuarios_usuario_groups_usuario_id_group_id_440aef7d_uniq` (`usuario_id`,`group_id`),
  ADD KEY `app_usuarios_usuario_groups_group_id_1db4b2ff_fk_auth_group_id` (`group_id`);

--
-- Indices de la tabla `app_usuarios_usuario_user_permissions`
--
ALTER TABLE `app_usuarios_usuario_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `app_usuarios_usuario_use_usuario_id_permission_id_667ffa2f_uniq` (`usuario_id`,`permission_id`),
  ADD KEY `app_usuarios_usuario_permission_id_001ed994_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `app_validaciones_cuestionario`
--
ALTER TABLE `app_validaciones_cuestionario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_validaciones_cue_experto_id_82ed27cf_fk_app_usuar` (`experto_id`);

--
-- Indices de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indices de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_app_usuarios_usuario_id` (`user_id`);

--
-- Indices de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indices de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `app_enfermedades_enfermedad`
--
ALTER TABLE `app_enfermedades_enfermedad`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `app_tratamientos_tratamiento`
--
ALTER TABLE `app_tratamientos_tratamiento`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `app_usuarios_usuario`
--
ALTER TABLE `app_usuarios_usuario`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `app_usuarios_usuario_groups`
--
ALTER TABLE `app_usuarios_usuario_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `app_usuarios_usuario_user_permissions`
--
ALTER TABLE `app_usuarios_usuario_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `app_validaciones_cuestionario`
--
ALTER TABLE `app_validaciones_cuestionario`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `app_tratamientos_tratamiento`
--
ALTER TABLE `app_tratamientos_tratamiento`
  ADD CONSTRAINT `app_tratamientos_tra_enfermedad_id_fe2a1c4a_fk_app_enfer` FOREIGN KEY (`enfermedad_id`) REFERENCES `app_enfermedades_enfermedad` (`id`),
  ADD CONSTRAINT `app_tratamientos_tra_experto_id_fa40eab0_fk_app_usuar` FOREIGN KEY (`experto_id`) REFERENCES `app_usuarios_usuario` (`id`);

--
-- Filtros para la tabla `app_usuarios_usuario_groups`
--
ALTER TABLE `app_usuarios_usuario_groups`
  ADD CONSTRAINT `app_usuarios_usuario_groups_group_id_1db4b2ff_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `app_usuarios_usuario_usuario_id_733213d9_fk_app_usuar` FOREIGN KEY (`usuario_id`) REFERENCES `app_usuarios_usuario` (`id`);

--
-- Filtros para la tabla `app_usuarios_usuario_user_permissions`
--
ALTER TABLE `app_usuarios_usuario_user_permissions`
  ADD CONSTRAINT `app_usuarios_usuario_permission_id_001ed994_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `app_usuarios_usuario_usuario_id_2f9e53e3_fk_app_usuar` FOREIGN KEY (`usuario_id`) REFERENCES `app_usuarios_usuario` (`id`);

--
-- Filtros para la tabla `app_validaciones_cuestionario`
--
ALTER TABLE `app_validaciones_cuestionario`
  ADD CONSTRAINT `app_validaciones_cue_experto_id_82ed27cf_fk_app_usuar` FOREIGN KEY (`experto_id`) REFERENCES `app_usuarios_usuario` (`id`);

--
-- Filtros para la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Filtros para la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Filtros para la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_app_usuarios_usuario_id` FOREIGN KEY (`user_id`) REFERENCES `app_usuarios_usuario` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
