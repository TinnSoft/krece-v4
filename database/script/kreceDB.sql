-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.2.3-MariaDB-log - mariadb.org binary distribution
-- SO del servidor:              Win32
-- HeidiSQL Versión:             9.5.0.5339
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para krece
CREATE DATABASE IF NOT EXISTS `krece` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `krece`;

-- Volcando estructura para tabla krece.account
CREATE TABLE IF NOT EXISTS `account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `identification` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `regime_id` int(11) DEFAULT NULL,
  `logo` longtext DEFAULT NULL,
  `decimal_precision` tinyint(4) DEFAULT NULL,
  `decimal_separator` char(1) DEFAULT NULL,
  `account_key` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `pro_plan_paid` date DEFAULT NULL,
  `pro_plan_trial` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_account_key` (`account_key`),
  UNIQUE KEY `UK_account_email` (`email`),
  KEY `FK_account_regime` (`regime_id`),
  CONSTRAINT `FK_account_regime` FOREIGN KEY (`regime_id`) REFERENCES `account_regime` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COMMENT='Contains the account information for each user register in the app, in addition controls the the permisiones over the application';

-- Volcando datos para la tabla krece.account: ~2 rows (aproximadamente)
DELETE FROM `account`;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` (`id`, `name`, `identification`, `address`, `phone`, `website`, `city`, `regime_id`, `logo`, `decimal_precision`, `decimal_separator`, `account_key`, `email`, `pro_plan_paid`, `pro_plan_trial`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'tinnsoft', '123456', 'calle 12 # 2-49', '3123456023', 'sitio', 'Bogota', 2, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAdQAAAE4CAYAAADioQKVAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAEnMAABJzAYwiuQcAAFgWSURBVHhe7b0HnxzVmb79fotdUAaMvfb+19m7612vN9lrpMmSQCCSico5I6LI2AabZIKxyUlh8ihHJKGA4kgTpMk559Bh5n6f+/SU1Bp6JGEXMIL74vdQ3RVPVY/qqufUqVP/H4QQQgjxNyOhCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+IKEKIYQQPiChCiGEED4goQohhBA+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', 0, '.', NULL, 'fernando2684@gmail.com', NULL, NULL, '2017-04-12 09:26:10', '2017-09-14 08:13:28', NULL),
	(2, 'pruebax', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '.', NULL, 'fer2@gmail.com', NULL, NULL, '2017-08-06 23:23:21', '2017-08-06 23:23:21', NULL);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;

-- Volcando estructura para tabla krece.account_regime
CREATE TABLE IF NOT EXISTS `account_regime` (
  `id` int(11) NOT NULL,
  `value` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.account_regime: ~4 rows (aproximadamente)
DELETE FROM `account_regime`;
/*!40000 ALTER TABLE `account_regime` DISABLE KEYS */;
INSERT INTO `account_regime` (`id`, `value`) VALUES
	(1, 'Régimen común'),
	(2, 'Régimen simplificado'),
	(3, 'Régimen especial'),
	(4, 'Régimen simplicado impuesto nacional al consumo');
/*!40000 ALTER TABLE `account_regime` ENABLE KEYS */;

-- Volcando estructura para tabla krece.account_tokens
CREATE TABLE IF NOT EXISTS `account_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `public_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_tokens_token_unique` (`token`),
  UNIQUE KEY `account_tokens_account_id_public_id_unique` (`account_id`,`public_id`),
  KEY `account_tokens_user_id_foreign` (`user_id`),
  KEY `account_tokens_account_id_index` (`account_id`),
  CONSTRAINT `FK_account_tokens_accountid` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_account_tokens_userid` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla krece.account_tokens: ~0 rows (aproximadamente)
DELETE FROM `account_tokens`;
/*!40000 ALTER TABLE `account_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_tokens` ENABLE KEYS */;

-- Volcando estructura para tabla krece.activity_log
CREATE TABLE IF NOT EXISTS `activity_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `detail` varchar(500) DEFAULT NULL,
  `route` varchar(500) DEFAULT NULL,
  `model` varchar(20) DEFAULT NULL,
  `process_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_log_company_id` (`account_id`),
  KEY `FK_log_user` (`user_id`),
  CONSTRAINT `FK_log_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_log_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1213 DEFAULT CHARSET=latin1 COMMENT='stores the log for each transaction made by any user';

-- Volcando datos para la tabla krece.activity_log: ~1.067 rows (aproximadamente)
DELETE FROM `activity_log`;
/*!40000 ALTER TABLE `activity_log` DISABLE KEYS */;
INSERT INTO `activity_log` (`id`, `account_id`, `user_id`, `created_at`, `detail`, `route`, `model`, `process_type`) VALUES
	(1, NULL, 1, '2017-04-12 08:39:40', 'tinnsoft ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(2, 1, 1, '2017-04-12 09:26:22', 'tinnsoft ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(3, 1, 1, '2017-04-12 09:27:34', 'Se creó la Cotización número: 1 para el cliente test', '/estimate/1', 'Estimate', 'Create'),
	(4, 1, 1, '2017-04-12 09:27:39', 'Se ha impreso el pdf de la cotización No: 1', '/estimate/1', 'Estimate', 'Print'),
	(5, 1, 1, '2017-04-12 09:28:14', 'Se ha impreso el pdf de la cotización No: 1', '/estimate/1', 'Estimate', 'Print'),
	(6, 1, 1, '2017-04-12 09:37:56', 'Se ha impreso el pdf de la cotización No: 1', '/estimate/1', 'Estimate', 'Print'),
	(7, 1, 1, '2017-04-12 09:38:37', 'Se creó la factura de venta número: 1 para el cliente test', '/invoice/1', 'InvoiceSaleOrder', 'Create'),
	(8, 1, 1, '2017-04-12 21:53:18', 'Se creó la Cotización número: 2 para el cliente test', '/estimate/2', 'Estimate', 'Create'),
	(9, 1, 1, '2017-04-12 21:54:42', 'Se creó la factura de venta número: 2 para el cliente test', '/invoice/2', 'InvoiceSaleOrder', 'Create'),
	(10, 1, 1, '2017-04-13 21:21:16', 'Se creó la factura de proveedor número: 1 para el cliente test', '/bill/1', 'Bill', 'Create'),
	(11, 1, 1, '2017-04-13 21:21:58', 'Se creó la Nota Débito número: 1 para el cliente test', '/debit-note/1', 'DebitNote', 'Create'),
	(12, 1, 1, '2017-04-13 21:25:29', 'Se creó el comprobante de pago número: 1 para el proveedor test', '/payment-out/1', 'payment-out', 'Create'),
	(13, 1, 1, '2017-04-16 22:05:44', 'tinnsoft ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(14, 1, 1, '2017-04-18 19:21:03', 'Se creó la factura de venta número: 3 para el cliente test', '/invoice/3', 'InvoiceSaleOrder', 'Create'),
	(15, 1, 1, '2017-04-18 19:21:14', 'Se creó la factura de venta número: 4 para el cliente test', '/invoice/4', 'InvoiceSaleOrder', 'Create'),
	(16, 1, 1, '2017-04-18 19:21:25', 'Se creó la factura de venta número: 5 para el cliente test', '/invoice/5', 'InvoiceSaleOrder', 'Create'),
	(17, 1, 1, '2017-04-18 19:21:34', 'Se creó la factura de venta número: 6 para el cliente test', '/invoice/6', 'InvoiceSaleOrder', 'Create'),
	(18, 1, 1, '2017-04-18 19:21:45', 'Se creó la factura de venta número: 7 para el cliente test', '/invoice/7', 'InvoiceSaleOrder', 'Create'),
	(19, 1, 1, '2017-04-18 19:21:55', 'Se creó la factura de venta número: 8 para el cliente test', '/invoice/8', 'InvoiceSaleOrder', 'Create'),
	(20, 1, 1, '2017-04-18 19:22:05', 'Se creó la factura de venta número: 9 para el cliente test', '/invoice/9', 'InvoiceSaleOrder', 'Create'),
	(21, 1, 1, '2017-04-18 19:22:14', 'Se creó la factura de venta número: 10 para el cliente test', '/invoice/10', 'InvoiceSaleOrder', 'Create'),
	(22, 1, 1, '2017-04-18 19:22:29', 'Se creó la factura de venta número: 11 para el cliente test', '/invoice/11', 'InvoiceSaleOrder', 'Create'),
	(23, 1, 1, '2017-05-10 09:26:43', 'Se creó la factura de venta número: 12 para el cliente test', '/invoice/12', 'InvoiceSaleOrder', 'Create'),
	(24, 1, 1, '2017-07-10 15:56:53', 'tinnsoft ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(25, 1, 1, '2017-07-12 13:51:06', 'Se ha impreso el pdf de la factura de venta No: 12', '/invoice/12', 'InvoiceSaleOrder', 'Print'),
	(26, 1, 1, '2017-07-12 13:51:43', 'Se ha impreso el pdf de la factura de venta No: 12', '/invoice/12', 'InvoiceSaleOrder', 'Print'),
	(27, 1, 1, '2017-07-12 13:52:10', 'Se ha impreso el pdf de la factura de venta No: 12', '/invoice/12', 'InvoiceSaleOrder', 'Print'),
	(28, 1, 1, '2017-07-12 13:52:37', 'Se ha impreso el pdf de la factura de venta No: 12', '/invoice/12', 'InvoiceSaleOrder', 'Print'),
	(29, 1, 1, '2017-07-12 13:52:52', 'Se ha impreso el pdf de la factura de venta No: 12', '/invoice/12', 'InvoiceSaleOrder', 'Print'),
	(30, 1, 1, '2017-07-12 13:53:15', 'Se ha impreso el pdf de la factura de venta No: 12', '/invoice/12', 'InvoiceSaleOrder', 'Print'),
	(31, 1, 1, '2017-07-12 13:53:24', 'Se ha impreso el pdf de la factura de venta No: 12', '/invoice/12', 'InvoiceSaleOrder', 'Print'),
	(32, 1, 1, '2017-07-12 13:54:01', 'Se ha impreso el pdf de la factura de venta No: 12', '/invoice/12', 'InvoiceSaleOrder', 'Print'),
	(33, 1, 1, '2017-07-12 13:55:11', 'Se ha impreso el pdf de la factura de venta No: 12', '/invoice/12', 'InvoiceSaleOrder', 'Print'),
	(34, 1, 1, '2017-07-12 13:55:29', 'Se ha impreso el pdf de la factura de venta No: 12', '/invoice/12', 'InvoiceSaleOrder', 'Print'),
	(35, 1, 1, '2017-07-12 13:56:01', 'Se ha impreso el pdf de la factura de venta No: 12', '/invoice/12', 'InvoiceSaleOrder', 'Print'),
	(36, 1, 1, '2017-07-12 14:08:45', 'Se ha impreso el pdf de la factura de venta No: 12', '/invoice/12', 'InvoiceSaleOrder', 'Print'),
	(37, 1, 1, '2017-07-12 14:09:22', 'Se ha impreso el pdf de la factura de venta No: 12', '/invoice/12', 'InvoiceSaleOrder', 'Print'),
	(38, 1, 1, '2017-07-12 14:10:17', 'Se ha impreso el pdf de la factura de venta No: 12', '/invoice/12', 'InvoiceSaleOrder', 'Print'),
	(39, 1, 1, '2017-07-12 14:10:41', 'Se ha impreso el pdf de la factura de venta No: 12', '/invoice/12', 'InvoiceSaleOrder', 'Print'),
	(40, 1, 1, '2017-07-12 14:12:00', 'Se ha impreso el pdf de la factura de venta No: 12', '/invoice/12', 'InvoiceSaleOrder', 'Print'),
	(41, 1, 1, '2017-07-12 14:13:33', 'Se ha impreso el pdf de la factura de venta No: 12', '/invoice/12', 'InvoiceSaleOrder', 'Print'),
	(42, 1, 1, '2017-07-12 14:35:15', 'Se creó la factura de venta número: 13 para el cliente test', '/invoice/13', 'InvoiceSaleOrder', 'Create'),
	(43, 1, 1, '2017-07-12 14:36:42', 'Se actualizó la factura de venta número: 14 para el cliente test', '/invoice/13', 'InvoiceSaleOrder', 'Update'),
	(44, 1, 1, '2017-07-12 14:38:31', 'Se ha impreso el pdf de la factura de venta No: 13', '/invoice/13', 'InvoiceSaleOrder', 'Print'),
	(45, 1, 1, '2017-07-12 14:39:26', 'Se ha impreso el pdf de la factura de venta No: 13', '/invoice/13', 'InvoiceSaleOrder', 'Print'),
	(46, 1, 1, '2017-07-12 14:42:33', 'Se ha impreso el pdf de la factura de venta No: 13', '/invoice/13', 'InvoiceSaleOrder', 'Print'),
	(47, 1, 1, '2017-07-12 14:45:48', 'Se actualizó la factura de venta número: 14 para el cliente test', '/invoice/13', 'InvoiceSaleOrder', 'Update'),
	(48, 1, 1, '2017-07-12 14:45:53', 'Se ha impreso el pdf de la factura de venta No: 13', '/invoice/13', 'InvoiceSaleOrder', 'Print'),
	(49, 1, 1, '2017-07-12 14:48:52', 'Se ha impreso el pdf de la factura de venta No: 13', '/invoice/13', 'InvoiceSaleOrder', 'Print'),
	(50, 1, 1, '2017-07-12 14:49:35', 'Se ha impreso el pdf de la factura de venta No: 13', '/invoice/13', 'InvoiceSaleOrder', 'Print'),
	(51, 1, 1, '2017-07-12 15:10:06', 'Se ha impreso el pdf de la factura de venta No: 13', '/invoice/13', 'InvoiceSaleOrder', 'Print'),
	(52, 1, 1, '2017-07-12 15:10:48', 'Se ha impreso el pdf de la factura de venta No: 13', '/invoice/13', 'InvoiceSaleOrder', 'Print'),
	(53, 1, 1, '2017-07-12 15:12:39', 'Se ha impreso el pdf de la factura de venta No: 13', '/invoice/13', 'InvoiceSaleOrder', 'Print'),
	(54, 1, 1, '2017-07-12 15:14:24', 'Se ha impreso el pdf de la factura de venta No: 13', '/invoice/13', 'InvoiceSaleOrder', 'Print'),
	(55, 1, 1, '2017-07-12 15:14:52', 'Se ha impreso el pdf de la factura de venta No: 13', '/invoice/13', 'InvoiceSaleOrder', 'Print'),
	(56, 1, 1, '2017-07-12 15:23:56', 'Se ha impreso el pdf de la factura de venta No: 13', '/invoice/13', 'InvoiceSaleOrder', 'Print'),
	(57, 1, 1, '2017-07-12 15:24:08', 'Se ha impreso el pdf de la factura de venta No: 13', '/invoice/13', 'InvoiceSaleOrder', 'Print'),
	(58, 1, 1, '2017-07-12 15:24:24', 'Se ha impreso el pdf de la factura de venta No: 13', '/invoice/13', 'InvoiceSaleOrder', 'Print'),
	(59, 1, 1, '2017-07-12 15:24:30', 'Se ha impreso el pdf de la factura de venta No: 13', '/invoice/13', 'InvoiceSaleOrder', 'Print'),
	(60, 1, 1, '2017-07-12 15:36:49', 'Se ha impreso el pdf de la factura de venta No: 13', '/invoice/13', 'InvoiceSaleOrder', 'Print'),
	(61, 1, 1, '2017-07-12 15:37:19', 'Se ha impreso el pdf de la factura de venta No: 13', '/invoice/13', 'InvoiceSaleOrder', 'Print'),
	(62, 1, 1, '2017-07-12 15:37:35', 'Se ha impreso el pdf de la factura de venta No: 13', '/invoice/13', 'InvoiceSaleOrder', 'Print'),
	(63, 1, 1, '2017-07-12 15:38:01', 'Se ha impreso el pdf de la factura de venta No: 13', '/invoice/13', 'InvoiceSaleOrder', 'Print'),
	(64, 1, 1, '2017-07-12 15:38:13', 'Se ha impreso el pdf de la factura de venta No: 13', '/invoice/13', 'InvoiceSaleOrder', 'Print'),
	(65, 1, 1, '2017-07-12 15:39:24', 'Se ha impreso el pdf de la factura de venta No: 13', '/invoice/13', 'InvoiceSaleOrder', 'Print'),
	(66, 1, 1, '2017-07-12 15:40:29', 'Se ha impreso el pdf de la factura de venta No: 13', '/invoice/13', 'InvoiceSaleOrder', 'Print'),
	(67, 1, 1, '2017-07-12 15:41:22', 'Se ha impreso el pdf de la factura de venta No: 13', '/invoice/13', 'InvoiceSaleOrder', 'Print'),
	(68, 1, 1, '2017-07-12 15:42:47', 'Se ha impreso el pdf de la factura de venta No: 13', '/invoice/13', 'InvoiceSaleOrder', 'Print'),
	(69, 1, 1, '2017-07-12 15:43:11', 'Se creó la factura de venta número: 14 para el cliente test', '/invoice/14', 'InvoiceSaleOrder', 'Create'),
	(70, 1, 1, '2017-07-12 15:43:17', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(71, 1, 1, '2017-07-12 15:49:14', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(72, 1, 1, '2017-07-12 15:49:32', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(73, 1, 1, '2017-07-12 15:50:04', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(74, 1, 1, '2017-07-12 15:50:58', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(75, 1, 1, '2017-07-12 16:05:41', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(76, 1, 1, '2017-07-12 16:14:05', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(77, 1, 1, '2017-07-12 16:14:21', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(78, 1, 1, '2017-07-12 16:15:09', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(79, 1, 1, '2017-07-12 16:15:36', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(80, 1, 1, '2017-07-12 16:40:01', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(81, 1, 1, '2017-07-12 16:49:56', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(82, 1, 1, '2017-07-12 16:50:31', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(83, 1, 1, '2017-07-12 16:50:39', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(84, 1, 1, '2017-07-12 16:51:13', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(85, 1, 1, '2017-07-12 16:51:22', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(86, 1, 1, '2017-07-12 16:51:39', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(87, 1, 1, '2017-07-12 16:52:51', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(88, 1, 1, '2017-07-12 16:53:26', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(89, 1, 1, '2017-07-12 16:54:33', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(90, 1, 1, '2017-07-12 16:55:23', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(91, 1, 1, '2017-07-12 16:56:15', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(92, 1, 1, '2017-07-12 16:56:20', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(93, 1, 1, '2017-07-12 16:58:03', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(94, 1, 1, '2017-07-12 17:00:26', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(95, 1, 1, '2017-07-12 17:00:59', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(96, 1, 1, '2017-07-12 17:02:45', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(97, 1, 1, '2017-07-12 17:03:20', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(98, 1, 1, '2017-07-12 17:04:23', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(99, 1, 1, '2017-07-12 17:05:20', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(100, 1, 1, '2017-07-12 17:05:45', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(101, 1, 1, '2017-07-12 17:06:45', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(102, 1, 1, '2017-07-12 17:07:28', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(103, 1, 1, '2017-07-12 17:10:35', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(104, 1, 1, '2017-07-12 17:10:57', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(105, 1, 1, '2017-07-12 17:11:17', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(106, 1, 1, '2017-07-12 17:11:51', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(107, 1, 1, '2017-07-12 17:12:34', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(108, 1, 1, '2017-07-12 17:13:42', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(109, 1, 1, '2017-07-12 17:13:55', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(110, 1, 1, '2017-07-12 17:14:38', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(111, 1, 1, '2017-07-12 17:14:50', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(112, 1, 1, '2017-07-12 17:15:08', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(113, 1, 1, '2017-07-12 17:16:39', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(114, 1, 1, '2017-07-12 17:16:54', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(115, 1, 1, '2017-07-12 17:17:27', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(116, 1, 1, '2017-07-12 17:18:39', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(117, 1, 1, '2017-07-12 17:19:14', 'Se ha impreso el pdf de la factura de venta No: 14', '/invoice/14', 'InvoiceSaleOrder', 'Print'),
	(118, 1, 1, '2017-07-12 17:33:38', 'Se ha impreso el pdf de la factura de venta No: 10', '/invoice/10', 'InvoiceSaleOrder', 'Print'),
	(119, 1, 1, '2017-08-02 09:51:17', 'Fernando ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(120, 1, 1, '2017-08-05 12:06:24', 'Fernando ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(121, 1, 1, '2017-08-08 18:04:20', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(122, 1, 1, '2017-08-10 09:33:05', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(123, 1, 1, '2017-08-12 21:19:10', 'Se actualizó la Cotización número: 2 para el cliente test', '/estimate/2', 'Estimate', 'Update'),
	(124, 1, 1, '2017-08-12 21:19:40', 'Se actualizó la Cotización número: 2 para el cliente test', '/estimate/2', 'Estimate', 'Update'),
	(125, 1, 1, '2017-08-14 16:53:32', 'Se actualizó la Cotización número: 2 para el cliente test', '/estimate/2', 'Estimate', 'Update'),
	(126, 1, 1, '2017-08-17 12:56:15', 'Se ha impreso el pdf de la cotización No: 2', '/estimate/2', 'Estimate', 'Print'),
	(127, 1, 1, '2017-08-18 18:18:56', 'Se creó la Cotización número: 3 para el cliente pepito perez', '/estimate/3', 'Estimate', 'Create'),
	(128, 1, 1, '2017-08-18 18:25:33', 'Se creó la Cotización número: 4 para el cliente pepito perez', '/estimate/4', 'Estimate', 'Create'),
	(129, 1, 1, '2017-08-18 18:27:59', 'Se creó la Cotización número: 5 para el cliente pepito perez', '/estimate/5', 'Estimate', 'Create'),
	(130, 1, 1, '2017-08-18 18:30:16', 'Se creó la Cotización número: 6 para el cliente pepito perez', '/estimate/6', 'Estimate', 'Create'),
	(131, 1, 1, '2017-08-18 18:30:59', 'Se creó la Cotización número: 7 para el cliente pepito perez', '/estimate/7', 'Estimate', 'Create'),
	(132, 1, 1, '2017-08-18 18:46:54', 'Se creó la Cotización número: 8 para el cliente pepito perez', '/estimate/8', 'Estimate', 'Create'),
	(133, 1, 1, '2017-08-18 18:51:10', 'Se creó la Cotización número: 9 para el cliente pepito perez', '/estimate/9', 'Estimate', 'Create'),
	(134, 1, 1, '2017-08-18 18:56:00', 'Se creó la Cotización número: 10 para el cliente pepito perez', '/estimate/10', 'Estimate', 'Create'),
	(135, 1, 1, '2017-08-18 18:57:25', 'Se creó la Cotización número: 11 para el cliente pepito perez', '/estimate/11', 'Estimate', 'Create'),
	(136, 1, 1, '2017-08-18 19:18:08', 'Se creó la Cotización número: 12 para el cliente pepito perez', '/estimate/12', 'Estimate', 'Create'),
	(137, 1, 1, '2017-08-18 19:19:12', 'Se creó la Cotización número: 13 para el cliente pepito perez', '/estimate/13', 'Estimate', 'Create'),
	(138, 1, 1, '2017-08-18 19:20:53', 'Se creó la Cotización número: 14 para el cliente pepito perez', '/estimate/14', 'Estimate', 'Create'),
	(139, 1, 1, '2017-08-18 19:24:24', 'Se creó la Cotización número: 15 para el cliente pepito perez', '/estimate/15', 'Estimate', 'Create'),
	(140, 1, 1, '2017-08-18 19:25:55', 'Se creó la Cotización número: 16 para el cliente pepito perez', '/estimate/16', 'Estimate', 'Create'),
	(141, 1, 1, '2017-08-18 19:35:21', 'Se creó la Cotización número: 17 para el cliente pepito perez', '/estimate/17', 'Estimate', 'Create'),
	(142, 1, 1, '2017-08-18 19:43:48', 'Se creó la Cotización número: 18 para el cliente pepito perez', '/estimate/18', 'Estimate', 'Create'),
	(143, 1, 1, '2017-08-18 19:44:30', 'Se creó la Cotización número: 19 para el cliente pepito perez', '/estimate/19', 'Estimate', 'Create'),
	(144, 1, 1, '2017-08-18 19:46:38', 'Se creó la Cotización número: 20 para el cliente pepito perez', '/estimate/20', 'Estimate', 'Create'),
	(145, 1, 1, '2017-08-18 19:47:23', 'Se creó la Cotización número: 21 para el cliente pepito perez', '/estimate/21', 'Estimate', 'Create'),
	(146, 1, 1, '2017-08-18 19:48:00', 'Se creó la Cotización número: 22 para el cliente pepito perez', '/estimate/22', 'Estimate', 'Create'),
	(147, 1, 1, '2017-08-19 08:40:24', 'Se eliminó la cotización número: 22', NULL, 'Estimate', 'Delete'),
	(148, 1, 1, '2017-08-19 08:40:37', 'Se eliminó la cotización número: 18', NULL, 'Estimate', 'Delete'),
	(149, 1, 1, '2017-08-19 08:40:41', 'Se eliminó la cotización número: 16', NULL, 'Estimate', 'Delete'),
	(150, 1, 1, '2017-08-19 08:41:06', 'Se eliminó la cotización número: 21', NULL, 'Estimate', 'Delete'),
	(151, 1, 1, '2017-08-19 08:41:12', 'Se eliminó la cotización número: 20', NULL, 'Estimate', 'Delete'),
	(152, 1, 1, '2017-08-19 08:41:19', 'Se eliminó la cotización número: 19', NULL, 'Estimate', 'Delete'),
	(153, 1, 1, '2017-08-19 08:41:26', 'Se eliminó la cotización número: 9', NULL, 'Estimate', 'Delete'),
	(154, 1, 1, '2017-08-19 08:41:46', 'Se eliminó la cotización número: 15', NULL, 'Estimate', 'Delete'),
	(155, 1, 1, '2017-08-19 08:41:59', 'Se eliminó la cotización número: 7', NULL, 'Estimate', 'Delete'),
	(156, 1, 1, '2017-08-19 08:42:47', 'Se eliminó la cotización número: 4', NULL, 'Estimate', 'Delete'),
	(157, 1, 1, '2017-08-19 08:55:12', 'Se eliminó la cotización número: 13', NULL, 'Estimate', 'Delete'),
	(158, 1, 1, '2017-08-19 08:55:17', 'Se eliminó la cotización número: 5', NULL, 'Estimate', 'Delete'),
	(159, 1, 1, '2017-08-19 08:55:23', 'Se eliminó la cotización número: 2', NULL, 'Estimate', 'Delete'),
	(160, 1, 1, '2017-08-19 09:01:49', 'Se eliminó la cotización número: 3', NULL, 'Estimate', 'Delete'),
	(161, 1, 1, '2017-08-19 09:02:24', 'Se eliminó la cotización número: 6', NULL, 'Estimate', 'Delete'),
	(162, 1, 1, '2017-08-19 09:02:44', 'Se eliminó la cotización número: 8', NULL, 'Estimate', 'Delete'),
	(163, 1, 1, '2017-08-19 09:05:05', 'Se eliminó la cotización número: 10', NULL, 'Estimate', 'Delete'),
	(164, 1, 1, '2017-08-19 09:05:15', 'Se eliminó la cotización número: 11', NULL, 'Estimate', 'Delete'),
	(165, 1, 1, '2017-08-19 10:00:03', 'Se actualizó la Cotización número: 17 para el cliente pepito perez', '/estimate/17', 'Estimate', 'Update'),
	(166, 1, 1, '2017-08-19 10:00:41', 'Se actualizó la Cotización número: 17 para el cliente pepito perez', '/estimate/17', 'Estimate', 'Update'),
	(167, 1, 1, '2017-08-19 10:01:17', 'Se actualizó la Cotización número: 17 para el cliente pepito perez', '/estimate/17', 'Estimate', 'Update'),
	(168, 1, 1, '2017-08-19 10:02:11', 'Se actualizó la Cotización número: 14 para el cliente pepito perez', '/estimate/14', 'Estimate', 'Update'),
	(169, 1, 1, '2017-08-19 10:02:18', 'Se actualizó la Cotización número: 17 para el cliente pepito perez', '/estimate/17', 'Estimate', 'Update'),
	(170, 1, 1, '2017-08-20 07:34:18', 'Se actualizó la Cotización número: 17 para el cliente pepito perez', '/estimate/17', 'Estimate', 'Update'),
	(171, 1, 1, '2017-08-20 07:47:57', 'Se creó la Cotización número: 23 para el cliente pepito perez', '/estimate/23', 'Estimate', 'Create'),
	(172, 1, 1, '2017-08-20 07:48:46', 'Se creó la Cotización número: 24 para el cliente pepito perez', '/estimate/24', 'Estimate', 'Create'),
	(173, 1, 1, '2017-08-20 08:11:32', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(174, 1, 1, '2017-08-20 08:14:20', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(175, 1, 1, '2017-08-20 08:18:44', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(176, 1, 1, '2017-08-20 08:19:03', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(177, 1, 1, '2017-08-20 08:20:07', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(178, 1, 1, '2017-08-20 08:21:30', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(179, 1, 1, '2017-08-20 08:21:58', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(180, 1, 1, '2017-08-20 08:22:48', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(181, 1, 1, '2017-08-20 08:24:57', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(182, 1, 1, '2017-08-20 08:25:27', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(183, 1, 1, '2017-08-20 08:25:53', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(184, 1, 1, '2017-08-20 08:26:34', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(185, 1, 1, '2017-08-20 08:26:43', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(186, 1, 1, '2017-08-20 08:32:13', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(187, 1, 1, '2017-08-20 08:33:23', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(188, 1, 1, '2017-08-20 08:34:48', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(189, 1, 1, '2017-08-20 08:37:45', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(190, 1, 1, '2017-08-20 08:39:43', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(191, 1, 1, '2017-08-20 08:39:58', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(192, 1, 1, '2017-08-20 08:44:51', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(193, 1, 1, '2017-08-20 08:45:18', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(194, 1, 1, '2017-08-20 08:45:44', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(195, 1, 1, '2017-08-20 08:46:07', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(196, 1, 1, '2017-08-20 08:47:01', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(197, 1, 1, '2017-08-20 08:47:10', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(198, 1, 1, '2017-08-20 08:48:09', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(199, 1, 1, '2017-08-20 08:48:48', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(200, 1, 1, '2017-08-20 08:50:10', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(201, 1, 1, '2017-08-20 08:52:26', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(202, 1, 1, '2017-08-20 08:53:12', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(203, 1, 1, '2017-08-20 08:53:45', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(204, 1, 1, '2017-08-20 08:54:04', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(205, 1, 1, '2017-08-20 08:54:32', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(206, 1, 1, '2017-08-20 08:54:51', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(207, 1, 1, '2017-08-20 08:56:17', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(208, 1, 1, '2017-08-20 08:57:47', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(209, 1, 1, '2017-08-20 08:58:49', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(210, 1, 1, '2017-08-20 08:58:59', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(211, 1, 1, '2017-08-20 09:00:21', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(212, 1, 1, '2017-08-20 09:01:02', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(213, 1, 1, '2017-08-20 09:01:57', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(214, 1, 1, '2017-08-20 09:04:00', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(215, 1, 1, '2017-08-20 09:04:32', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(216, 1, 1, '2017-08-20 09:04:48', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(217, 1, 1, '2017-08-20 09:05:11', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(218, 1, 1, '2017-08-20 09:06:00', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(219, 1, 1, '2017-08-20 09:06:05', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(220, 1, 1, '2017-08-20 09:06:31', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(221, 1, 1, '2017-08-20 09:06:38', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(222, 1, 1, '2017-08-20 09:07:37', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(223, 1, 1, '2017-08-20 09:07:51', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(224, 1, 1, '2017-08-20 09:09:07', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(225, 1, 1, '2017-08-20 09:11:03', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(226, 1, 1, '2017-08-20 09:11:07', 'Se ha impreso el pdf de la cotización No: 17', '/estimate/17', 'Estimate', 'Print'),
	(227, 1, 1, '2017-08-21 14:15:26', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(228, 1, 1, '2017-08-21 14:44:10', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(229, 1, 1, '2017-08-21 20:13:53', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(230, 1, 1, '2017-08-21 20:21:51', 'Se ha impreso el pdf de la cotización No: 24', '/estimate/24', 'Estimate', 'Print'),
	(231, 1, 1, '2017-08-23 15:25:31', 'Se creó la remisión número: 1 para el cliente pepito perez', '/remision/1', 'Remision', 'Create'),
	(232, 1, 1, '2017-08-23 15:26:46', 'Se eliminó la remisión número: 1', NULL, 'Remision', 'Delete'),
	(233, 1, 1, '2017-08-23 15:27:01', 'Se creó la remisión número: 2 para el cliente pepito perez', '/remision/2', 'Remision', 'Create'),
	(234, 1, 1, '2017-08-23 16:41:56', 'Se eliminó la remisión número: 2', NULL, 'Remision', 'Delete'),
	(235, 1, 1, '2017-08-23 16:50:19', 'Se ha impreso el pdf de la cotización No: 1', '/estimate/1', 'Estimate', 'Print'),
	(236, 1, 1, '2017-08-23 18:20:29', 'Se creó la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Create'),
	(237, 1, 1, '2017-08-23 22:04:03', 'Se actualizó el estado de la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(238, 1, 1, '2017-08-23 22:04:04', 'Se actualizó el estado de la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(239, 1, 1, '2017-08-23 22:04:06', 'Se actualizó el estado de la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(240, 1, 1, '2017-08-23 22:04:08', 'Se actualizó el estado de la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(241, 1, 1, '2017-08-23 22:04:09', 'Se actualizó el estado de la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(242, 1, 1, '2017-08-23 22:04:14', 'Se actualizó el estado de la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(243, 1, 1, '2017-08-25 21:37:43', 'Se creó la Cotización número: 25 para el cliente pepito perez', '/estimate/25', 'Estimate', 'Create'),
	(244, 1, 1, '2017-08-25 21:38:01', 'Se actualizó la Cotización número: 25 para el cliente pepito perez', '/estimate/25', 'Estimate', 'Update'),
	(245, 1, 1, '2017-08-25 21:38:21', 'Se actualizó la Cotización número: 25 para el cliente pepito perez', '/estimate/25', 'Estimate', 'Update'),
	(246, 1, 1, '2017-08-25 21:38:22', 'Se actualizó la Cotización número: 25 para el cliente pepito perez', '/estimate/25', 'Estimate', 'Update'),
	(247, 1, 1, '2017-08-25 21:38:36', 'Se actualizó la Cotización número: 25 para el cliente pepito perez', '/estimate/25', 'Estimate', 'Update'),
	(248, 1, 1, '2017-08-27 09:32:43', 'Se creó la Cotización número: 26 para el cliente pepito perez', '/estimate/26', 'Estimate', 'Create'),
	(249, 1, 1, '2017-08-28 09:13:37', 'Se eliminó la cotización número: 1', NULL, 'Estimate', 'Delete'),
	(250, 1, 1, '2017-08-28 21:12:44', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(251, 1, 1, '2017-08-28 21:13:37', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(252, 1, 1, '2017-08-28 21:13:54', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(253, 1, 1, '2017-08-28 21:14:28', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(254, 1, 1, '2017-08-28 21:14:37', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(255, 1, 1, '2017-08-28 21:15:22', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(256, 1, 1, '2017-08-28 21:18:52', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(257, 1, 1, '2017-08-28 21:20:48', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(258, 1, 1, '2017-08-28 21:20:55', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(259, 1, 1, '2017-08-28 22:09:17', 'Se ha impreso el pdf de la remision No: 3 ', '/remision/3 ', 'Remision', 'Print'),
	(260, 1, 1, '2017-08-28 22:17:46', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(261, 1, 1, '2017-08-29 06:49:34', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(262, 1, 1, '2017-08-29 07:03:22', 'Se actualizó el estado de la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(263, 1, 1, '2017-08-29 07:03:40', 'Se actualizó el estado de la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(264, 1, 1, '2017-08-29 07:31:39', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(265, 1, 1, '2017-08-29 07:50:41', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(266, 1, 1, '2017-08-29 08:34:46', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(267, 1, 1, '2017-08-29 08:38:15', 'Se actualizó la Cotización número: 26 para el cliente pepito perez', '/estimate/26', 'Estimate', 'Update'),
	(268, 1, 1, '2017-08-29 08:39:10', 'Se actualizó la Cotización número: 26 para el cliente pepito perez', '/estimate/26', 'Estimate', 'Update'),
	(269, 1, 1, '2017-08-29 08:40:20', 'Se actualizó la Cotización número: 26 para el cliente pepito perez', '/estimate/26', 'Estimate', 'Update'),
	(270, 1, 1, '2017-08-29 09:04:48', 'Se actualizó la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(271, 1, 1, '2017-08-29 09:30:24', 'Se creó la remisión número: 4 para el cliente pepito perez', '/remision/4', 'Remision', 'Create'),
	(272, 1, 1, '2017-08-29 09:37:50', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(273, 1, 1, '2017-08-29 09:38:06', 'Se actualizó la remisión número: 4 para el cliente pepito perez', '/remision/4', 'Remision', 'Update'),
	(274, 1, 1, '2017-08-29 09:50:25', 'Se actualizó el estado de la remisión número: 4 para el cliente pepito perez', '/remision/4', 'Remision', 'Update'),
	(275, 1, 1, '2017-08-29 11:03:08', 'Se ha impreso el pdf de la remision No: 4', '/remision/4', 'Remision', 'Print'),
	(276, 1, 1, '2017-08-29 11:07:21', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(277, 1, 1, '2017-08-29 12:08:19', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(278, 1, 1, '2017-08-29 12:15:50', 'Se ha impreso el pdf de la remision No: 4', '/remision/4', 'Remision', 'Print'),
	(279, 1, 1, '2017-08-29 12:15:55', 'Se ha impreso el pdf de la remision No: 3', '/remision/3', 'Remision', 'Print'),
	(280, 1, 1, '2017-08-29 13:00:32', 'Se actualizó el estado de la remisión número: 4 para el cliente pepito perez', '/remision/4', 'Remision', 'Update'),
	(281, 1, 1, '2017-08-29 13:03:51', 'Se actualizó el estado de la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(282, 1, 1, '2017-08-29 13:04:10', 'Se actualizó el estado de la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(283, 1, 1, '2017-08-29 13:08:26', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(284, 1, 1, '2017-08-29 13:08:31', 'Se actualizó el estado de la remisión número: 4 para el cliente pepito perez', '/remision/4', 'Remision', 'Update'),
	(285, 1, 1, '2017-08-29 13:08:55', 'Se actualizó el estado de la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(286, 1, 1, '2017-08-29 13:09:29', 'Se actualizó el estado de la remisión número: 4 para el cliente pepito perez', '/remision/4', 'Remision', 'Update'),
	(287, 1, 1, '2017-08-29 13:10:47', 'Se actualizó el estado de la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(288, 1, 1, '2017-08-29 13:10:51', 'Se actualizó el estado de la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(289, 1, 1, '2017-08-29 13:14:26', 'Se actualizó el estado de la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(290, 1, 1, '2017-08-29 13:15:07', 'Se actualizó el estado de la remisión número: 4 para el cliente pepito perez', '/remision/4', 'Remision', 'Update'),
	(291, 1, 1, '2017-08-29 13:16:52', 'Se actualizó el estado de la remisión número: 4 para el cliente pepito perez', '/remision/4', 'Remision', 'Update'),
	(292, 1, 1, '2017-08-29 13:17:02', 'Se actualizó el estado de la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(293, 1, 1, '2017-08-29 13:17:42', 'Se actualizó el estado de la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(294, 1, 1, '2017-08-29 13:18:56', 'Se actualizó el estado de la remisión número: 4 para el cliente pepito perez', '/remision/4', 'Remision', 'Update'),
	(295, 1, 1, '2017-08-29 13:20:29', 'Se actualizó el estado de la remisión número: 4 para el cliente pepito perez', '/remision/4', 'Remision', 'Update'),
	(296, 1, 1, '2017-08-29 13:21:57', 'Se actualizó el estado de la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(297, 1, 1, '2017-08-29 13:23:03', 'Se actualizó el estado de la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(298, 1, 1, '2017-08-29 13:23:24', 'Se actualizó el estado de la remisión número: 4 para el cliente pepito perez', '/remision/4', 'Remision', 'Update'),
	(299, 1, 1, '2017-08-29 13:24:32', 'Se actualizó el estado de la remisión número: 4 para el cliente pepito perez', '/remision/4', 'Remision', 'Update'),
	(300, 1, 1, '2017-08-29 13:25:43', 'Se actualizó el estado de la remisión número: 4 para el cliente pepito perez', '/remision/4', 'Remision', 'Update'),
	(301, 1, 1, '2017-08-29 13:27:49', 'Se actualizó el estado de la remisión número: 4 para el cliente pepito perez', '/remision/4', 'Remision', 'Update'),
	(302, 1, 1, '2017-08-29 13:27:53', 'Se actualizó el estado de la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(303, 1, 1, '2017-08-29 13:28:54', 'Se actualizó el estado de la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(304, 1, 1, '2017-08-29 13:28:57', 'Se actualizó el estado de la remisión número: 4 para el cliente pepito perez', '/remision/4', 'Remision', 'Update'),
	(305, 1, 1, '2017-08-29 13:29:24', 'Se actualizó el estado de la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(306, 1, 1, '2017-08-29 13:29:25', 'Se actualizó el estado de la remisión número: 4 para el cliente pepito perez', '/remision/4', 'Remision', 'Update'),
	(307, 1, 1, '2017-08-29 13:30:46', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(308, 1, 1, '2017-08-29 13:30:51', 'Se actualizó el estado de la remisión número: 4 para el cliente pepito perez', '/remision/4', 'Remision', 'Update'),
	(309, 1, 1, '2017-08-29 13:30:55', 'Se actualizó el estado de la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(310, 1, 1, '2017-08-29 13:32:39', 'Se actualizó el estado de la remisión número: 4 para el cliente pepito perez', '/remision/4', 'Remision', 'Update'),
	(311, 1, 1, '2017-08-29 13:32:42', 'Se actualizó el estado de la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(312, 1, 1, '2017-08-29 13:44:39', 'Se actualizó el estado de la remisión número: 4 para el cliente pepito perez', '/remision/4', 'Remision', 'Update'),
	(313, 1, 1, '2017-08-29 13:44:42', 'Se actualizó el estado de la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(314, 1, 1, '2017-08-29 13:44:47', 'Se actualizó el estado de la remisión número: 4 para el cliente pepito perez', '/remision/4', 'Remision', 'Update'),
	(315, 1, 1, '2017-08-29 13:45:54', 'Se creó la Nota Crédito número: 1 para el cliente pepito perez', '/credit-note/1', 'CreditNote', 'Create'),
	(316, 1, 1, '2017-08-29 13:51:26', 'Se actualizó el estado de la remisión número: 4 para el cliente pepito perez', '/remision/4', 'Remision', 'Update'),
	(317, 1, 1, '2017-08-29 13:52:46', 'Se actualizó la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(318, 1, 1, '2017-08-29 13:53:06', 'Se actualizó la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(319, 1, 1, '2017-08-29 13:54:48', 'Se actualizó la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(320, 1, 1, '2017-08-29 13:55:45', 'Se actualizó la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(321, 1, 1, '2017-08-29 13:57:08', 'Se actualizó la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(322, 1, 1, '2017-08-29 13:57:30', 'Se actualizó la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(323, 1, 1, '2017-08-29 13:59:11', 'Se actualizó el estado de la remisión número: 4 para el cliente pepito perez', '/remision/4', 'Remision', 'Update'),
	(324, 1, 1, '2017-08-29 14:07:29', 'Se actualizó la remisión número: 4 para el cliente pepito perez', '/remision/4', 'Remision', 'Update'),
	(325, 1, 1, '2017-08-29 14:07:44', 'Se actualizó la remisión número: 4 para el cliente pepito perez', '/remision/4', 'Remision', 'Update'),
	(326, 1, 1, '2017-08-29 14:08:04', 'Se actualizó la Cotización número: 24 para el cliente pepito perez', '/estimate/24', 'Estimate', 'Update'),
	(327, 1, 1, '2017-08-29 14:15:51', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(328, 1, 1, '2017-08-29 14:16:05', 'Se ha impreso el pdf de la cotización No: 26', '/estimate/26', 'Estimate', 'Print'),
	(329, 1, 1, '2017-08-29 14:22:09', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(330, 1, 1, '2017-08-29 14:27:05', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(331, 1, 1, '2017-08-29 14:34:11', 'Se actualizó el estado de la remisión número: 4 para el cliente pepito perez', '/remision/4', 'Remision', 'Update'),
	(332, 1, 1, '2017-08-29 17:36:49', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(333, 1, 1, '2017-08-29 17:36:55', 'Se actualizó el estado de la remisión número: 4 para el cliente pepito perez', '/remision/4', 'Remision', 'Update'),
	(334, 1, 1, '2017-08-29 17:36:58', 'Se actualizó el estado de la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(335, 1, 1, '2017-08-29 17:55:53', 'Se ha impreso el pdf de la Nota Crédito No: 1', '/credit-note/1', 'CreditNote', 'Print'),
	(336, 1, 1, '2017-08-29 18:12:56', 'Se creó la Nota Crédito número: 2 para el cliente pepito perez', '/credit-note/2', 'CreditNote', 'Create'),
	(337, 1, 1, '2017-08-29 18:17:06', 'Se actualizó la Nota Crédito número: 2 para el cliente pepito perez', '/credit-note/2', 'CreditNote', 'Update'),
	(338, 1, 1, '2017-08-29 18:18:30', 'Se actualizó la Nota Crédito número: 2 para el cliente pepito perez', '/credit-note/2', 'CreditNote', 'Update'),
	(339, 1, 1, '2017-08-29 18:25:18', 'Se actualizó la Nota Crédito número: 2 para el cliente pepito perez', '/credit-note/2', 'CreditNote', 'Update'),
	(340, 1, 1, '2017-08-29 18:27:44', 'Se ha impreso el pdf de la Nota Crédito No: 2 ', '/credit-note/2 ', 'CreditNote', 'Print'),
	(341, 1, 1, '2017-08-29 18:38:06', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(342, 1, 1, '2017-08-29 18:40:48', 'Se creó la Nota Crédito número: 3 para el cliente pepito perez', '/credit-note/3', 'CreditNote', 'Create'),
	(343, 1, 1, '2017-08-29 19:08:19', 'Se ha creado el ingreso número: 1 para el cliente pepito perez', '/payment-in/2', 'Payment', 'Create'),
	(344, 1, 1, '2017-08-29 20:03:47', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(345, 1, 1, '2017-08-29 20:21:22', 'Se ha creado el ingreso número: 2 para el cliente pepito perez', '/payment-in/3', 'Payment', 'Create'),
	(346, 1, 1, '2017-08-29 20:59:40', 'Se ha impreso el pdf para el comprobante de ingreso No: 2', '/payment-in/2', 'Payment-out', 'Print'),
	(347, 1, 1, '2017-08-29 20:59:51', 'Se ha impreso el pdf para el comprobante de ingreso No: 3', '/payment-in/3', 'Payment-out', 'Print'),
	(348, 1, 1, '2017-08-29 21:00:27', 'Se ha impreso el pdf para el comprobante de ingreso No: 2', '/payment-in/2', 'Payment-out', 'Print'),
	(349, 1, 1, '2017-08-29 21:00:37', 'Se ha impreso el pdf para el comprobante de ingreso No: 2', '/payment-in/2', 'Payment-out', 'Print'),
	(350, 1, 1, '2017-08-29 21:04:08', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(351, 1, 1, '2017-08-29 21:07:38', 'Se actualizó el estado del pago número: 1 para el cliente pepito perez', '/payment-in/2', 'Payment', 'Update'),
	(352, 1, 1, '2017-08-29 21:23:50', 'Se actualizó el estado del pago número: 1 para el cliente pepito perez', '/payment-in/2', 'Payment', 'Update'),
	(353, 1, 1, '2017-08-29 21:23:53', 'Se actualizó el estado del pago número: 2 para el cliente pepito perez', '/payment-in/3', 'Payment', 'Update'),
	(354, 1, 1, '2017-08-29 22:06:53', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(355, 1, 1, '2017-08-30 06:44:12', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(356, 1, 1, '2017-08-30 07:45:47', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(357, 1, 1, '2017-08-30 08:45:53', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(358, 1, 1, '2017-08-30 09:46:29', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(359, 1, 1, '2017-08-30 12:00:45', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(360, 1, 1, '2017-08-31 08:18:02', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(361, 1, 1, '2017-09-01 16:05:47', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(362, 1, 1, '2017-09-01 17:32:51', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(363, 1, 1, '2017-09-01 18:53:54', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(364, 1, 1, '2017-09-01 20:10:54', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(365, 1, 1, '2017-09-01 21:11:27', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(366, 1, 1, '2017-09-01 22:13:34', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(367, 1, 1, '2017-09-01 22:17:26', 'Se ha creado el ingreso número: 3 para el cliente pepito perez', '/payment-in/4', 'Payment', 'Create'),
	(368, 1, 1, '2017-09-03 20:16:31', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(369, 1, 1, '2017-09-03 20:17:12', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(370, 1, 1, '2017-09-03 20:19:26', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(371, 1, 1, '2017-09-03 20:36:44', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(372, 1, 1, '2017-09-03 20:39:34', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(373, 1, 1, '2017-09-03 20:40:19', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(374, 1, 1, '2017-09-03 20:51:45', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(375, 1, 1, '2017-09-03 20:56:36', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(376, 1, 1, '2017-09-03 21:13:42', 'Se creó la Nota Crédito número: 4 para el cliente pepito perez', '/credit-note/4', 'CreditNote', 'Create'),
	(377, 1, 1, '2017-09-03 21:13:57', 'Se actualizó la Nota Crédito número: 4 para el cliente pepito perez', '/credit-note/4', 'CreditNote', 'Update'),
	(378, 1, 1, '2017-09-03 21:37:35', 'Se ha impreso el pdf de la Nota Crédito No: 4', '/credit-note/4', 'CreditNote', 'Print'),
	(379, 1, 1, '2017-09-03 21:37:43', 'Se ha impreso el pdf de la Nota Crédito No: 4', '/credit-note/4', 'CreditNote', 'Print'),
	(380, 1, 1, '2017-09-03 21:37:51', 'Se ha impreso el pdf de la Nota Crédito No: 4', '/credit-note/4', 'CreditNote', 'Print'),
	(381, 1, 1, '2017-09-04 14:42:42', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(382, 1, 1, '2017-09-04 16:11:56', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(383, 1, 1, '2017-09-04 17:21:46', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(384, 1, 1, '2017-09-04 19:20:25', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(385, 1, 1, '2017-09-04 20:20:30', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(386, 1, 1, '2017-09-04 20:30:06', 'Se ha impreso el pdf para el comprobante de ingreso No: 4 ', '/payment-in/4 ', 'Payment-out', 'Print'),
	(387, 1, 1, '2017-09-04 20:30:32', 'Se ha impreso el pdf para el comprobante de ingreso No: 4', '/payment-in/4', 'Payment-out', 'Print'),
	(388, 1, 1, '2017-09-04 20:34:40', 'Se ha impreso el pdf para el comprobante de ingreso No: 3 ', '/payment-in/3 ', 'Payment-out', 'Print'),
	(389, 1, 1, '2017-09-04 20:34:47', 'Se ha impreso el pdf para el comprobante de ingreso No: 3', '/payment-in/3', 'Payment-out', 'Print'),
	(390, 1, 1, '2017-09-04 20:34:55', 'Se ha impreso el pdf para el comprobante de ingreso No: 4', '/payment-in/4', 'Payment-out', 'Print'),
	(391, 1, 1, '2017-09-04 20:35:46', 'Se ha impreso el pdf para el comprobante de ingreso No: 4 ', '/payment-in/4 ', 'Payment-out', 'Print'),
	(392, 1, 1, '2017-09-04 21:21:19', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(393, 1, 1, '2017-09-04 21:51:35', 'Se actualizó el pago número: 2 para el cliente pepito perez', '/payment/3', 'Payment', 'Update'),
	(394, 1, 1, '2017-09-04 21:51:48', 'Se actualizó el pago número: 2 para el cliente pepito perez', '/payment/3', 'Payment', 'Update'),
	(395, 1, 1, '2017-09-04 21:52:21', 'Se actualizó el pago número: 2 para el cliente pepito perez', '/payment/3', 'Payment', 'Update'),
	(396, 1, 1, '2017-09-04 21:53:00', 'Se actualizó el pago número: 3 para el cliente pepito perez', '/payment/4', 'Payment', 'Update'),
	(397, 1, 1, '2017-09-04 21:53:50', 'Se actualizó el estado del pago número: 2 para el cliente pepito perez', '/payment-in/3', 'Payment', 'Update'),
	(398, 1, 1, '2017-09-04 21:53:54', 'Se actualizó el estado del pago número: 3 para el cliente pepito perez', '/payment-in/4', 'Payment', 'Update'),
	(399, 1, 1, '2017-09-04 21:54:09', 'Se actualizó el estado del pago número: 3 para el cliente pepito perez', '/payment-in/4', 'Payment', 'Update'),
	(400, 1, 1, '2017-09-04 21:54:23', 'Se actualizó el estado del pago número: 3 para el cliente pepito perez', '/payment-in/4', 'Payment', 'Update'),
	(401, 1, 1, '2017-09-04 21:56:57', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(402, 1, 1, '2017-09-04 21:58:23', 'Se actualizó la Nota Crédito número: 4 para el cliente pepito perez', '/credit-note/4', 'CreditNote', 'Update'),
	(403, 1, 1, '2017-09-04 22:01:01', 'Se actualizó el estado de la remisión número: 4 para el cliente pepito perez', '/remision/4', 'Remision', 'Update'),
	(404, 1, 1, '2017-09-04 22:01:02', 'Se actualizó el estado de la remisión número: 3 para el cliente pepito perez', '/remision/3', 'Remision', 'Update'),
	(405, 1, 1, '2017-09-04 22:03:09', 'Se actualizó el estado del pago número: 2 para el cliente pepito perez', '/payment-in/3', 'Payment', 'Update'),
	(406, 1, 1, '2017-09-04 22:03:09', 'Se actualizó el estado del pago número: 1 para el cliente pepito perez', '/payment-in/2', 'Payment', 'Update'),
	(407, 1, 1, '2017-09-04 22:03:10', 'Se actualizó el estado del pago número: 3 para el cliente pepito perez', '/payment-in/4', 'Payment', 'Update'),
	(408, 1, 1, '2017-09-04 22:03:13', 'Se actualizó el estado del pago número: 2 para el cliente pepito perez', '/payment-in/3', 'Payment', 'Update'),
	(409, 1, 1, '2017-09-04 22:03:25', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(410, 1, 1, '2017-09-04 22:03:36', 'Se ha impreso el pdf de la cotización No: 26', '/estimate/26', 'Estimate', 'Print'),
	(411, 1, 1, '2017-09-04 22:04:11', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(412, 1, 1, '2017-09-05 07:13:01', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(413, 1, 1, '2017-09-05 16:30:53', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(414, 1, 1, '2017-09-05 16:30:53', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(415, 1, 1, '2017-09-05 16:30:54', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(416, 1, 1, '2017-09-05 16:30:55', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(417, 1, 1, '2017-09-05 16:30:56', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(418, 1, 1, '2017-09-06 07:18:33', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(419, 1, 1, '2017-09-06 08:21:02', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(420, 1, 1, '2017-09-06 09:24:11', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(421, 1, 1, '2017-09-06 10:24:28', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(422, 1, 1, '2017-09-06 10:52:21', 'Se ha creado el ingreso número: 4 para el cliente pepito perez', '/payment-in/5', 'Payment', 'Create'),
	(423, 1, 1, '2017-09-06 10:54:52', 'Se ha creado el ingreso número: 5 para el cliente pepito perez', '/payment-in/6', 'Payment', 'Create'),
	(424, 1, 1, '2017-09-06 10:57:36', 'Se ha creado el ingreso número: 6 para el cliente pepito perez', '/payment-in/7', 'Payment', 'Create'),
	(425, 1, 1, '2017-09-06 11:24:32', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(426, 1, 1, '2017-09-06 12:26:33', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(427, 1, 1, '2017-09-06 12:32:34', 'Se ha impreso el pdf para el comprobante de ingreso No: 7', '/payment-in/7', 'Payment-out', 'Print'),
	(428, 1, 1, '2017-09-06 12:32:52', 'Se ha impreso el pdf para el comprobante de ingreso No: 6', '/payment-in/6', 'Payment-out', 'Print'),
	(429, 1, 1, '2017-09-06 13:26:55', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(430, 1, 1, '2017-09-06 14:28:07', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(431, 1, 1, '2017-09-06 14:53:46', 'Se actualizó el estado del pago número: 1 para el cliente pepito perez', '/payment-in/2', 'Payment', 'Update'),
	(432, 1, 1, '2017-09-06 15:28:30', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(433, 1, 1, '2017-09-06 16:43:27', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(434, 1, 1, '2017-09-06 17:26:36', 'Se ha impreso el pdf para el comprobante de ingreso No: 4', '/payment-in/4', 'Payment-out', 'Print'),
	(435, 1, 1, '2017-09-06 17:45:15', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(436, 1, 1, '2017-09-06 21:12:47', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(437, 1, 1, '2017-09-07 07:55:27', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(438, 1, 1, '2017-09-07 08:54:56', 'Se ha creado el ingreso número: 9 para el cliente pepito perez', '/payment-in/10', 'Payment', 'Create'),
	(439, 1, 1, '2017-09-07 08:55:47', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(440, 1, 1, '2017-09-07 08:57:52', 'Se ha creado el ingreso número: 10 para el cliente pepito perez', '/payment-in/11', 'Payment', 'Create'),
	(441, 1, 1, '2017-09-07 08:59:10', 'Se eliminó el pago número: 1', NULL, 'Payment', 'Delete'),
	(442, 1, 1, '2017-09-07 08:59:46', 'Se ha impreso el pdf para el comprobante de ingreso No: 10 ', '/payment-in/10 ', 'Payment-out', 'Print'),
	(443, 1, 1, '2017-09-07 10:00:26', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(444, 1, 1, '2017-09-07 11:04:55', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(445, 1, 1, '2017-09-07 12:56:56', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(446, 1, 1, '2017-09-07 13:57:23', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(447, 1, 1, '2017-09-07 14:57:59', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(448, 1, 1, '2017-09-07 16:23:37', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(449, 1, 1, '2017-09-07 16:56:22', 'Se creó la factura de venta número: 15 para el cliente pepito perez', '/invoice/15', 'InvoiceSaleOrder', 'Create'),
	(450, 1, 1, '2017-09-07 17:49:57', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(451, 1, 1, '2017-09-07 17:57:33', 'Se actualizó la factura de venta número: 16 para el cliente pepito perez', '/invoice/15', 'InvoiceSaleOrder', 'Update'),
	(452, 1, 1, '2017-09-07 18:01:28', 'Se actualizó la factura de venta número: 16 para el cliente pepito perez', '/invoice/15', 'InvoiceSaleOrder', 'Update'),
	(453, 1, 1, '2017-09-07 18:01:50', 'Se actualizó la factura de venta número: 16 para el cliente pepito perez', '/invoice/15', 'InvoiceSaleOrder', 'Update'),
	(454, 1, 1, '2017-09-07 18:20:38', 'Se creó la factura de venta número: 16 para el cliente pepito perez', '/invoice/16', 'InvoiceSaleOrder', 'Create'),
	(455, 1, 1, '2017-09-07 18:22:19', 'Se actualizó la factura de venta número: 16 para el cliente pepito perez', '/invoice/16', 'InvoiceSaleOrder', 'Update'),
	(456, 1, 1, '2017-09-07 18:47:58', 'Se creó la factura de venta número: 17 para el cliente pepito perez', '/invoice/17', 'InvoiceSaleOrder', 'Create'),
	(457, 1, 1, '2017-09-07 18:50:16', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(458, 1, 1, '2017-09-07 18:50:32', 'Se creó la factura de venta número: 18 para el cliente pepito perez', '/invoice/18', 'InvoiceSaleOrder', 'Create'),
	(459, 1, 1, '2017-09-07 18:50:53', 'Se creó la factura de venta número: 19 para el cliente pepito perez', '/invoice/19', 'InvoiceSaleOrder', 'Create'),
	(460, 1, 1, '2017-09-07 18:53:51', 'Se ha impreso el pdf de la factura de venta No: 17 ', '/invoice/17 ', 'InvoiceSaleOrder', 'Print'),
	(461, 1, 1, '2017-09-07 21:30:28', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(462, 1, 1, '2017-09-08 07:21:43', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(463, 1, 1, '2017-09-08 10:52:30', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(464, 1, 1, '2017-09-08 11:55:21', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(465, 1, 1, '2017-09-08 12:34:34', 'Se creó la factura de proveedor número: 2 para el cliente pepito perez', '/bill/2', 'Bill', 'Create'),
	(466, 1, 1, '2017-09-08 12:35:43', 'Se actualizó el estado de la factura de venta número: 1 para el cliente pepito perez', '/bill/1', 'Bill', 'Update'),
	(467, 1, 1, '2017-09-08 12:38:38', 'Se actualizó la factura de proveedores número: 2 para el cliente pepito perez', '/bill/2', 'Bill', 'Update'),
	(468, 1, 1, '2017-09-08 12:40:31', 'Se creó la factura de proveedor número: 2 para el cliente pepito perez', '/bill/3', 'Bill', 'Create'),
	(469, 1, 1, '2017-09-08 12:46:03', 'Se creó la factura de proveedor número: 4 para el cliente pepito perez', '/bill/4', 'Bill', 'Create'),
	(470, 1, 1, '2017-09-08 12:46:38', 'Se creó la factura de proveedor número: 5 para el cliente pepito perez', '/bill/5', 'Bill', 'Create'),
	(471, 1, 1, '2017-09-08 12:48:07', 'Se ha impreso el pdf de la factura de venta No: 1', '/bill/1', 'Bill', 'Print'),
	(472, 1, 1, '2017-09-08 12:48:25', 'Se ha impreso el pdf de la factura de venta No: 1', '/bill/1', 'Bill', 'Print'),
	(473, 1, 1, '2017-09-08 13:00:28', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(474, 1, 1, '2017-09-08 13:32:18', 'Se creó la Nota Débito número: 2 para el cliente pepito perez', '/debit-note/2', 'DebitNote', 'Create'),
	(475, 1, 1, '2017-09-08 13:34:57', 'Se creó la Nota Débito número: 3 para el cliente pepito perez', '/debit-note/3', 'DebitNote', 'Create'),
	(476, 1, 1, '2017-09-08 13:36:30', 'Se actualizó la Nota Debito número: 3 para el cliente pepito perez', '/debit-note/3', 'DebitNote', 'Update'),
	(477, 1, 1, '2017-09-08 13:36:43', 'Se ha impreso el pdf de la Nota Débito No: 3 ', '/debit-note/3 ', 'DebitNote', 'Print'),
	(478, 1, 1, '2017-09-08 13:36:52', 'Se ha impreso el pdf de la Nota Débito No: 3', '/debit-note/3', 'DebitNote', 'Print'),
	(479, 1, 1, '2017-09-08 13:39:58', 'Se creó la Orden de Compra número: 1 para el cliente pepito perez', '/purchase-order/1', 'PurchaseOrder', 'Create'),
	(480, 1, 1, '2017-09-08 14:00:29', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(481, 1, 1, '2017-09-08 14:27:56', 'Se actualizó la Orden de Compra número: 1 para el cliente pepito perez', '/purchase-order/1', 'PurchaseOrder', 'Update'),
	(482, 1, 1, '2017-09-08 14:37:49', 'Se creó la factura de proveedor número: 6 para el cliente pepito perez', '/bill/6', 'Bill', 'Create'),
	(483, 1, 1, '2017-09-08 15:04:36', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(484, 1, 1, '2017-09-08 15:12:33', 'Se creó la Orden de Compra número: 2 para el cliente pepito perez', '/purchase-order/2', 'PurchaseOrder', 'Create'),
	(485, 1, 1, '2017-09-08 15:16:40', 'Se actualizó la Orden de Compra número: 2 para el cliente pepito perez', '/purchase-order/2', 'PurchaseOrder', 'Update'),
	(486, 1, 1, '2017-09-08 15:19:51', 'Se eliminó la cotización número: 1', NULL, 'PurchaseOrder', 'Delete'),
	(487, 1, 1, '2017-09-08 15:20:55', 'Se creó la Orden de Compra número: 3 para el cliente pepito perez', '/purchase-order/3', 'PurchaseOrder', 'Create'),
	(488, 1, 1, '2017-09-08 15:21:09', 'Se actualizó la Orden de Compra número: 3 para el cliente pepito perez', '/purchase-order/3', 'PurchaseOrder', 'Update'),
	(489, 1, 1, '2017-09-08 15:43:30', 'Se actualizó el estado del pago número: 1 para el cliente pepito perez', '/payment-out/1', 'Payment', 'Update'),
	(490, 1, 1, '2017-09-08 15:43:33', 'Se actualizó el estado del pago número: 1 para el cliente pepito perez', '/payment-out/1', 'Payment', 'Update'),
	(491, 1, 1, '2017-09-08 15:43:42', 'Se actualizó el estado del pago número: 1 para el cliente pepito perez', '/payment-out/1', 'Payment', 'Update'),
	(492, 1, 1, '2017-09-08 15:43:44', 'Se actualizó el estado del pago número: 1 para el cliente pepito perez', '/payment-out/1', 'Payment', 'Update'),
	(493, 1, 1, '2017-09-08 16:04:58', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(494, 1, 1, '2017-09-08 16:13:58', 'Se creó el comprobante de pago número: 2 para el proveedor pepito perez', '/payment-out/12', 'payment-out', 'Create'),
	(495, 1, 1, '2017-09-08 16:36:54', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(496, 1, 1, '2017-09-08 17:37:15', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(497, 1, 1, '2017-09-08 17:55:30', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(498, 1, 1, '2017-09-08 19:31:30', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(499, 1, 1, '2017-09-08 20:16:48', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(500, 1, 1, '2017-09-08 20:37:47', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(501, 1, 1, '2017-09-09 21:28:26', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(502, 1, 1, '2017-09-11 13:45:43', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(503, 1, 1, '2017-09-11 17:07:34', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(504, 1, 1, '2017-09-11 17:33:02', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(505, 1, 1, '2017-09-11 17:33:12', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(506, 1, 1, '2017-09-11 17:34:02', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(507, 1, 1, '2017-09-11 17:41:31', 'Se creó la Cotización número: 27 para el cliente pepito perez', '/estimate/27', 'Estimate', 'Create'),
	(508, 1, 1, '2017-09-11 17:44:20', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(509, 1, 1, '2017-09-11 18:52:48', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(510, 1, 1, '2017-09-11 18:57:00', 'Se creó la remisión número: 5 para el cliente pepito perez', '/remision/5', 'Remision', 'Create'),
	(511, 1, 1, '2017-09-11 18:57:34', 'Se creó la remisión número: 6 para el cliente pepito perez', '/remision/6', 'Remision', 'Create'),
	(512, 1, 1, '2017-09-11 18:57:45', 'Se actualizó la remisión número: 6 para el cliente pepito perez', '/remision/6', 'Remision', 'Update'),
	(513, 1, 1, '2017-09-11 18:58:13', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(514, 1, 1, '2017-09-11 19:36:20', 'Se creó la remisión número: 7 para el cliente pepito perez', '/remision/7', 'Remision', 'Create'),
	(515, 1, 1, '2017-09-11 19:58:59', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(516, 1, 1, '2017-09-11 20:59:22', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(517, 1, 1, '2017-09-11 21:31:38', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(518, 1, 1, '2017-09-11 22:00:08', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(519, 1, 1, '2017-09-11 22:09:58', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(520, 1, 1, '2017-09-11 22:13:16', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(521, 1, 1, '2017-09-11 22:20:31', 'Se eliminó la remisión número: 3', NULL, 'Remision', 'Delete'),
	(522, 1, 1, '2017-09-11 22:21:00', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(523, 1, 1, '2017-09-12 07:00:33', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(524, 1, 1, '2017-09-12 07:33:43', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(525, 1, 1, '2017-09-12 08:35:37', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(526, 1, 1, '2017-09-12 09:37:05', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(527, 1, 1, '2017-09-12 10:44:16', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(528, 1, 1, '2017-09-12 12:24:34', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(529, 1, 1, '2017-09-12 13:25:24', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(530, 1, 1, '2017-09-12 14:44:51', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(531, 1, 1, '2017-09-12 15:45:02', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(532, 1, 1, '2017-09-12 16:47:31', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(533, 1, 1, '2017-09-12 17:49:14', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(534, 1, 1, '2017-09-12 19:08:16', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(535, 1, 1, '2017-09-12 20:50:44', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(536, 1, 1, '2017-09-13 07:08:46', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(537, 1, 1, '2017-09-13 08:11:55', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(538, 1, 1, '2017-09-13 09:34:04', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(539, 1, 1, '2017-09-13 10:37:52', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(540, 1, 1, '2017-09-13 11:40:16', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(541, 1, 1, '2017-09-13 12:40:56', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(542, 1, 1, '2017-09-13 15:38:27', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(543, 1, 1, '2017-09-13 16:54:14', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(544, 1, 1, '2017-09-13 19:00:04', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(545, 1, 1, '2017-09-13 19:02:13', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(546, 1, 1, '2017-09-13 19:36:38', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(547, 1, 1, '2017-09-13 19:36:42', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(548, 1, 1, '2017-09-13 19:38:39', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(549, 1, 1, '2017-09-13 19:40:47', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(550, 1, 1, '2017-09-13 19:40:59', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(551, 1, 1, '2017-09-13 19:42:10', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(552, 1, 1, '2017-09-13 19:42:15', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(553, 1, 1, '2017-09-13 19:42:22', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(554, 1, 1, '2017-09-13 19:42:47', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(555, 1, 1, '2017-09-14 06:51:20', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(556, 1, 1, '2017-09-14 07:52:01', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(557, 1, 1, '2017-09-14 07:52:49', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(558, 1, 1, '2017-09-14 11:26:00', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(559, 1, 1, '2017-09-14 12:56:12', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(560, 1, 1, '2017-09-14 14:02:03', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(561, 1, 1, '2017-09-14 15:02:14', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(562, 1, 1, '2017-09-14 16:09:49', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(563, 1, 1, '2017-09-14 17:09:55', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(564, 1, 1, '2017-09-14 18:46:27', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(565, 1, 1, '2017-09-14 19:49:56', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(566, 1, 1, '2017-09-14 20:17:58', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(567, 1, 1, '2017-09-14 20:24:38', 'Se actualizó el estado de la factura de venta número: 19 para el cliente pepito perez', '/invoice/19', 'InvoiceSaleOrder', 'Update'),
	(568, 1, 1, '2017-09-14 20:24:42', 'Se actualizó el estado de la factura de venta número: 19 para el cliente pepito perez', '/invoice/19', 'InvoiceSaleOrder', 'Update'),
	(569, 1, 1, '2017-09-14 20:28:24', 'Se actualizó el estado de la factura de venta número: 1 para el cliente pepito perez', '/bill/1', 'Bill', 'Update'),
	(570, 1, 1, '2017-09-14 20:28:28', 'Se actualizó el estado de la factura de venta número: 1 para el cliente pepito perez', '/bill/1', 'Bill', 'Update'),
	(571, 1, 1, '2017-09-14 20:33:46', 'Se actualizó el estado del pago número: 2 para el cliente pepito perez', '/payment-in/3', 'Payment', 'Update'),
	(572, 1, 1, '2017-09-14 20:33:50', 'Se actualizó el estado del pago número: 3 para el cliente pepito perez', '/payment-in/4', 'Payment', 'Update'),
	(573, 1, 1, '2017-09-14 20:34:10', 'Se actualizó el estado del pago número: 3 para el cliente pepito perez', '/payment-in/4', 'Payment', 'Update'),
	(574, 1, 1, '2017-09-14 20:34:13', 'Se actualizó el estado del pago número: 2 para el cliente pepito perez', '/payment-in/3', 'Payment', 'Update'),
	(575, 1, 1, '2017-09-14 20:34:24', 'Se actualizó el estado de la factura de venta número: 19 para el cliente pepito perez', '/invoice/19', 'InvoiceSaleOrder', 'Update'),
	(576, 1, 1, '2017-09-14 20:34:27', 'Se actualizó el estado de la factura de venta número: 18 para el cliente pepito perez', '/invoice/18', 'InvoiceSaleOrder', 'Update'),
	(577, 1, 1, '2017-09-14 20:34:30', 'Se actualizó el estado de la factura de venta número: 14 para el cliente pepito perez', '/invoice/14', 'InvoiceSaleOrder', 'Update'),
	(578, 1, 1, '2017-09-14 20:34:32', 'Se actualizó el estado de la factura de venta número: 15 para el cliente pepito perez', '/invoice/15', 'InvoiceSaleOrder', 'Update'),
	(579, 1, 1, '2017-09-14 20:34:36', 'Se actualizó el estado de la factura de venta número: 16 para el cliente pepito perez', '/invoice/16', 'InvoiceSaleOrder', 'Update'),
	(580, 1, 1, '2017-09-14 20:34:39', 'Se actualizó el estado de la factura de venta número: 15 para el cliente pepito perez', '/invoice/15', 'InvoiceSaleOrder', 'Update'),
	(581, 1, 1, '2017-09-14 20:34:42', 'Se actualizó el estado de la factura de venta número: 16 para el cliente pepito perez', '/invoice/16', 'InvoiceSaleOrder', 'Update'),
	(582, 1, 1, '2017-09-14 20:34:46', 'Se actualizó el estado de la factura de venta número: 14 para el cliente pepito perez', '/invoice/14', 'InvoiceSaleOrder', 'Update'),
	(583, 1, 1, '2017-09-14 20:40:34', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(584, 1, 1, '2017-09-14 20:54:03', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(585, 1, 1, '2017-09-14 21:09:37', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(586, 1, 1, '2017-09-14 21:19:31', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(587, 1, 1, '2017-09-14 21:23:10', 'Se actualizó el estado de la factura de venta número: 19 para el cliente pepito perez', '/invoice/19', 'InvoiceSaleOrder', 'Update'),
	(588, 1, 1, '2017-09-14 21:38:59', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(589, 1, 1, '2017-09-15 10:53:57', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(590, 1, 1, '2017-09-18 07:41:38', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(591, 1, 1, '2017-09-18 08:54:34', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(592, 1, 1, '2017-09-18 09:54:56', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(593, 1, 1, '2017-09-18 10:56:09', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(594, 1, 1, '2017-09-18 11:56:42', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(595, 1, 1, '2017-09-18 20:02:08', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(596, 1, 1, '2017-09-18 21:31:14', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(597, 1, 1, '2017-09-18 21:39:00', 'Se creó la factura de venta número: 20 para el cliente pepito perez', '/invoice/20', 'InvoiceSaleOrder', 'Create'),
	(598, 1, 1, '2017-09-20 09:20:23', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(599, 1, 1, '2017-09-20 09:48:21', 'Se ha creado el ingreso número: 11 para el cliente proveedor', '/payment-in/13', 'Payment', 'Create'),
	(600, 1, 1, '2017-09-21 08:27:29', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(601, 1, 1, '2017-09-21 10:32:49', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(602, 1, 1, '2017-09-21 13:53:25', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(603, 1, 1, '2017-09-24 09:03:28', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(604, 1, 1, '2017-09-24 09:06:05', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(605, 1, 1, '2017-09-24 10:37:12', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(606, 1, 1, '2017-09-24 11:37:28', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(607, 1, 1, '2017-09-24 12:02:56', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(608, 1, 1, '2017-09-24 13:03:48', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(609, 1, 1, '2017-09-24 16:18:51', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(610, 1, 1, '2017-09-24 17:28:37', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(611, 1, 1, '2017-09-24 18:29:11', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(612, 1, 1, '2017-09-24 19:47:10', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(613, 1, 1, '2017-09-24 20:59:05', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(614, 1, 1, '2017-09-24 22:02:18', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(615, 1, 1, '2017-09-24 22:18:36', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(616, 1, 1, '2017-09-25 21:54:15', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(617, 1, 1, '2017-09-26 13:57:24', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(618, 1, 1, '2017-09-26 14:05:33', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(619, 1, 1, '2017-09-26 14:10:00', 'Se ha impreso el pdf de la factura de venta No: 6', '/bill/6', 'Bill', 'Print'),
	(620, 1, 1, '2017-09-26 14:11:34', 'Se creó la Nota Débito número: 4 para el cliente pepito perez', '/debit-note/4', 'DebitNote', 'Create'),
	(621, 1, 1, '2017-10-02 20:39:33', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(622, 1, 1, '2017-10-02 21:05:09', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(623, 1, 1, '2017-10-03 18:01:21', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(624, 1, 1, '2017-10-06 12:34:10', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(625, 1, 1, '2017-10-06 20:16:52', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(626, 1, 1, '2017-10-06 21:00:24', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(627, 1, 1, '2017-10-06 22:04:37', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(628, 1, 1, '2017-10-06 23:09:36', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(629, 1, 1, '2017-10-08 14:05:16', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(630, 1, 1, '2017-10-08 20:44:35', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(631, 1, 1, '2017-10-09 17:08:29', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(632, 1, 1, '2017-10-09 18:12:10', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(633, 1, 1, '2017-10-09 20:00:19', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(634, 1, 1, '2017-10-09 21:28:02', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(635, 1, 1, '2017-10-10 08:22:39', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(636, 1, 1, '2017-10-10 09:10:00', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(637, 1, 1, '2017-10-10 11:09:20', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(638, 1, 1, '2017-10-10 12:09:22', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(639, 1, 1, '2017-10-10 13:10:51', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(640, 1, 1, '2017-10-10 14:15:00', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(641, 1, 1, '2017-10-10 15:17:52', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(642, 1, 1, '2017-10-10 17:24:45', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(643, 1, 1, '2017-10-11 08:05:39', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(644, 1, 1, '2017-10-11 09:39:23', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(645, 1, 1, '2017-10-14 10:59:05', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(646, 1, 1, '2017-10-14 10:59:45', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(647, 1, 1, '2017-10-14 11:50:20', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(648, 1, 1, '2017-10-14 11:51:12', 'Se creó la factura de venta número: 21 para el cliente pepito perez', '/invoice/21', 'InvoiceSaleOrder', 'Create'),
	(649, 1, 1, '2017-10-16 09:30:35', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(650, 1, 1, '2017-10-16 10:41:03', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(651, 1, 1, '2017-10-16 11:45:08', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(652, 1, 1, '2017-10-16 12:45:29', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(653, 1, 1, '2017-10-16 13:48:12', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(654, 1, 1, '2017-10-17 09:08:06', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(655, 1, 1, '2017-10-17 11:27:31', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(656, 1, 1, '2017-10-17 12:54:47', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(657, 1, 1, '2017-10-19 08:53:47', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(658, 1, 1, '2017-10-21 14:03:11', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(659, 1, 1, '2017-10-21 15:52:16', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(660, 1, 1, '2017-10-22 09:36:56', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(661, 1, 1, '2017-10-26 16:14:22', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(662, 1, 1, '2017-10-26 17:59:40', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(663, 1, 1, '2017-10-26 21:19:20', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(664, 1, 1, '2017-10-26 22:40:52', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(665, 1, 1, '2017-10-27 06:49:33', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(666, 1, 1, '2017-10-27 07:15:25', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(667, 1, 1, '2017-10-29 09:17:23', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(668, 1, 1, '2017-10-29 10:26:18', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(669, 1, 1, '2017-10-29 11:46:44', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(670, 1, 1, '2017-10-29 12:47:44', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(671, 1, 1, '2017-10-29 13:54:21', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(672, 1, 1, '2017-10-29 15:01:12', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(673, 1, 1, '2017-10-29 16:33:24', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(674, 1, 1, '2017-10-29 17:43:57', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(675, 1, 1, '2017-10-29 18:46:24', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(676, 1, 1, '2017-10-29 20:03:35', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(677, 1, 1, '2017-10-29 20:24:12', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(678, 1, 1, '2017-10-30 18:58:34', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(679, 1, 1, '2017-10-31 06:47:09', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(680, 1, 1, '2017-10-31 07:52:00', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(681, 1, 1, '2017-11-02 17:08:32', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(682, 1, 1, '2017-11-02 19:00:14', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(683, 1, 1, '2017-11-06 19:40:07', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(684, 1, 1, '2017-11-06 20:34:30', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(685, 1, 1, '2017-11-06 20:52:28', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(686, 1, 1, '2017-11-06 20:55:05', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(687, 1, 1, '2017-11-06 20:56:23', 'Se creó la factura de venta número: 22 para el cliente pepito perez', '/invoice/22', 'InvoiceSaleOrder', 'Create'),
	(688, 1, 1, '2017-11-06 20:58:02', 'Se creó la factura de venta número: 23 para el cliente pepito perez', '/invoice/23', 'InvoiceSaleOrder', 'Create'),
	(689, 1, 1, '2017-11-06 21:02:11', 'Se creó la Cotización número: 28 para el cliente pepito perez', '/estimate/28', 'Estimate', 'Create'),
	(690, 1, 1, '2017-11-06 21:02:37', 'Se creó la Cotización número: 29 para el cliente pepito perez', '/estimate/29', 'Estimate', 'Create'),
	(691, 1, 1, '2017-11-06 21:15:07', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(692, 1, 1, '2017-11-08 09:46:08', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(693, 1, 1, '2017-11-08 19:09:35', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(694, 1, 1, '2017-11-08 20:20:36', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(695, 1, 1, '2017-11-08 21:20:50', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(696, 1, 1, '2017-11-08 22:21:02', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(697, 1, 1, '2017-11-10 20:16:18', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(698, 1, 1, '2017-11-12 10:28:52', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(699, 1, 1, '2017-11-12 11:55:11', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(700, 1, 1, '2017-11-12 13:20:13', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(701, 1, 1, '2017-11-12 20:40:50', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(702, 1, 1, '2017-11-12 21:42:03', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(703, 1, 1, '2017-11-12 22:43:34', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(704, 1, 1, '2017-11-12 23:44:33', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(705, 1, 1, '2017-11-13 09:17:52', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(706, 1, 1, '2017-11-13 10:18:28', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(707, 1, 1, '2017-11-13 14:15:58', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(708, 1, 1, '2017-11-13 15:16:18', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(709, 1, 1, '2017-11-13 16:43:51', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(710, 1, 1, '2017-11-13 17:44:07', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(711, 1, 1, '2017-11-13 18:47:56', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(712, 1, 1, '2017-11-13 19:46:54', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(713, 1, 1, '2017-11-13 19:55:07', 'Se creó la factura de venta número: 24 para el cliente pepito perez', '/invoice/24', 'InvoiceSaleOrder', 'Create'),
	(714, 1, 1, '2017-11-13 19:56:18', 'Se actualizó la factura de venta número: 24 para el cliente pepito perez', '/invoice/24', 'InvoiceSaleOrder', 'Update'),
	(715, 1, 1, '2017-11-13 19:59:14', 'Se creó la Cotización número: 30 para el cliente Fernando Ardila 2', '/estimate/30', 'Estimate', 'Create'),
	(716, 1, 1, '2017-11-13 20:23:10', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(717, 1, 1, '2017-11-13 20:23:37', 'Se creó la factura de venta número: 25 para el cliente pepito perez', '/invoice/25', 'InvoiceSaleOrder', 'Create'),
	(718, 1, 1, '2017-12-03 19:51:34', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(719, 1, 1, '2017-12-03 21:25:44', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(720, 1, 1, '2017-12-03 22:26:38', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(721, 1, 1, '2017-12-10 18:20:44', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(722, 1, 1, '2017-12-10 20:39:44', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(723, 1, 1, '2017-12-27 21:43:29', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(724, 1, 1, '2017-12-27 22:24:04', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(725, 1, 1, '2017-12-30 11:57:20', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(726, 1, 1, '2017-12-30 11:57:27', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(727, 1, 1, '2017-12-30 12:08:54', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(728, 1, 1, '2017-12-30 13:00:50', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(729, 1, 1, '2017-12-30 13:05:05', 'Se creó la factura de venta número: 26 para el cliente pepito perez', '/invoice/26', 'InvoiceSaleOrder', 'Create'),
	(730, 1, 1, '2017-12-30 14:01:48', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(731, 1, 1, '2018-01-03 20:10:04', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(732, 1, 1, '2018-01-03 21:13:46', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(733, 1, 1, '2018-01-03 22:16:41', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(734, 1, 1, '2018-01-03 22:32:55', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(735, 1, 1, '2018-01-03 22:38:08', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(736, 1, 1, '2018-01-07 20:37:17', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(737, 1, 1, '2018-01-08 19:03:26', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(738, 1, 1, '2018-01-08 21:40:40', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(739, 1, 1, '2018-01-24 21:31:47', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(740, 1, 1, '2018-01-31 21:56:13', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(741, 1, 1, '2018-01-31 23:01:19', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(742, 1, 1, '2018-02-08 20:22:51', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(743, 1, 1, '2018-02-15 20:22:47', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(744, 1, 1, '2018-02-21 22:22:33', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(745, 1, 1, '2018-03-04 20:29:04', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(746, 1, 1, '2018-04-29 20:17:28', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(747, 1, 1, '2018-04-30 19:31:46', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(748, 1, 1, '2018-04-30 21:46:35', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(749, 1, 1, '2018-04-30 22:46:56', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(750, 1, 1, '2018-05-01 10:17:55', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(751, 1, 1, '2018-05-01 10:17:55', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(752, 1, 1, '2018-05-01 20:00:39', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(753, 1, 1, '2018-05-01 21:02:15', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(754, 1, 1, '2018-05-01 22:04:01', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(755, 1, 1, '2018-05-02 20:52:55', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(756, 1, 1, '2018-05-03 22:01:42', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(757, 1, 1, '2018-05-03 22:03:25', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(758, 1, 1, '2018-05-03 22:13:04', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(759, 1, 1, '2018-05-05 09:31:20', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(760, 1, 1, '2018-05-05 10:31:50', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(761, 1, 1, '2018-05-05 11:00:35', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(762, 1, 1, '2018-05-05 11:08:37', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(763, 1, 1, '2018-05-06 13:47:02', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(764, 1, 1, '2018-05-06 19:51:56', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(765, 1, 1, '2018-05-06 20:48:20', 'Se actualizó el estado de la factura de venta número: 18 para el cliente pepito perez', '/invoice/18', 'InvoiceSaleOrder', 'Update'),
	(766, 1, 1, '2018-05-06 20:48:23', 'Se actualizó el estado de la factura de venta número: 18 para el cliente pepito perez', '/invoice/18', 'InvoiceSaleOrder', 'Update'),
	(767, 1, 1, '2018-05-06 20:48:23', 'Se actualizó el estado de la factura de venta número: 19 para el cliente pepito perez', '/invoice/19', 'InvoiceSaleOrder', 'Update'),
	(768, 1, 1, '2018-05-06 20:48:23', 'Se actualizó el estado de la factura de venta número: 19 para el cliente pepito perez', '/invoice/19', 'InvoiceSaleOrder', 'Update'),
	(769, 1, 1, '2018-05-06 20:48:23', 'Se actualizó el estado de la factura de venta número: 19 para el cliente pepito perez', '/invoice/19', 'InvoiceSaleOrder', 'Update'),
	(770, 1, 1, '2018-05-06 20:49:05', 'Se actualizó el estado de la factura de venta número: 25 para el cliente pepito perez', '/invoice/25', 'InvoiceSaleOrder', 'Update'),
	(771, 1, 1, '2018-05-06 20:49:05', 'Se actualizó el estado de la factura de venta número: 25 para el cliente pepito perez', '/invoice/25', 'InvoiceSaleOrder', 'Update'),
	(772, 1, 1, '2018-05-06 20:49:06', 'Se actualizó el estado de la factura de venta número: 25 para el cliente pepito perez', '/invoice/25', 'InvoiceSaleOrder', 'Update'),
	(773, 1, 1, '2018-05-06 20:49:07', 'Se actualizó el estado de la factura de venta número: 25 para el cliente pepito perez', '/invoice/25', 'InvoiceSaleOrder', 'Update'),
	(774, 1, 1, '2018-05-06 20:49:07', 'Se actualizó el estado de la factura de venta número: 25 para el cliente pepito perez', '/invoice/25', 'InvoiceSaleOrder', 'Update'),
	(775, 1, 1, '2018-05-06 20:49:08', 'Se actualizó el estado de la factura de venta número: 26 para el cliente pepito perez', '/invoice/26', 'InvoiceSaleOrder', 'Update'),
	(776, 1, 1, '2018-05-06 20:49:12', 'Se actualizó el estado de la factura de venta número: 21 para el cliente pepito perez', '/invoice/21', 'InvoiceSaleOrder', 'Update'),
	(777, 1, 1, '2018-05-06 20:49:14', 'Se actualizó el estado de la factura de venta número: 19 para el cliente pepito perez', '/invoice/19', 'InvoiceSaleOrder', 'Update'),
	(778, 1, 1, '2018-05-06 20:49:15', 'Se actualizó el estado de la factura de venta número: 20 para el cliente pepito perez', '/invoice/20', 'InvoiceSaleOrder', 'Update'),
	(779, 1, 1, '2018-05-06 20:49:16', 'Se actualizó el estado de la factura de venta número: 21 para el cliente pepito perez', '/invoice/21', 'InvoiceSaleOrder', 'Update'),
	(780, 1, 1, '2018-05-06 20:49:17', 'Se actualizó el estado de la factura de venta número: 22 para el cliente pepito perez', '/invoice/22', 'InvoiceSaleOrder', 'Update'),
	(781, 1, 1, '2018-05-06 20:49:18', 'Se actualizó el estado de la factura de venta número: 22 para el cliente pepito perez', '/invoice/22', 'InvoiceSaleOrder', 'Update'),
	(782, 1, 1, '2018-05-06 20:49:19', 'Se actualizó el estado de la factura de venta número: 22 para el cliente pepito perez', '/invoice/22', 'InvoiceSaleOrder', 'Update'),
	(783, 1, 1, '2018-05-06 20:49:20', 'Se actualizó el estado de la factura de venta número: 23 para el cliente pepito perez', '/invoice/23', 'InvoiceSaleOrder', 'Update'),
	(784, 1, 1, '2018-05-06 20:53:48', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(785, 1, 1, '2018-05-09 19:30:50', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(786, 1, 1, '2018-05-09 20:51:12', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(787, 1, 1, '2018-05-09 21:24:41', 'Se actualizó el estado de la factura de venta número: 26 para el cliente pepito perez', '/invoice/26', 'InvoiceSaleOrder', 'Update'),
	(788, 1, 1, '2018-05-09 21:24:49', 'Se actualizó el estado de la factura de venta número: 22 para el cliente pepito perez', '/invoice/22', 'InvoiceSaleOrder', 'Update'),
	(789, 1, 1, '2018-05-09 21:24:55', 'Se actualizó el estado de la factura de venta número: 23 para el cliente pepito perez', '/invoice/23', 'InvoiceSaleOrder', 'Update'),
	(790, 1, 1, '2018-05-09 21:51:27', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(791, 1, 1, '2018-05-10 20:33:32', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(792, 1, 1, '2018-05-12 08:26:38', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(793, 1, 1, '2018-05-12 18:54:18', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(794, 1, 1, '2018-05-12 20:48:12', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(795, 1, 1, '2018-05-14 08:35:59', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(796, 1, 1, '2018-05-14 09:39:50', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(797, 1, 1, '2018-05-14 10:47:08', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(798, 1, 1, '2018-05-14 13:38:06', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(799, 1, 1, '2018-05-14 19:22:42', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(800, 1, 1, '2018-05-14 20:33:21', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(801, 1, 1, '2018-05-14 21:33:54', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(802, 1, 1, '2018-05-16 20:13:31', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(803, 1, 1, '2018-05-16 21:14:27', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(804, 1, 1, '2018-05-19 08:10:55', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(805, 1, 1, '2018-05-19 09:02:58', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(806, 1, 1, '2018-05-19 09:11:46', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(807, 1, 1, '2018-05-19 21:20:13', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(808, 1, 1, '2018-05-19 22:20:19', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(809, 1, 1, '2018-05-19 22:34:34', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(810, 1, 1, '2018-05-20 20:16:40', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(811, 1, 1, '2018-05-20 21:16:47', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(812, 1, 1, '2018-05-20 22:17:56', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(813, 1, 1, '2018-05-22 19:54:28', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(814, 1, 1, '2018-05-22 20:57:43', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(815, 1, 1, '2018-05-22 22:00:31', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(816, 1, 1, '2018-05-22 23:05:03', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(817, 1, 1, '2018-05-23 19:55:43', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(818, 1, 1, '2018-05-23 21:42:31', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(819, 1, 1, '2018-05-26 10:31:16', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(820, 1, 1, '2018-05-26 10:37:56', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(821, 1, 1, '2018-05-26 19:15:53', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(822, 1, 1, '2018-05-26 20:16:48', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(823, 1, 1, '2018-05-26 21:43:25', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(824, 1, 1, '2018-05-27 08:03:29', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(825, 1, 1, '2018-05-27 19:32:47', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(826, 1, 1, '2018-05-27 20:35:53', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(827, 1, 1, '2018-05-27 21:40:43', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(828, 1, 1, '2018-05-29 19:55:10', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(829, 1, 1, '2018-05-29 20:56:05', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(830, 1, 1, '2018-05-29 21:56:50', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(831, 1, 1, '2018-05-30 19:26:03', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(832, 1, 1, '2018-05-30 22:04:18', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(833, 1, 1, '2018-06-01 19:14:33', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(834, 1, 1, '2018-06-01 20:06:07', 'Se ha impreso el pdf de la factura de venta No: 26', '/invoice/26', 'InvoiceSaleOrder', 'Print'),
	(835, 1, 1, '2018-06-01 20:07:08', 'Se ha impreso el pdf de la factura de venta No: 26', '/invoice/26', 'InvoiceSaleOrder', 'Print'),
	(836, 1, 1, '2018-06-01 20:08:03', 'Se ha impreso el pdf de la factura de venta No: 26 ', '/invoice/26 ', 'InvoiceSaleOrder', 'Print'),
	(837, 1, 1, '2018-06-01 20:14:51', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(838, 1, 1, '2018-06-01 20:14:58', 'Se actualizó el estado de la factura de venta número: 26 para el cliente pepito perez', '/invoice/26', 'InvoiceSaleOrder', 'Update'),
	(839, 1, 1, '2018-06-01 20:15:04', 'Se actualizó el estado de la factura de venta número: 26 para el cliente pepito perez', '/invoice/26', 'InvoiceSaleOrder', 'Update'),
	(840, 1, 1, '2018-06-01 20:31:34', 'Se actualizó el estado de la factura de venta número: 26 para el cliente pepito perez', '/invoice/26', 'InvoiceSaleOrder', 'Update'),
	(841, 1, 1, '2018-06-01 20:34:17', 'Se actualizó el estado de la factura de venta número: 26 para el cliente pepito perez', '/invoice/26', 'InvoiceSaleOrder', 'Update'),
	(842, 1, 1, '2018-06-01 20:36:49', 'Se actualizó el estado de la factura de venta número: 26 para el cliente pepito perez', '/invoice/26', 'InvoiceSaleOrder', 'Update'),
	(843, 1, 1, '2018-06-01 20:38:47', 'Se actualizó el estado de la factura de venta número: 26 para el cliente pepito perez', '/invoice/26', 'InvoiceSaleOrder', 'Update'),
	(844, 1, 1, '2018-06-01 20:38:50', 'Se actualizó el estado de la factura de venta número: 26 para el cliente pepito perez', '/invoice/26', 'InvoiceSaleOrder', 'Update'),
	(845, 1, 1, '2018-06-01 20:38:57', 'Se actualizó el estado de la factura de venta número: 26 para el cliente pepito perez', '/invoice/26', 'InvoiceSaleOrder', 'Update'),
	(846, 1, 1, '2018-06-01 20:39:55', 'Se actualizó el estado de la factura de venta número: 26 para el cliente pepito perez', '/invoice/26', 'InvoiceSaleOrder', 'Update'),
	(847, 1, 1, '2018-06-01 20:41:36', 'Se actualizó el estado de la factura de venta número: 25 para el cliente pepito perez', '/invoice/25', 'InvoiceSaleOrder', 'Update'),
	(848, 1, 1, '2018-06-01 20:41:48', 'Se actualizó el estado de la factura de venta número: 26 para el cliente pepito perez', '/invoice/26', 'InvoiceSaleOrder', 'Update'),
	(849, 1, 1, '2018-06-01 20:44:25', 'Se actualizó el estado de la factura de venta número: 26 para el cliente pepito perez', '/invoice/26', 'InvoiceSaleOrder', 'Update'),
	(850, 1, 1, '2018-06-01 20:45:30', 'Se actualizó el estado de la factura de venta número: 26 para el cliente pepito perez', '/invoice/26', 'InvoiceSaleOrder', 'Update'),
	(851, 1, 1, '2018-06-01 20:54:21', 'Se actualizó el estado de la factura de venta número: 26 para el cliente pepito perez', '/invoice/26', 'InvoiceSaleOrder', 'Update'),
	(852, 1, 1, '2018-06-01 20:54:25', 'Se actualizó el estado de la factura de venta número: 25 para el cliente pepito perez', '/invoice/25', 'InvoiceSaleOrder', 'Update'),
	(853, 1, 1, '2018-06-01 20:55:11', 'Se actualizó el estado de la factura de venta número: 26 para el cliente pepito perez', '/invoice/26', 'InvoiceSaleOrder', 'Update'),
	(854, 1, 1, '2018-06-01 20:55:13', 'Se actualizó el estado de la factura de venta número: 25 para el cliente pepito perez', '/invoice/25', 'InvoiceSaleOrder', 'Update'),
	(855, 1, 1, '2018-06-01 20:55:20', 'Se actualizó el estado de la factura de venta número: 26 para el cliente pepito perez', '/invoice/26', 'InvoiceSaleOrder', 'Update'),
	(856, 1, 1, '2018-06-01 20:55:46', 'Se actualizó el estado de la factura de venta número: 26 para el cliente pepito perez', '/invoice/26', 'InvoiceSaleOrder', 'Update'),
	(857, 1, 1, '2018-06-01 20:55:49', 'Se actualizó el estado de la factura de venta número: 26 para el cliente pepito perez', '/invoice/26', 'InvoiceSaleOrder', 'Update'),
	(858, 1, 1, '2018-06-01 20:56:44', 'Se actualizó el estado de la factura de venta número: 26 para el cliente pepito perez', '/invoice/26', 'InvoiceSaleOrder', 'Update'),
	(859, 1, 1, '2018-06-01 20:56:51', 'Se actualizó el estado de la factura de venta número: 26 para el cliente pepito perez', '/invoice/26', 'InvoiceSaleOrder', 'Update'),
	(860, 1, 1, '2018-06-01 20:56:52', 'Se actualizó el estado de la factura de venta número: 25 para el cliente pepito perez', '/invoice/25', 'InvoiceSaleOrder', 'Update'),
	(861, 1, 1, '2018-06-01 20:56:53', 'Se actualizó el estado de la factura de venta número: 24 para el cliente pepito perez', '/invoice/24', 'InvoiceSaleOrder', 'Update'),
	(862, 1, 1, '2018-06-01 20:56:56', 'Se actualizó el estado de la factura de venta número: 19 para el cliente pepito perez', '/invoice/19', 'InvoiceSaleOrder', 'Update'),
	(863, 1, 1, '2018-06-01 20:56:56', 'Se actualizó el estado de la factura de venta número: 20 para el cliente pepito perez', '/invoice/20', 'InvoiceSaleOrder', 'Update'),
	(864, 1, 1, '2018-06-01 20:57:05', 'Se actualizó el estado de la factura de venta número: 1 para el cliente pepito perez', '/invoice/1', 'InvoiceSaleOrder', 'Update'),
	(865, 1, 1, '2018-06-01 20:57:06', 'Se actualizó el estado de la factura de venta número: 2 para el cliente pepito perez', '/invoice/2', 'InvoiceSaleOrder', 'Update'),
	(866, 1, 1, '2018-06-01 20:57:07', 'Se actualizó el estado de la factura de venta número: 3 para el cliente pepito perez', '/invoice/3', 'InvoiceSaleOrder', 'Update'),
	(867, 1, 1, '2018-06-01 20:57:08', 'Se actualizó el estado de la factura de venta número: 4 para el cliente pepito perez', '/invoice/4', 'InvoiceSaleOrder', 'Update'),
	(868, 1, 1, '2018-06-01 20:57:09', 'Se actualizó el estado de la factura de venta número: 5 para el cliente pepito perez', '/invoice/5', 'InvoiceSaleOrder', 'Update'),
	(869, 1, 1, '2018-06-01 20:57:09', 'Se actualizó el estado de la factura de venta número: 6 para el cliente pepito perez', '/invoice/6', 'InvoiceSaleOrder', 'Update'),
	(870, 1, 1, '2018-06-01 20:57:12', 'Se actualizó el estado de la factura de venta número: 13 para el cliente pepito perez', '/invoice/13', 'InvoiceSaleOrder', 'Update'),
	(871, 1, 1, '2018-06-01 20:58:29', 'Se actualizó el estado de la factura de venta número: 19 para el cliente pepito perez', '/invoice/19', 'InvoiceSaleOrder', 'Update'),
	(872, 1, 1, '2018-06-01 20:59:27', 'Se actualizó el estado de la factura de venta número: 25 para el cliente pepito perez', '/invoice/25', 'InvoiceSaleOrder', 'Update'),
	(873, 1, 1, '2018-06-01 20:59:30', 'Se actualizó el estado de la factura de venta número: 21 para el cliente pepito perez', '/invoice/21', 'InvoiceSaleOrder', 'Update'),
	(874, 1, 1, '2018-06-01 20:59:36', 'Se actualizó el estado de la factura de venta número: 23 para el cliente pepito perez', '/invoice/23', 'InvoiceSaleOrder', 'Update'),
	(875, 1, 1, '2018-06-01 20:59:39', 'Se actualizó el estado de la factura de venta número: 22 para el cliente pepito perez', '/invoice/22', 'InvoiceSaleOrder', 'Update'),
	(876, 1, 1, '2018-06-01 20:59:51', 'Se actualizó el estado de la factura de venta número: 22 para el cliente pepito perez', '/invoice/22', 'InvoiceSaleOrder', 'Update'),
	(877, 1, 1, '2018-06-01 20:59:54', 'Se actualizó el estado de la factura de venta número: 22 para el cliente pepito perez', '/invoice/22', 'InvoiceSaleOrder', 'Update'),
	(878, 1, 1, '2018-06-01 20:59:54', 'Se actualizó el estado de la factura de venta número: 22 para el cliente pepito perez', '/invoice/22', 'InvoiceSaleOrder', 'Update'),
	(879, 1, 1, '2018-06-01 20:59:56', 'Se actualizó el estado de la factura de venta número: 22 para el cliente pepito perez', '/invoice/22', 'InvoiceSaleOrder', 'Update'),
	(880, 1, 1, '2018-06-01 20:59:58', 'Se actualizó el estado de la factura de venta número: 22 para el cliente pepito perez', '/invoice/22', 'InvoiceSaleOrder', 'Update'),
	(881, 1, 1, '2018-06-01 20:59:59', 'Se actualizó el estado de la factura de venta número: 22 para el cliente pepito perez', '/invoice/22', 'InvoiceSaleOrder', 'Update'),
	(882, 1, 1, '2018-06-01 21:00:02', 'Se actualizó el estado de la factura de venta número: 22 para el cliente pepito perez', '/invoice/22', 'InvoiceSaleOrder', 'Update'),
	(883, 1, 1, '2018-06-01 21:04:45', 'Se actualizó el estado de la factura de venta número: 26 para el cliente pepito perez', '/invoice/26', 'InvoiceSaleOrder', 'Update'),
	(884, 1, 1, '2018-06-01 21:04:47', 'Se actualizó el estado de la factura de venta número: 26 para el cliente pepito perez', '/invoice/26', 'InvoiceSaleOrder', 'Update'),
	(885, 1, 1, '2018-06-01 21:04:47', 'Se actualizó el estado de la factura de venta número: 26 para el cliente pepito perez', '/invoice/26', 'InvoiceSaleOrder', 'Update'),
	(886, 1, 1, '2018-06-01 21:15:25', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(887, 1, 1, '2018-06-01 21:18:21', 'Se ha impreso el pdf de la factura de venta No: 19', '/invoice/19', 'InvoiceSaleOrder', 'Print'),
	(888, 1, 1, '2018-06-01 22:19:19', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(889, 1, 1, '2018-06-02 19:27:14', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(890, 1, 1, '2018-06-02 20:30:27', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(891, 1, 1, '2018-06-02 20:34:29', 'Se eliminó la factura de venta número: 21', NULL, 'InvoiceSaleOrder', 'Delete'),
	(892, 1, 1, '2018-06-02 20:34:44', 'Se eliminó la factura de venta número: 20', NULL, 'InvoiceSaleOrder', 'Delete'),
	(893, 1, 1, '2018-06-02 20:34:54', 'Se eliminó la factura de venta número: 15', NULL, 'InvoiceSaleOrder', 'Delete'),
	(894, 1, 1, '2018-06-02 21:08:58', 'Se creó la factura de venta número: 27 para el cliente pepito perez', '/invoice/27', 'InvoiceSaleOrder', 'Create'),
	(895, 1, 1, '2018-06-02 21:10:08', 'Se creó la factura de venta número: 28 para el cliente pepito perez', '/invoice/28', 'InvoiceSaleOrder', 'Create'),
	(896, 1, 1, '2018-06-02 21:10:36', 'Se creó la factura de venta número: 29 para el cliente proveedor', '/invoice/29', 'InvoiceSaleOrder', 'Create'),
	(897, 1, 1, '2018-06-02 21:13:06', 'Se creó la factura de venta número: 30 para el cliente pepito perez', '/invoice/30', 'InvoiceSaleOrder', 'Create'),
	(898, 1, 1, '2018-06-02 21:14:46', 'Se creó la factura de venta número: 31 para el cliente proveedor', '/invoice/31', 'InvoiceSaleOrder', 'Create'),
	(899, 1, 1, '2018-06-02 21:16:31', 'Se creó la factura de venta número: 32 para el cliente Fer2', '/invoice/32', 'InvoiceSaleOrder', 'Create'),
	(900, 1, 1, '2018-06-02 21:19:10', 'Se creó la factura de venta número: 33 para el cliente proveedor', '/invoice/33', 'InvoiceSaleOrder', 'Create'),
	(901, 1, 1, '2018-06-02 21:19:32', 'Se actualizó la factura de venta número: 33 para el cliente proveedor', '/invoice/33', 'InvoiceSaleOrder', 'Update'),
	(902, 1, 1, '2018-06-02 21:20:22', 'Se actualizó la factura de venta número: 33 para el cliente proveedor', '/invoice/33', 'InvoiceSaleOrder', 'Update'),
	(903, 1, 1, '2018-06-02 21:27:08', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(904, 1, 1, '2018-06-02 21:54:20', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(905, 1, 1, '2018-06-02 22:55:09', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(906, 1, 1, '2018-06-02 23:09:09', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(907, 1, 1, '2018-06-02 23:11:23', 'Se creó la factura de venta número: 34 para el cliente proveedor', '/invoice/34', 'InvoiceSaleOrder', 'Create'),
	(908, 1, 1, '2018-06-02 23:13:00', 'Se ha impreso el pdf de la factura de venta No: 34 ', '/invoice/34 ', 'InvoiceSaleOrder', 'Print'),
	(909, 1, 1, '2018-06-02 23:15:57', 'Se actualizó la factura de venta número: 34 para el cliente proveedor', '/invoice/34', 'InvoiceSaleOrder', 'Update'),
	(910, 1, 1, '2018-06-02 23:22:14', 'Se creó la factura de venta número: 35 para el cliente Fernando Ardila 2', '/invoice/35', 'InvoiceSaleOrder', 'Create'),
	(911, 1, 1, '2018-06-02 23:22:26', 'Se ha impreso el pdf de la factura de venta No: 35 ', '/invoice/35 ', 'InvoiceSaleOrder', 'Print'),
	(912, 1, 1, '2018-06-02 23:22:37', 'Se ha impreso el pdf de la factura de venta No: 35 ', '/invoice/35 ', 'InvoiceSaleOrder', 'Print'),
	(913, 1, 1, '2018-06-02 23:25:55', 'Se ha impreso el pdf de la factura de venta No: 35 ', '/invoice/35 ', 'InvoiceSaleOrder', 'Print'),
	(914, 1, 1, '2018-06-02 23:26:28', 'Se ha impreso el pdf de la factura de venta No: 35 ', '/invoice/35 ', 'InvoiceSaleOrder', 'Print'),
	(915, 1, 1, '2018-06-02 23:32:33', 'Se ha impreso el pdf de la factura de venta No: 35 ', '/invoice/35 ', 'InvoiceSaleOrder', 'Print'),
	(916, 1, 1, '2018-06-02 23:51:15', 'Se actualizó el estado de la factura de venta número: 34 para el cliente proveedor', '/invoice/34', 'InvoiceSaleOrder', 'Update'),
	(917, 1, 1, '2018-06-02 23:55:56', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(918, 1, 1, '2018-06-03 09:37:11', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(919, 1, 1, '2018-06-03 09:43:09', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(920, 1, 1, '2018-06-03 09:45:44', 'Se eliminó la factura de venta número: 35', NULL, 'InvoiceSaleOrder', 'Delete'),
	(921, 1, 1, '2018-06-03 11:07:54', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(922, 1, 1, '2018-06-03 19:58:40', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(923, 1, 1, '2018-06-03 20:01:25', 'Se creó la factura de venta número: 36 para el cliente proveedor', '/invoice/36', 'InvoiceSaleOrder', 'Create'),
	(924, 1, 1, '2018-06-03 21:01:22', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(925, 1, 1, '2018-06-03 22:01:36', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(926, 1, 1, '2018-06-03 22:02:32', 'Se creó la factura de venta número: 37 para el cliente pepito perez', '/invoice/37', 'InvoiceSaleOrder', 'Create'),
	(927, 1, 1, '2018-06-03 22:02:54', 'Se actualizó la factura de venta número: 37 para el cliente pepito perez', '/invoice/37', 'InvoiceSaleOrder', 'Update'),
	(928, 1, 1, '2018-06-03 22:54:10', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(929, 1, 1, '2018-06-03 23:03:21', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(930, 1, 1, '2018-06-04 11:09:59', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(931, 1, 1, '2018-06-04 12:09:14', 'Se ha impreso el pdf de la factura de venta No: 37 ', '/invoice/37 ', 'InvoiceSaleOrder', 'Print'),
	(932, 1, 1, '2018-06-04 12:09:58', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(933, 1, 1, '2018-06-04 12:10:10', 'Se ha impreso el pdf de la factura de venta No: 37 ', '/invoice/37 ', 'InvoiceSaleOrder', 'Print'),
	(934, 1, 1, '2018-06-04 13:43:46', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(935, 1, 1, '2018-06-04 13:43:59', 'Se actualizó el estado de la factura de venta número: 36 para el cliente proveedor', '/invoice/36', 'InvoiceSaleOrder', 'Update'),
	(936, 1, 1, '2018-06-04 13:44:03', 'Se actualizó el estado de la factura de venta número: 36 para el cliente proveedor', '/invoice/36', 'InvoiceSaleOrder', 'Update'),
	(937, 1, 1, '2018-06-04 13:44:41', 'Se actualizó el estado de la factura de venta número: 36 para el cliente proveedor', '/invoice/36', 'InvoiceSaleOrder', 'Update'),
	(938, 1, 1, '2018-06-04 13:44:49', 'Se actualizó el estado de la factura de venta número: 36 para el cliente proveedor', '/invoice/36', 'InvoiceSaleOrder', 'Update'),
	(939, 1, 1, '2018-06-04 13:44:50', 'Se actualizó el estado de la factura de venta número: 36 para el cliente proveedor', '/invoice/36', 'InvoiceSaleOrder', 'Update'),
	(940, 1, 1, '2018-06-04 13:44:53', 'Se actualizó el estado de la factura de venta número: 36 para el cliente proveedor', '/invoice/36', 'InvoiceSaleOrder', 'Update'),
	(941, 1, 1, '2018-06-04 13:44:59', 'Se actualizó el estado de la factura de venta número: 36 para el cliente proveedor', '/invoice/36', 'InvoiceSaleOrder', 'Update'),
	(942, 1, 1, '2018-06-04 14:44:03', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(943, 1, 1, '2018-06-04 17:28:00', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(944, 1, 1, '2018-06-04 18:29:47', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(945, 1, 1, '2018-06-04 19:11:12', 'Se creó la factura de venta número: 38 para el cliente pepito perez', '/invoice/38', 'InvoiceSaleOrder', 'Create'),
	(946, 1, 1, '2018-06-04 19:31:36', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(947, 1, 1, '2018-06-08 20:29:52', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(948, 1, 1, '2018-06-12 20:50:10', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(949, 1, 1, '2018-06-16 13:53:19', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(950, 1, 1, '2018-06-16 21:40:28', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(951, 1, 1, '2018-06-16 22:41:08', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(952, 1, 1, '2018-06-17 17:11:02', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(953, 1, 1, '2018-06-17 18:26:59', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(954, 1, 1, '2018-06-17 19:28:23', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(955, 1, 1, '2018-06-17 19:39:30', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(956, 1, 1, '2018-06-17 20:49:42', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(957, 1, 1, '2018-07-03 20:06:08', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(958, 1, 1, '2018-07-10 19:15:24', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(959, 1, 1, '2018-07-10 20:20:26', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(960, 1, 1, '2018-07-10 21:21:43', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(961, 1, 1, '2018-07-12 20:00:24', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(962, 1, 1, '2018-07-16 20:00:33', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(963, 1, 1, '2018-07-16 21:00:59', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(964, 1, 1, '2018-07-20 12:36:16', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(965, 1, 1, '2018-07-22 10:44:52', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(966, 1, 1, '2018-07-24 20:13:24', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(967, 1, 1, '2018-07-24 21:18:22', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(968, 1, 1, '2018-07-25 21:08:54', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(969, 1, 1, '2018-07-25 21:09:46', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(970, 1, 1, '2018-07-25 21:09:48', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(971, 1, 1, '2018-07-25 21:11:05', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(972, 1, 1, '2018-07-25 21:11:26', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(973, 1, 1, '2018-07-25 21:11:31', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(974, 1, 1, '2018-07-25 21:13:00', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(975, 1, 1, '2018-07-25 21:13:04', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(976, 1, 1, '2018-07-25 21:13:06', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(977, 1, 1, '2018-07-25 21:26:14', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(978, 1, 1, '2018-07-25 21:27:24', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(979, 1, 1, '2018-07-25 21:27:28', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(980, 1, 1, '2018-07-25 21:27:30', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(981, 1, 1, '2018-07-25 21:28:43', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(982, 1, 1, '2018-07-25 21:28:44', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(983, 1, 1, '2018-07-25 21:29:26', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(984, 1, 1, '2018-07-25 21:29:31', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(985, 1, 1, '2018-07-25 21:29:32', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(986, 1, 1, '2018-07-25 21:29:35', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(987, 1, 1, '2018-07-25 21:30:09', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(988, 1, 1, '2018-07-25 21:30:11', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(989, 1, 1, '2018-07-25 21:31:08', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(990, 1, 1, '2018-07-25 21:31:10', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(991, 1, 1, '2018-07-25 21:31:42', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(992, 1, 1, '2018-07-25 21:32:07', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(993, 1, 1, '2018-07-25 21:32:11', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(994, 1, 1, '2018-07-25 21:32:18', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(995, 1, 1, '2018-07-25 21:33:06', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(996, 1, 1, '2018-07-25 21:35:33', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(997, 1, 1, '2018-07-25 21:35:37', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(998, 1, 1, '2018-07-25 21:35:39', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(999, 1, 1, '2018-07-25 21:37:05', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1000, 1, 1, '2018-07-25 21:37:08', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1001, 1, 1, '2018-07-25 21:37:13', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1002, 1, 1, '2018-07-25 22:04:39', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1003, 1, 1, '2018-07-25 22:06:28', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1004, 1, 1, '2018-07-25 22:08:36', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1005, 1, 1, '2018-07-25 22:08:39', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1006, 1, 1, '2018-07-25 22:09:58', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1007, 1, 1, '2018-07-25 22:10:01', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1008, 1, 1, '2018-07-25 22:11:36', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1009, 1, 1, '2018-07-25 22:11:42', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1010, 1, 1, '2018-07-25 22:13:15', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1011, 1, 1, '2018-07-25 22:13:18', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1012, 1, 1, '2018-07-25 22:14:30', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1013, 1, 1, '2018-07-25 22:14:33', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1014, 1, 1, '2018-07-25 22:15:49', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1015, 1, 1, '2018-07-25 22:18:00', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1016, 1, 1, '2018-07-25 22:18:03', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1017, 1, 1, '2018-07-25 22:19:08', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1018, 1, 1, '2018-07-25 22:23:30', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1019, 1, 1, '2018-07-25 22:23:35', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1020, 1, 1, '2018-07-25 22:24:10', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1021, 1, 1, '2018-07-25 22:26:55', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1022, 1, 1, '2018-07-25 22:31:18', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1023, 1, 1, '2018-07-25 22:31:21', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1024, 1, 1, '2018-07-25 22:31:24', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1025, 1, 1, '2018-07-25 22:31:26', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1026, 1, 1, '2018-07-25 22:31:28', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1027, 1, 1, '2018-07-25 22:31:30', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1028, 1, 1, '2018-07-25 22:31:32', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1029, 1, 1, '2018-07-25 22:31:34', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1030, 1, 1, '2018-07-25 22:31:36', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1031, 1, 1, '2018-07-25 22:31:43', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1032, 1, 1, '2018-07-25 22:34:50', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1033, 1, 1, '2018-07-25 22:34:52', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1034, 1, 1, '2018-07-25 22:34:54', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1035, 1, 1, '2018-07-25 22:35:28', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1036, 1, 1, '2018-07-25 22:35:29', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1037, 1, 1, '2018-07-25 22:35:42', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1038, 1, 1, '2018-07-25 22:39:23', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1039, 1, 1, '2018-07-25 22:39:36', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1040, 1, 1, '2018-07-25 22:40:24', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1041, 1, 1, '2018-07-25 22:41:32', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1042, 1, 1, '2018-07-25 22:41:35', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1043, 1, 1, '2018-07-25 22:41:36', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1044, 1, 1, '2018-07-25 22:41:37', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1045, 1, 1, '2018-07-25 22:41:39', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1046, 1, 1, '2018-07-25 22:51:54', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1047, 1, 1, '2018-07-25 22:51:57', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1048, 1, 1, '2018-07-25 22:52:01', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1049, 1, 1, '2018-07-25 22:52:44', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1050, 1, 1, '2018-07-25 22:52:47', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1051, 1, 1, '2018-07-25 22:52:48', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1052, 1, 1, '2018-07-25 22:52:54', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1053, 1, 1, '2018-07-25 22:53:34', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1054, 1, 1, '2018-07-25 22:53:37', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1055, 1, 1, '2018-07-25 22:53:38', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1056, 1, 1, '2018-07-25 22:54:27', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1057, 1, 1, '2018-07-25 22:54:29', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1058, 1, 1, '2018-07-25 22:54:31', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1059, 1, 1, '2018-07-25 22:55:26', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1060, 1, 1, '2018-07-25 22:55:28', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1061, 1, 1, '2018-07-25 22:55:30', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1062, 1, 1, '2018-07-25 22:55:31', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1063, 1, 1, '2018-07-25 22:55:33', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1064, 1, 1, '2018-07-25 22:55:34', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1065, 1, 1, '2018-07-25 22:55:36', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1066, 1, 1, '2018-07-25 22:55:38', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1067, 1, 1, '2018-07-25 22:55:40', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1068, 1, 1, '2018-07-25 22:55:42', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1069, 1, 1, '2018-07-25 22:55:43', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1070, 1, 1, '2018-07-25 22:55:45', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1071, 1, 1, '2018-07-25 22:56:34', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1072, 1, 1, '2018-07-25 22:56:35', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1073, 1, 1, '2018-07-25 22:58:25', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1074, 1, 1, '2018-07-25 22:58:27', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1075, 1, 1, '2018-07-25 22:58:31', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1076, 1, 1, '2018-07-25 22:58:33', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1077, 1, 1, '2018-07-25 22:58:36', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1078, 1, 1, '2018-07-25 23:01:17', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1079, 1, 1, '2018-07-25 23:01:19', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1080, 1, 1, '2018-07-25 23:01:21', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1081, 1, 1, '2018-07-25 23:01:36', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1082, 1, 1, '2018-07-25 23:01:39', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1083, 1, 1, '2018-07-26 21:52:33', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1084, 1, 1, '2018-07-26 21:52:34', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1085, 1, 1, '2018-07-26 22:08:33', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1086, 1, 1, '2018-07-26 22:08:36', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1087, 1, 1, '2018-07-26 22:14:21', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1088, 1, 1, '2018-07-26 22:14:50', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1089, 1, 1, '2018-07-26 22:14:52', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1090, 1, 1, '2018-07-26 22:37:45', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1091, 1, 1, '2018-07-26 22:37:50', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1092, 1, 1, '2018-07-26 22:37:52', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1093, 1, 1, '2018-07-26 22:37:54', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1094, 1, 1, '2018-07-26 22:37:56', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1095, 1, 1, '2018-07-26 22:37:57', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1096, 1, 1, '2018-08-04 20:28:01', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1097, 1, 1, '2018-08-05 10:25:08', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1098, 1, 1, '2018-08-05 11:55:20', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1099, 1, 1, '2018-08-05 13:41:03', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1100, 1, 1, '2018-08-05 15:50:04', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1101, 1, 1, '2018-08-07 18:17:30', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1102, 1, 1, '2018-08-08 20:40:35', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1103, 1, 1, '2018-08-08 21:43:02', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1104, 1, 1, '2018-08-08 22:14:08', 'Se ha impreso el pdf de la factura de venta No: 38 ', '/invoice/38 ', 'InvoiceSaleOrder', 'Print'),
	(1105, 1, 1, '2018-08-11 21:34:13', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1106, 1, 1, '2018-08-11 22:35:10', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1107, 1, 1, '2018-08-15 20:51:37', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1108, 1, 1, '2018-08-15 21:51:24', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1109, 1, 1, '2018-08-15 22:28:39', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1110, 1, 1, '2018-08-15 22:31:00', 'Se ha impreso el pdf de la factura de venta No: 32 ', '/invoice/32 ', 'InvoiceSaleOrder', 'Print'),
	(1111, 1, 1, '2018-08-15 22:31:49', 'Se actualizó la factura de venta número: 32 para el cliente Fer2', '/invoice/32', 'InvoiceSaleOrder', 'Update'),
	(1112, 1, 1, '2018-08-17 21:14:04', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1113, 1, 1, '2018-08-17 22:18:41', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1114, 1, 1, '2018-08-21 22:18:34', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1115, 1, 1, '2018-08-25 11:56:11', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1116, 1, 1, '2018-08-25 12:01:28', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1117, 1, 1, '2018-08-26 20:15:21', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1118, 1, 1, '2018-08-26 21:18:26', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1119, 1, 1, '2018-09-01 14:46:33', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1120, 1, 1, '2018-09-01 15:56:04', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1121, 1, 1, '2018-09-06 21:26:14', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1122, 1, 1, '2018-09-08 08:53:39', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1123, 1, 1, '2018-09-08 11:30:24', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1124, 1, 1, '2018-09-09 19:17:34', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1125, 1, 1, '2018-09-09 20:18:23', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1126, 1, 1, '2018-09-09 20:18:34', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1127, 1, 1, '2018-09-09 21:36:14', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1128, 1, 1, '2018-09-09 22:02:36', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1129, 1, 1, '2018-09-09 22:03:24', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1130, 1, 1, '2018-09-10 20:57:52', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1131, 1, 1, '2018-09-10 21:59:47', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1132, 1, 1, '2018-09-17 19:59:35', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1133, 1, 1, '2018-09-17 20:15:39', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1134, 1, 1, '2018-09-17 21:16:48', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1135, 1, 1, '2018-09-23 11:36:01', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1136, 1, 1, '2018-09-23 12:42:49', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1137, 1, 1, '2018-09-28 19:27:01', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1138, 1, 1, '2018-10-04 21:12:04', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1139, 1, 1, '2018-10-07 19:10:54', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1140, 1, 1, '2018-10-07 20:16:32', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1141, 1, 1, '2018-10-13 19:45:22', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1142, 1, 1, '2018-10-15 19:00:22', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1143, 1, 1, '2018-10-18 19:57:38', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1144, 1, 1, '2018-10-18 20:57:54', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1145, 1, 1, '2018-10-18 22:04:00', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1146, 1, 1, '2018-10-20 13:44:05', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1147, 1, 1, '2018-10-20 19:45:15', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1148, 1, 1, '2018-10-20 20:48:41', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1149, 1, 1, '2018-10-20 22:19:25', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1150, 1, 1, '2018-10-20 23:19:41', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1151, 1, 1, '2018-10-23 21:05:44', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1152, 1, 1, '2018-10-23 21:43:14', 'Se eliminó el pago número: 9', NULL, 'Payment', 'Delete'),
	(1153, 1, 1, '2018-10-23 21:43:35', 'Se eliminó el pago número: 11', NULL, 'Payment', 'Delete'),
	(1154, 1, 1, '2018-10-23 21:44:09', 'Se actualizó el estado del pago número: 2 para el cliente pepito perez', '/payment-in/3', 'Payment', 'Update'),
	(1155, 1, 1, '2018-10-23 21:44:22', 'Se actualizó el estado del pago número: 3 para el cliente pepito perez', '/payment-in/4', 'Payment', 'Update'),
	(1156, 1, 1, '2018-10-23 21:44:35', 'Se actualizó el estado del pago número: 3 para el cliente pepito perez', '/payment-in/4', 'Payment', 'Update'),
	(1157, 1, 1, '2018-10-23 21:44:37', 'Se actualizó el estado del pago número: 2 para el cliente pepito perez', '/payment-in/3', 'Payment', 'Update'),
	(1158, 1, 1, '2018-10-23 21:50:30', 'Se actualizó el estado del pago número: 2 para el cliente pepito perez', '/payment-in/3', 'Payment', 'Update'),
	(1159, 1, 1, '2018-10-23 21:50:38', 'Se actualizó el estado del pago número: 2 para el cliente pepito perez', '/payment-in/3', 'Payment', 'Update'),
	(1160, 1, 1, '2018-10-23 21:50:40', 'Se actualizó el estado del pago número: 2 para el cliente pepito perez', '/payment-in/3', 'Payment', 'Update'),
	(1161, 1, 1, '2018-10-23 21:50:41', 'Se actualizó el estado del pago número: 2 para el cliente pepito perez', '/payment-in/3', 'Payment', 'Update'),
	(1162, 1, 1, '2018-10-23 21:50:43', 'Se actualizó el estado del pago número: 2 para el cliente pepito perez', '/payment-in/3', 'Payment', 'Update'),
	(1163, 1, 1, '2018-10-23 21:53:29', 'Se actualizó el estado de la factura de venta número: 38 para el cliente pepito perez', '/invoice/38', 'InvoiceSaleOrder', 'Update'),
	(1164, 1, 1, '2018-10-23 21:53:31', 'Se actualizó el estado de la factura de venta número: 38 para el cliente pepito perez', '/invoice/38', 'InvoiceSaleOrder', 'Update'),
	(1165, 1, 1, '2018-10-23 21:53:33', 'Se actualizó el estado de la factura de venta número: 38 para el cliente pepito perez', '/invoice/38', 'InvoiceSaleOrder', 'Update'),
	(1166, 1, 1, '2018-10-23 21:53:37', 'Se actualizó el estado de la factura de venta número: 38 para el cliente pepito perez', '/invoice/38', 'InvoiceSaleOrder', 'Update'),
	(1167, 1, 1, '2018-10-27 21:46:52', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1168, 1, 1, '2018-11-02 21:28:02', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1169, 1, 1, '2018-11-02 21:29:13', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1170, 1, 1, '2018-11-18 18:11:08', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1171, 1, 1, '2018-11-18 19:41:23', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1172, 1, 1, '2018-11-18 20:56:20', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1173, 1, 1, '2018-11-18 22:00:09', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1174, 1, 1, '2018-11-18 23:00:50', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1175, 1, 1, '2018-11-19 20:10:48', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1176, 1, 1, '2018-11-20 10:13:05', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1177, 1, 1, '2018-11-20 11:13:41', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1178, 1, 1, '2018-11-22 10:15:58', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1179, 1, 1, '2018-11-22 12:59:28', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1180, 1, 1, '2018-11-22 13:04:02', 'Se ha impreso el pdf para el comprobante de ingreso No: 11 ', '/payment-in/11 ', 'Payment-out', 'Print'),
	(1181, 1, 1, '2018-11-22 13:05:48', 'Se ha impreso el pdf para el comprobante de ingreso No: 11 ', '/payment-in/11 ', 'Payment-out', 'Print'),
	(1182, 1, 1, '2018-11-22 13:23:46', 'Se ha impreso el pdf para el comprobante de ingreso No: 11', '/payment-in/11', 'Payment-out', 'Print'),
	(1183, 1, 1, '2018-11-22 13:26:44', 'Se ha impreso el pdf para el comprobante de ingreso No: 11 ', '/payment-in/11 ', 'Payment-out', 'Print'),
	(1184, 1, 1, '2018-11-22 14:23:14', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1185, 1, 1, '2018-11-22 15:27:02', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1186, 1, 1, '2018-11-22 16:29:08', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1187, 1, 1, '2018-11-22 18:42:28', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1188, 1, 1, '2018-11-22 20:53:38', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1189, 1, 1, '2018-11-27 20:04:53', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1190, 1, 1, '2018-11-28 10:05:25', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1191, 1, 1, '2019-03-23 14:45:14', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1192, 1, 1, '2019-05-05 13:13:47', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1193, 1, 1, '2019-05-05 14:43:12', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1194, 1, 1, '2019-05-05 19:28:48', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1195, 1, 1, '2019-05-05 21:46:21', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1196, 1, 1, '2019-05-11 23:58:51', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1197, 1, 1, '2019-05-12 09:57:14', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1198, 1, 1, '2019-05-12 11:45:32', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1199, 1, 1, '2019-05-12 12:38:15', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1200, 1, 1, '2019-05-12 15:25:18', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1201, 1, 1, '2019-05-12 16:25:36', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1202, 1, 1, '2019-05-12 17:25:56', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1203, 1, 1, '2019-05-12 18:27:27', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1204, 1, 1, '2019-05-12 19:36:49', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1205, 1, 1, '2019-05-12 20:41:45', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1206, 1, 1, '2019-05-12 21:44:14', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1207, 1, 1, '2019-05-19 14:42:15', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1208, 1, 1, '2019-05-19 15:46:26', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1209, 1, 1, '2019-05-19 19:01:47', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1210, 1, 1, '2019-05-19 19:10:31', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1211, 1, 1, '2019-05-19 20:02:24', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(1212, 1, 1, '2019-05-20 19:49:04', 'Fernando2 ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn');
/*!40000 ALTER TABLE `activity_log` ENABLE KEYS */;

-- Volcando estructura para tabla krece.bank_account
CREATE TABLE IF NOT EXISTS `bank_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `public_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `bank_account_type_id` int(11) NOT NULL,
  `bank_account_name` varchar(100) NOT NULL,
  `bank_account_number` varchar(100) DEFAULT NULL,
  `initial_balance` float NOT NULL,
  `description` text DEFAULT NULL,
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `isDefault` bit(1) NOT NULL DEFAULT b'0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_BA_public_id_account_id` (`public_id`,`account_id`),
  KEY `FK_banks_accounttype` (`bank_account_type_id`),
  KEY `FK_banks_company` (`user_id`),
  KEY `FK_banks_account` (`account_id`),
  CONSTRAINT `FK_banks_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_banks_accounttype` FOREIGN KEY (`bank_account_type_id`) REFERENCES `bank_account_type` (`id`),
  CONSTRAINT `FK_banks_company` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 COMMENT='bank information related with accounts';

-- Volcando datos para la tabla krece.bank_account: ~10 rows (aproximadamente)
DELETE FROM `bank_account`;
/*!40000 ALTER TABLE `bank_account` DISABLE KEYS */;
INSERT INTO `bank_account` (`id`, `user_id`, `public_id`, `account_id`, `bank_account_type_id`, `bank_account_name`, `bank_account_number`, `initial_balance`, `description`, `isDeleted`, `isDefault`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, 1, 'Banco 1', '123491721', 5000, 'esta es una descripción de prueba', b'0', b'1', NULL, '2018-06-17 18:38:37', NULL),
	(2, 1, 2, 1, 2, 'Tarjeta de crédito 1', '12345678', 1234, NULL, b'0', b'0', NULL, '2018-06-04 18:44:26', NULL),
	(3, 1, 3, 1, 3, 'Caja general', NULL, 1200, NULL, b'0', b'0', NULL, '2018-06-04 18:55:53', NULL),
	(4, 2, 1, 2, 1, 'Banco 1', NULL, 0, NULL, b'0', b'1', NULL, '2017-08-06 23:23:32', NULL),
	(5, 2, 2, 2, 2, 'Tarjeta de crédito 1', NULL, 0, NULL, b'0', b'0', NULL, '2017-08-06 23:23:32', NULL),
	(6, 2, 3, 2, 3, 'Caja general', NULL, 0, NULL, b'0', b'0', NULL, '2017-08-06 23:23:32', NULL),
	(7, 1, 4, 1, 1, 'test', '123456', 20000, NULL, b'1', b'0', '2017-10-16 12:25:54', '2017-10-16 12:26:03', '2017-10-16 12:26:03'),
	(8, 1, 5, 1, 1, 'preubass', 'as121221a11', 200000, 'descripcion adicionada', b'1', b'0', '2017-10-16 12:28:05', '2017-10-16 13:04:19', '2017-10-16 13:04:19'),
	(9, 1, 6, 1, 2, 'test2', '12345', 3000, NULL, b'1', b'0', '2017-10-16 13:05:46', '2017-10-29 09:30:42', '2017-10-29 09:30:42'),
	(10, 1, 7, 1, 1, 'Ban republica prueba 1', '123456', 1500, NULL, b'1', b'0', '2018-06-04 18:57:36', '2018-06-04 19:08:21', '2018-06-04 19:08:21'),
	(11, 1, 8, 1, 1, 'banco prueba', '1234567', 35453400, NULL, b'1', b'0', '2018-06-04 19:08:47', '2018-06-04 19:31:51', '2018-06-04 19:31:51'),
	(12, 1, 9, 1, 1, 'prueba banco', '1234567', 23000, NULL, b'0', b'0', '2018-06-17 19:42:58', '2018-06-17 19:42:58', NULL);
/*!40000 ALTER TABLE `bank_account` ENABLE KEYS */;

-- Volcando estructura para tabla krece.bank_account_type
CREATE TABLE IF NOT EXISTS `bank_account_type` (
  `id` int(11) NOT NULL,
  `description` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='account type default for the bank section';

-- Volcando datos para la tabla krece.bank_account_type: ~3 rows (aproximadamente)
DELETE FROM `bank_account_type`;
/*!40000 ALTER TABLE `bank_account_type` DISABLE KEYS */;
INSERT INTO `bank_account_type` (`id`, `description`) VALUES
	(1, 'Banco'),
	(2, 'Tarjeta de Crédito'),
	(3, 'Efectivo');
/*!40000 ALTER TABLE `bank_account_type` ENABLE KEYS */;

-- Volcando estructura para tabla krece.bill
CREATE TABLE IF NOT EXISTS `bill` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL COMMENT 'related with client that will receive the invoice',
  `user_id` int(11) NOT NULL,
  `public_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `resolution_id` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `due_date` date NOT NULL,
  `status_id` int(11) NOT NULL COMMENT 'Status of the invoice that could be open, closed, revoked',
  `observations` text DEFAULT NULL COMMENT 'for customer tracking , just internal',
  `currency_code` varchar(3) NOT NULL,
  `total` float DEFAULT NULL,
  `sub_total` float DEFAULT NULL,
  `total_discounts` float DEFAULT NULL,
  `total_taxes` float DEFAULT NULL,
  `currency_code_multicurrency` varchar(3) DEFAULT NULL,
  `exchange_rate` float DEFAULT NULL,
  `isRecurring` bit(1) NOT NULL DEFAULT b'0',
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_supp_company_id_document_number` (`account_id`,`public_id`),
  KEY `FK_invoice_supplier_currency` (`currency_code`),
  KEY `FK_invoice_supplier_customerID` (`customer_id`),
  KEY `FK_invoice_supplier_status` (`status_id`),
  KEY `FK_invoice_supplier_user` (`user_id`),
  CONSTRAINT `FK_invoice_supplier_company` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_invoice_supplier_currency` FOREIGN KEY (`currency_code`) REFERENCES `currency_code` (`code`),
  CONSTRAINT `FK_invoice_supplier_customerID` FOREIGN KEY (`customer_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `FK_invoice_supplier_status` FOREIGN KEY (`status_id`) REFERENCES `bill_status` (`id`),
  CONSTRAINT `FK_invoice_supplier_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COMMENT='Header of supplier invoices';

-- Volcando datos para la tabla krece.bill: ~6 rows (aproximadamente)
DELETE FROM `bill`;
/*!40000 ALTER TABLE `bill` DISABLE KEYS */;
INSERT INTO `bill` (`id`, `account_id`, `user_id`, `public_id`, `customer_id`, `resolution_id`, `date`, `due_date`, `status_id`, `observations`, `currency_code`, `total`, `sub_total`, `total_discounts`, `total_taxes`, `currency_code_multicurrency`, `exchange_rate`, `isRecurring`, `isDeleted`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, 1, 1, '2017-04-13', '2017-04-13', 2, NULL, 'COP', 200, 200, 0, 0, NULL, NULL, b'0', b'0', '2017-04-13 21:21:15', '2017-09-14 20:28:28', NULL),
	(2, 1, 1, 2, 1, 2, '2017-09-08', '2017-10-08', 1, 'prueba fernando', 'COP', 31620, 30200, 2000, 3420, NULL, NULL, b'0', b'0', '2017-09-08 12:34:34', '2017-09-08 12:38:37', NULL),
	(3, 1, 1, 3, 1, 3, '2017-09-08', '2017-10-08', 1, 'prueba fernando', 'COP', 31620, 30200, 2000, 3420, NULL, NULL, b'0', b'0', '2017-09-08 12:40:31', '2017-09-08 12:40:31', NULL),
	(4, 1, 1, 4, 1, 4, '2017-09-08', '2017-10-08', 1, 'clon de factura 3', 'COP', 31620, 30200, 2000, 3420, NULL, NULL, b'0', b'0', '2017-09-08 12:46:03', '2017-09-08 12:46:03', NULL),
	(5, 1, 1, 5, 1, 5, '2017-09-08', '2017-10-08', 1, 'clon de factura 4', 'COP', 423825, 539557, 119152, 3420, NULL, NULL, b'0', b'0', '2017-09-08 12:46:37', '2017-09-08 12:46:37', NULL),
	(6, 1, 1, 6, 1, 6, '2017-09-08', '2017-10-08', 1, 'observa', 'COP', 20003, 20003, 0, 0, NULL, NULL, b'0', b'0', '2017-09-08 14:37:48', '2017-09-08 14:37:48', NULL);
/*!40000 ALTER TABLE `bill` ENABLE KEYS */;

-- Volcando estructura para tabla krece.bill_detail
CREATE TABLE IF NOT EXISTS `bill_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'header invoice number',
  `bill_id` bigint(20) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL,
  `unit_price` float NOT NULL,
  `discount` float DEFAULT NULL,
  `tax_amount` float DEFAULT NULL,
  `tax_id` float DEFAULT NULL,
  `category_id` int(10) DEFAULT NULL,
  `product_id` int(10) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `total_tax` float NOT NULL,
  `total` float NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_supplier_order_company` (`user_id`),
  KEY `FK_supplier_order_category` (`category_id`),
  KEY `FK_supplier_order_invoice_supplier_order` (`bill_id`),
  KEY `FK_soi_product` (`product_id`),
  CONSTRAINT `FK_soi_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `FK_soi_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FK_supplier_order_company` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_supplier_order_invoice_supplier_order` FOREIGN KEY (`bill_id`) REFERENCES `bill` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1 COMMENT='detail of the invoice generated';

-- Volcando datos para la tabla krece.bill_detail: ~15 rows (aproximadamente)
DELETE FROM `bill_detail`;
/*!40000 ALTER TABLE `bill_detail` DISABLE KEYS */;
INSERT INTO `bill_detail` (`id`, `bill_id`, `user_id`, `unit_price`, `discount`, `tax_amount`, `tax_id`, `category_id`, `product_id`, `name`, `description`, `quantity`, `total_tax`, `total`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 200, 0, 0, NULL, 38, NULL, 'Publicidad', NULL, 1, 0, 200, '2017-04-13 21:21:15', '2017-04-13 21:21:15', NULL),
	(4, 2, 1, 20000, 10, 19, 2, 11, NULL, NULL, NULL, 1, 3420, 18000, '2017-09-08 12:38:38', '2017-09-08 12:38:38', NULL),
	(5, 2, 1, 34, 0, 0, NULL, 14, NULL, NULL, 'ad description', 300, 0, 10200, '2017-09-08 12:38:38', '2017-09-08 12:38:38', NULL),
	(6, 3, 1, 20000, 10, 19, 2, 11, NULL, NULL, NULL, 1, 3420, 18000, '2017-09-08 12:40:31', '2017-09-08 12:40:31', NULL),
	(7, 3, 1, 34, 0, 0, NULL, 14, NULL, NULL, 'ad description', 300, 0, 10200, '2017-09-08 12:40:31', '2017-09-08 12:40:31', NULL),
	(8, 3, 1, 0, 0, 0, NULL, 13, NULL, NULL, NULL, 1, 0, 0, '2017-09-08 12:40:31', '2017-09-08 12:40:31', NULL),
	(9, 4, 1, 20000, 10, 19, 2, 11, NULL, NULL, NULL, 1, 3420, 18000, '2017-09-08 12:46:03', '2017-09-08 12:46:03', NULL),
	(10, 4, 1, 34, 0, 0, NULL, 14, NULL, NULL, 'ad description', 300, 0, 10200, '2017-09-08 12:46:03', '2017-09-08 12:46:03', NULL),
	(11, 4, 1, 0, 0, 0, NULL, 13, NULL, NULL, NULL, 1, 0, 0, '2017-09-08 12:46:03', '2017-09-08 12:46:03', NULL),
	(12, 5, 1, 20000, 10, 19, 2, 11, NULL, NULL, NULL, 1, 3420, 18000, '2017-09-08 12:46:37', '2017-09-08 12:46:37', NULL),
	(13, 5, 1, 34, 0, 0, NULL, 14, NULL, NULL, 'ad description', 300, 0, 10200, '2017-09-08 12:46:37', '2017-09-08 12:46:37', NULL),
	(14, 5, 1, 0, 0, 0, NULL, 13, NULL, NULL, NULL, 1, 0, 0, '2017-09-08 12:46:37', '2017-09-08 12:46:37', NULL),
	(15, 5, 1, 4673, 23, 0, NULL, 14, NULL, NULL, NULL, 109, 0, 392205, '2017-09-08 12:46:38', '2017-09-08 12:46:38', NULL),
	(16, 6, 1, 0, 0, 0, NULL, 9, NULL, 'Alquiler de equipos y licencias', NULL, 1, 0, 0, '2017-09-08 14:37:48', '2017-09-08 14:37:48', NULL),
	(17, 6, 1, 20003, 0, 0, NULL, 10, NULL, 'Comisiones y honorarios', NULL, 1, 0, 20003, '2017-09-08 14:37:48', '2017-09-08 14:37:48', NULL);
/*!40000 ALTER TABLE `bill_detail` ENABLE KEYS */;

-- Volcando estructura para tabla krece.bill_status
CREATE TABLE IF NOT EXISTS `bill_status` (
  `id` int(11) NOT NULL,
  `description` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.bill_status: ~7 rows (aproximadamente)
DELETE FROM `bill_status`;
/*!40000 ALTER TABLE `bill_status` DISABLE KEYS */;
INSERT INTO `bill_status` (`id`, `description`) VALUES
	(1, 'Abierta'),
	(2, 'Anulada'),
	(3, 'Aprobada'),
	(4, 'Pagada'),
	(5, 'Borrador'),
	(6, 'Cerrada'),
	(7, 'Enviada');
/*!40000 ALTER TABLE `bill_status` ENABLE KEYS */;

-- Volcando estructura para tabla krece.bill_tax
CREATE TABLE IF NOT EXISTS `bill_tax` (
  `id` bigint(20) NOT NULL,
  `bill_id` bigint(20) NOT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `tax_type` varchar(50) DEFAULT NULL,
  `tax_rate` float DEFAULT NULL,
  `tax_amount` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_invoice_supplier_order_tax` (`tax_id`),
  KEY `FK_invoice_supplier_order_invoice` (`bill_id`),
  KEY `FK_invocie_supplier_user` (`user_id`),
  CONSTRAINT `FK_invocie_supplier_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_invoice_supplier_ider_id` FOREIGN KEY (`bill_id`) REFERENCES `bill` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.bill_tax: ~0 rows (aproximadamente)
DELETE FROM `bill_tax`;
/*!40000 ALTER TABLE `bill_tax` DISABLE KEYS */;
/*!40000 ALTER TABLE `bill_tax` ENABLE KEYS */;

-- Volcando estructura para tabla krece.cache
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla krece.cache: ~0 rows (aproximadamente)
DELETE FROM `cache`;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;

-- Volcando estructura para tabla krece.category
CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `niif_account` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `isEditable` bit(1) NOT NULL DEFAULT b'1',
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `type_id` int(11) NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_category_account` (`account_id`),
  KEY `FK_category_parent` (`parent_id`),
  KEY `FK_category_user` (`user_id`),
  KEY `FK_category_type` (`type_id`),
  CONSTRAINT `FK_category_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_category_type` FOREIGN KEY (`type_id`) REFERENCES `category_type` (`id`),
  CONSTRAINT `FK_category_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=latin1 COMMENT='product categories';

-- Volcando datos para la tabla krece.category: ~165 rows (aproximadamente)
DELETE FROM `category`;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`id`, `account_id`, `user_id`, `parent_id`, `lft`, `rgt`, `name`, `niif_account`, `description`, `isEditable`, `isDeleted`, `type_id`, `updated_at`, `created_at`) VALUES
	(1, 1, 1, NULL, 1, 14, 'Ingresos', NULL, 'Bajo esta categoría se encuentran todos los Ingresos de la compañía', b'0', b'0', 1, '2017-04-12 09:26:10', '2017-04-12 09:26:10'),
	(2, 1, 1, 1, 2, 3, 'Devoluciones de ventas', NULL, NULL, b'0', b'0', 1, '2017-04-12 09:26:10', '2017-04-12 09:26:10'),
	(3, 1, 1, 1, 4, 5, 'Ingreso sin identificar', NULL, NULL, b'0', b'0', 1, '2017-04-12 09:26:11', '2017-04-12 09:26:11'),
	(4, 1, 1, 1, 6, 11, 'Ingresos no operacionales', NULL, NULL, b'0', b'0', 1, '2017-04-12 09:26:11', '2017-04-12 09:26:11'),
	(5, 1, 1, 4, 7, 10, 'Otros Ingresos', NULL, NULL, b'0', b'0', 1, '2017-04-12 09:26:11', '2017-04-12 09:26:11'),
	(6, 1, 1, 5, 8, 9, 'Ingresos por interes', NULL, 'Ingresos por intereses bancarios', b'0', b'0', 1, '2017-04-12 09:26:11', '2017-04-12 09:26:11'),
	(7, 1, 1, 1, 12, 13, 'Ventas', NULL, 'Bajo esta categoría se encuentran todos los Ingresos principales', b'0', b'0', 1, '2017-04-12 09:26:11', '2017-04-12 09:26:11'),
	(8, 1, 1, NULL, 15, 88, 'Egresos', NULL, 'Bajo esta categoría se encuentran todos los egresos de la compañía', b'0', b'0', 2, '2017-04-12 09:26:11', '2017-04-12 09:26:11'),
	(9, 1, 1, 8, 16, 17, 'Alquiler de equipos y licencias', NULL, NULL, b'0', b'0', 2, '2017-04-12 09:26:11', '2017-04-12 09:26:11'),
	(10, 1, 1, 8, 18, 19, 'Comisiones y honorarios', NULL, NULL, b'0', b'0', 2, '2017-04-12 09:26:11', '2017-04-12 09:26:11'),
	(11, 1, 1, 8, 20, 31, 'Costo de la mercancía vendida', NULL, NULL, b'0', b'0', 2, '2017-04-12 09:26:11', '2017-04-12 09:26:11'),
	(12, 1, 1, 11, 21, 22, 'Ajustes del inventario', NULL, NULL, b'0', b'0', 2, '2017-04-12 09:26:11', '2017-04-12 09:26:11'),
	(13, 1, 1, 11, 23, 24, 'Compras inventariables', NULL, NULL, b'0', b'0', 2, '2017-04-12 09:26:11', '2017-04-12 09:26:11'),
	(14, 1, 1, 11, 25, 26, 'Fletes y envíos', NULL, NULL, b'0', b'0', 2, '2017-04-12 09:26:11', '2017-04-12 09:26:11'),
	(15, 1, 1, 11, 27, 28, 'Mano de obra', NULL, NULL, b'0', b'0', 2, '2017-04-12 09:26:11', '2017-04-12 09:26:11'),
	(16, 1, 1, 11, 29, 30, 'Materias primas', NULL, NULL, b'0', b'0', 2, '2017-04-12 09:26:11', '2017-04-12 09:26:11'),
	(17, 1, 1, 8, 32, 33, 'Costo servicios vendidos', NULL, NULL, b'0', b'0', 2, '2017-04-12 09:26:11', '2017-04-12 09:26:11'),
	(18, 1, 1, 8, 34, 35, 'Cuentas incobrables', NULL, NULL, b'0', b'0', 2, '2017-04-12 09:26:11', '2017-04-12 09:26:11'),
	(19, 1, 1, 8, 36, 37, 'Devoluciones en compras de ítem', NULL, NULL, b'0', b'0', 2, '2017-04-12 09:26:11', '2017-04-12 09:26:11'),
	(20, 1, 1, 8, 38, 43, 'Egresos no operacionales', NULL, NULL, b'0', b'0', 2, '2017-04-12 09:26:12', '2017-04-12 09:26:12'),
	(21, 1, 1, 20, 39, 40, 'Descuento financiero', NULL, NULL, b'0', b'0', 2, '2017-04-12 09:26:12', '2017-04-12 09:26:12'),
	(22, 1, 1, 20, 41, 42, 'Diferencia en cambio', NULL, 'Bajo esta categoría se encuentran las perdidas y ganancias por diferencias en tasas de cambio', b'0', b'0', 2, '2017-04-12 09:26:12', '2017-04-12 09:26:12'),
	(23, 1, 1, 8, 44, 55, 'Gastos administrativos', NULL, NULL, b'1', b'0', 2, '2017-04-12 09:26:12', '2017-04-12 09:26:12'),
	(24, 1, 1, 23, 45, 46, 'Arrendamiento', NULL, NULL, b'1', b'0', 2, '2017-04-12 09:26:12', '2017-04-12 09:26:12'),
	(25, 1, 1, 23, 47, 48, 'Aseo y cafetería', NULL, NULL, b'1', b'0', 2, '2017-04-12 09:26:12', '2017-04-12 09:26:12'),
	(26, 1, 1, 23, 49, 50, 'Internet y telecomunicaciones', NULL, NULL, b'1', b'0', 2, '2017-04-12 09:26:12', '2017-04-12 09:26:12'),
	(27, 1, 1, 23, 51, 52, 'Papelería', NULL, NULL, b'1', b'0', 2, '2017-04-12 09:26:12', '2017-04-12 09:26:12'),
	(28, 1, 1, 23, 53, 54, 'Servicios públicos', NULL, NULL, b'1', b'0', 2, '2017-04-12 09:26:12', '2017-04-12 09:26:12'),
	(29, 1, 1, 8, 56, 57, 'Gastos bancarios', NULL, 'Bajo esta categoría se encuentran todos los gastos bancarios de la compañía', b'0', b'0', 2, '2017-04-12 09:26:12', '2017-04-12 09:26:12'),
	(30, 1, 1, 8, 58, 59, 'Legales', NULL, NULL, b'0', b'0', 2, '2017-04-12 09:26:12', '2017-04-12 09:26:12'),
	(31, 1, 1, 8, 60, 61, 'Mantenimiento e instalaciones', NULL, NULL, b'0', b'0', 2, '2017-04-12 09:26:12', '2017-04-12 09:26:12'),
	(32, 1, 1, 8, 62, 71, 'Nómina', NULL, NULL, b'0', b'0', 2, '2017-04-12 09:26:12', '2017-04-12 09:26:12'),
	(33, 1, 1, 32, 63, 64, 'Dotación', NULL, NULL, b'1', b'0', 2, '2017-04-12 09:26:12', '2017-04-12 09:26:12'),
	(34, 1, 1, 32, 65, 66, 'Prestaciones sociales', NULL, NULL, b'1', b'0', 2, '2017-04-12 09:26:12', '2017-04-12 09:26:12'),
	(35, 1, 1, 32, 67, 68, 'Salarios', NULL, NULL, b'1', b'0', 2, '2017-04-12 09:26:12', '2017-04-12 09:26:12'),
	(36, 1, 1, 32, 69, 70, 'Seguridad social y parafiscales', NULL, NULL, b'1', b'0', 2, '2017-04-12 09:26:12', '2017-04-12 09:26:12'),
	(37, 1, 1, 8, 72, 73, 'Otros impuestos', NULL, NULL, b'0', b'0', 2, '2017-04-12 09:26:12', '2017-04-12 09:26:12'),
	(38, 1, 1, 8, 74, 75, 'Publicidad', NULL, NULL, b'0', b'0', 2, '2017-04-12 09:26:13', '2017-04-12 09:26:13'),
	(39, 1, 1, 8, 76, 77, 'Seguros y seguridad', NULL, NULL, b'0', b'0', 2, '2017-04-12 09:26:13', '2017-04-12 09:26:13'),
	(40, 1, 1, 8, 78, 79, 'Servicios bancarios', NULL, NULL, b'0', b'0', 2, '2017-04-12 09:26:13', '2017-04-12 09:26:13'),
	(41, 1, 1, 8, 80, 81, 'Subscripciones y afiliaciones', NULL, NULL, b'0', b'0', 2, '2017-04-12 09:26:13', '2017-04-12 09:26:13'),
	(42, 1, 1, 8, 82, 83, 'Transporte y mensajería', NULL, NULL, b'0', b'0', 2, '2017-04-12 09:26:13', '2017-04-12 09:26:13'),
	(43, 1, 1, 8, 84, 85, 'Varios', NULL, NULL, b'0', b'0', 2, '2017-04-12 09:26:13', '2017-04-12 09:26:13'),
	(44, 1, 1, 8, 86, 87, 'Viajes y viáticos', NULL, NULL, b'0', b'0', 2, '2017-04-12 09:26:13', '2017-04-12 09:26:13'),
	(45, 1, 1, NULL, 89, 124, 'Activos', NULL, 'Bajo esta categoría se encuentran todos los activos de la compañía', b'0', b'0', 3, '2017-04-12 09:26:13', '2017-04-12 09:26:13'),
	(46, 1, 1, 45, 90, 97, 'Activo corriente', NULL, NULL, b'0', b'0', 3, '2017-04-12 09:26:13', '2017-04-12 09:26:13'),
	(47, 1, 1, 46, 91, 92, 'Bancos', NULL, NULL, b'0', b'0', 3, '2017-04-12 09:26:13', '2017-04-12 09:26:13'),
	(48, 1, 1, 46, 93, 94, 'Cuentas por cobrar', NULL, NULL, b'0', b'0', 3, '2017-04-12 09:26:13', '2017-04-12 09:26:13'),
	(49, 1, 1, 46, 95, 96, 'Inventario', NULL, NULL, b'0', b'0', 3, '2017-04-12 09:26:13', '2017-04-12 09:26:13'),
	(50, 1, 1, 45, 98, 99, 'Activos fijos', NULL, 'Bajo esta categoría se encuentran todos los activos principales de la compañía', b'0', b'0', 3, '2017-04-12 09:26:13', '2017-04-12 09:26:13'),
	(51, 1, 1, 45, 100, 101, 'Avances y anticipos entregados', NULL, NULL, b'0', b'0', 3, '2017-04-12 09:26:13', '2017-04-12 09:26:13'),
	(52, 1, 1, 45, 102, 103, 'Cuentas por cobrar - devoluciones', NULL, NULL, b'0', b'0', 3, '2017-04-12 09:26:13', '2017-04-12 09:26:13'),
	(53, 1, 1, 45, 104, 109, 'Impuestos a favor', NULL, NULL, b'0', b'0', 3, '2017-04-12 09:26:13', '2017-04-12 09:26:13'),
	(54, 1, 1, 53, 105, 106, 'ICO a favor', NULL, NULL, b'0', b'0', 3, '2017-04-12 09:26:13', '2017-04-12 09:26:13'),
	(55, 1, 1, 53, 107, 108, 'IVA a favor', NULL, NULL, b'0', b'0', 3, '2017-04-12 09:26:13', '2017-04-12 09:26:13'),
	(56, 1, 1, 45, 110, 111, 'Inversiones', NULL, NULL, b'0', b'0', 3, '2017-04-12 09:26:14', '2017-04-12 09:26:14'),
	(57, 1, 1, 45, 112, 113, 'Préstamos a terceros', NULL, NULL, b'0', b'0', 3, '2017-04-12 09:26:14', '2017-04-12 09:26:14'),
	(58, 1, 1, 45, 114, 123, 'Retenciones a favor', NULL, NULL, b'1', b'0', 3, '2017-04-12 09:26:14', '2017-04-12 09:26:14'),
	(59, 1, 1, 58, 115, 116, 'Retención de CREE a favor', NULL, NULL, b'1', b'0', 3, '2017-04-12 09:26:14', '2017-04-12 09:26:14'),
	(60, 1, 1, 58, 117, 118, 'Retención de Industria y comercio a favor', NULL, NULL, b'1', b'0', 3, '2017-04-12 09:26:14', '2017-04-12 09:26:14'),
	(61, 1, 1, 58, 119, 120, 'Retención de IVA a favor', NULL, NULL, b'1', b'0', 3, '2017-04-12 09:26:14', '2017-04-12 09:26:14'),
	(62, 1, 1, 58, 121, 122, 'Retención en la fuente a favor', NULL, NULL, b'1', b'0', 3, '2017-04-12 09:26:14', '2017-04-12 09:26:14'),
	(63, 1, 1, NULL, 125, 152, 'Pasivos', NULL, NULL, b'0', b'0', 4, '2017-04-12 09:26:14', '2017-04-12 09:26:14'),
	(64, 1, 1, 63, 126, 127, 'Avances y anticipos recibidos', NULL, NULL, b'0', b'0', 4, '2017-04-12 09:26:14', '2017-04-12 09:26:14'),
	(65, 1, 1, 63, 128, 129, 'Cuentas por pagar - devoluciones', NULL, NULL, b'0', b'0', 4, '2017-04-12 09:26:14', '2017-04-12 09:26:14'),
	(66, 1, 1, 63, 130, 131, 'Cuentas por pagar - proveedores', NULL, 'Bajo esta categoría se encuentran los pasivos principales', b'0', b'0', 4, '2017-04-12 09:26:14', '2017-04-12 09:26:14'),
	(67, 1, 1, 63, 132, 133, 'Cuentas por pagar - tarjetas de crédito', NULL, NULL, b'0', b'0', 4, '2017-04-12 09:26:14', '2017-04-12 09:26:14'),
	(68, 1, 1, 63, 134, 139, 'Impuestos por pagar', NULL, NULL, b'0', b'0', 4, '2017-04-12 09:26:14', '2017-04-12 09:26:14'),
	(69, 1, 1, 68, 135, 136, 'ICO por pagar', NULL, NULL, b'0', b'0', 4, '2017-04-12 09:26:14', '2017-04-12 09:26:14'),
	(70, 1, 1, 68, 137, 138, 'IVA por pagar', NULL, NULL, b'0', b'0', 4, '2017-04-12 09:26:14', '2017-04-12 09:26:14'),
	(71, 1, 1, 63, 140, 141, 'Obligaciones financieras y préstamos a terceros', NULL, 'Bajo esta categoría se encuentran todos los Ingresos principales', b'0', b'0', 4, '2017-04-12 09:26:14', '2017-04-12 09:26:14'),
	(72, 1, 1, 63, 142, 151, 'Retenciones por pagar', NULL, NULL, b'0', b'0', 4, '2017-04-12 09:26:14', '2017-04-12 09:26:14'),
	(73, 1, 1, 72, 143, 144, 'Retención de CREE por pagar', NULL, NULL, b'0', b'0', 4, '2017-04-12 09:26:14', '2017-04-12 09:26:14'),
	(74, 1, 1, 72, 145, 146, 'Retención de industria y Comercio por pagar', NULL, NULL, b'0', b'0', 4, '2017-04-12 09:26:14', '2017-04-12 09:26:14'),
	(75, 1, 1, 72, 147, 148, 'Retención de IVA por pagar', NULL, NULL, b'0', b'0', 4, '2017-04-12 09:26:15', '2017-04-12 09:26:15'),
	(76, 1, 1, 72, 149, 150, 'Retención en la fuente por pagar', NULL, NULL, b'0', b'0', 4, '2017-04-12 09:26:15', '2017-04-12 09:26:15'),
	(77, 1, 1, NULL, 153, 162, 'Patrimonio', NULL, NULL, b'0', b'0', 5, '2017-04-12 09:26:15', '2017-04-12 09:26:15'),
	(78, 1, 1, 77, 154, 155, 'Ajustes iniciales - Bancos', NULL, NULL, b'0', b'0', 5, '2017-04-12 09:26:15', '2017-04-12 09:26:15'),
	(79, 1, 1, 77, 156, 157, 'Ajustes iniciales - Inventario', NULL, NULL, b'0', b'0', 5, '2017-04-12 09:26:15', '2017-04-12 09:26:15'),
	(80, 1, 1, 77, 158, 159, 'Capital accionistas', NULL, NULL, b'0', b'0', 5, '2017-04-12 09:26:15', '2017-04-12 09:26:15'),
	(81, 1, 1, 77, 160, 161, 'Utilidades', NULL, 'Bajo esta categoría se encuentra el patrimonio principal', b'0', b'0', 5, '2017-04-12 09:26:15', '2017-04-12 09:26:15'),
	(82, 1, 1, NULL, 163, 164, 'Transferencias bancarias', NULL, 'Bajo esta categoría se encuentran todas las transferencias que se realizen entre bancos de la empresa', b'0', b'0', 6, '2017-04-12 09:26:15', '2017-04-12 09:26:15'),
	(83, 2, 2, NULL, 165, 178, 'Ingresos', NULL, 'Bajo esta categoría se encuentran todos los Ingresos de la compañía', b'0', b'0', 1, '2017-08-06 23:23:21', '2017-08-06 23:23:21'),
	(84, 2, 2, 83, 166, 167, 'Devoluciones de ventas', NULL, NULL, b'0', b'0', 1, '2017-08-06 23:23:22', '2017-08-06 23:23:22'),
	(85, 2, 2, 83, 168, 169, 'Ingreso sin identificar', NULL, NULL, b'0', b'0', 1, '2017-08-06 23:23:22', '2017-08-06 23:23:22'),
	(86, 2, 2, 83, 170, 175, 'Ingresos no operacionales', NULL, NULL, b'0', b'0', 1, '2017-08-06 23:23:22', '2017-08-06 23:23:22'),
	(87, 2, 2, 86, 171, 174, 'Otros Ingresos', NULL, NULL, b'0', b'0', 1, '2017-08-06 23:23:22', '2017-08-06 23:23:22'),
	(88, 2, 2, 87, 172, 173, 'Ingresos por interes', NULL, 'Ingresos por intereses bancarios', b'0', b'0', 1, '2017-08-06 23:23:22', '2017-08-06 23:23:22'),
	(89, 2, 2, 83, 176, 177, 'Ventas', NULL, 'Bajo esta categoría se encuentran todos los Ingresos principales', b'0', b'0', 1, '2017-08-06 23:23:22', '2017-08-06 23:23:22'),
	(90, 2, 2, NULL, 179, 252, 'Egresos', NULL, 'Bajo esta categoría se encuentran todos los egresos de la compañía', b'0', b'0', 2, '2017-08-06 23:23:22', '2017-08-06 23:23:22'),
	(91, 2, 2, 90, 180, 181, 'Alquiler de equipos y licencias', NULL, NULL, b'0', b'0', 2, '2017-08-06 23:23:22', '2017-08-06 23:23:22'),
	(92, 2, 2, 90, 182, 183, 'Comisiones y honorarios', NULL, NULL, b'0', b'0', 2, '2017-08-06 23:23:22', '2017-08-06 23:23:22'),
	(93, 2, 2, 90, 184, 195, 'Costo de la mercancía vendida', NULL, NULL, b'0', b'0', 2, '2017-08-06 23:23:23', '2017-08-06 23:23:23'),
	(94, 2, 2, 93, 185, 186, 'Ajustes del inventario', NULL, NULL, b'0', b'0', 2, '2017-08-06 23:23:23', '2017-08-06 23:23:23'),
	(95, 2, 2, 93, 187, 188, 'Compras inventariables', NULL, NULL, b'0', b'0', 2, '2017-08-06 23:23:23', '2017-08-06 23:23:23'),
	(96, 2, 2, 93, 189, 190, 'Fletes y envíos', NULL, NULL, b'0', b'0', 2, '2017-08-06 23:23:23', '2017-08-06 23:23:23'),
	(97, 2, 2, 93, 191, 192, 'Mano de obra', NULL, NULL, b'0', b'0', 2, '2017-08-06 23:23:23', '2017-08-06 23:23:23'),
	(98, 2, 2, 93, 193, 194, 'Materias primas', NULL, NULL, b'0', b'0', 2, '2017-08-06 23:23:23', '2017-08-06 23:23:23'),
	(99, 2, 2, 90, 196, 197, 'Costo servicios vendidos', NULL, NULL, b'0', b'0', 2, '2017-08-06 23:23:23', '2017-08-06 23:23:23'),
	(100, 2, 2, 90, 198, 199, 'Cuentas incobrables', NULL, NULL, b'0', b'0', 2, '2017-08-06 23:23:23', '2017-08-06 23:23:23'),
	(101, 2, 2, 90, 200, 201, 'Devoluciones en compras de ítem', NULL, NULL, b'0', b'0', 2, '2017-08-06 23:23:24', '2017-08-06 23:23:24'),
	(102, 2, 2, 90, 202, 207, 'Egresos no operacionales', NULL, NULL, b'0', b'0', 2, '2017-08-06 23:23:24', '2017-08-06 23:23:24'),
	(103, 2, 2, 102, 203, 204, 'Descuento financiero', NULL, NULL, b'0', b'0', 2, '2017-08-06 23:23:24', '2017-08-06 23:23:24'),
	(104, 2, 2, 102, 205, 206, 'Diferencia en cambio', NULL, 'Bajo esta categoría se encuentran las perdidas y ganancias por diferencias en tasas de cambio', b'0', b'0', 2, '2017-08-06 23:23:24', '2017-08-06 23:23:24'),
	(105, 2, 2, 90, 208, 219, 'Gastos administrativos', NULL, NULL, b'1', b'0', 2, '2017-08-06 23:23:24', '2017-08-06 23:23:24'),
	(106, 2, 2, 105, 209, 210, 'Arrendamiento', NULL, NULL, b'1', b'0', 2, '2017-08-06 23:23:24', '2017-08-06 23:23:24'),
	(107, 2, 2, 105, 211, 212, 'Aseo y cafetería', NULL, NULL, b'1', b'0', 2, '2017-08-06 23:23:24', '2017-08-06 23:23:24'),
	(108, 2, 2, 105, 213, 214, 'Internet y telecomunicaciones', NULL, NULL, b'1', b'0', 2, '2017-08-06 23:23:24', '2017-08-06 23:23:24'),
	(109, 2, 2, 105, 215, 216, 'Papelería', NULL, NULL, b'1', b'0', 2, '2017-08-06 23:23:25', '2017-08-06 23:23:25'),
	(110, 2, 2, 105, 217, 218, 'Servicios públicos', NULL, NULL, b'1', b'0', 2, '2017-08-06 23:23:25', '2017-08-06 23:23:25'),
	(111, 2, 2, 90, 220, 221, 'Gastos bancarios', NULL, 'Bajo esta categoría se encuentran todos los gastos bancarios de la compañía', b'0', b'0', 2, '2017-08-06 23:23:25', '2017-08-06 23:23:25'),
	(112, 2, 2, 90, 222, 223, 'Legales', NULL, NULL, b'0', b'0', 2, '2017-08-06 23:23:25', '2017-08-06 23:23:25'),
	(113, 2, 2, 90, 224, 225, 'Mantenimiento e instalaciones', NULL, NULL, b'0', b'0', 2, '2017-08-06 23:23:25', '2017-08-06 23:23:25'),
	(114, 2, 2, 90, 226, 235, 'Nómina', NULL, NULL, b'0', b'0', 2, '2017-08-06 23:23:25', '2017-08-06 23:23:25'),
	(115, 2, 2, 114, 227, 228, 'Dotación', NULL, NULL, b'1', b'0', 2, '2017-08-06 23:23:25', '2017-08-06 23:23:25'),
	(116, 2, 2, 114, 229, 230, 'Prestaciones sociales', NULL, NULL, b'1', b'0', 2, '2017-08-06 23:23:26', '2017-08-06 23:23:26'),
	(117, 2, 2, 114, 231, 232, 'Salarios', NULL, NULL, b'1', b'0', 2, '2017-08-06 23:23:26', '2017-08-06 23:23:26'),
	(118, 2, 2, 114, 233, 234, 'Seguridad social y parafiscales', NULL, NULL, b'1', b'0', 2, '2017-08-06 23:23:26', '2017-08-06 23:23:26'),
	(119, 2, 2, 90, 236, 237, 'Otros impuestos', NULL, NULL, b'0', b'0', 2, '2017-08-06 23:23:26', '2017-08-06 23:23:26'),
	(120, 2, 2, 90, 238, 239, 'Publicidad', NULL, NULL, b'0', b'0', 2, '2017-08-06 23:23:26', '2017-08-06 23:23:26'),
	(121, 2, 2, 90, 240, 241, 'Seguros y seguridad', NULL, NULL, b'0', b'0', 2, '2017-08-06 23:23:26', '2017-08-06 23:23:26'),
	(122, 2, 2, 90, 242, 243, 'Servicios bancarios', NULL, NULL, b'0', b'0', 2, '2017-08-06 23:23:26', '2017-08-06 23:23:26'),
	(123, 2, 2, 90, 244, 245, 'Subscripciones y afiliaciones', NULL, NULL, b'0', b'0', 2, '2017-08-06 23:23:26', '2017-08-06 23:23:26'),
	(124, 2, 2, 90, 246, 247, 'Transporte y mensajería', NULL, NULL, b'0', b'0', 2, '2017-08-06 23:23:27', '2017-08-06 23:23:27'),
	(125, 2, 2, 90, 248, 249, 'Varios', NULL, NULL, b'0', b'0', 2, '2017-08-06 23:23:27', '2017-08-06 23:23:27'),
	(126, 2, 2, 90, 250, 251, 'Viajes y viáticos', NULL, NULL, b'0', b'0', 2, '2017-08-06 23:23:27', '2017-08-06 23:23:27'),
	(127, 2, 2, NULL, 253, 288, 'Activos', NULL, 'Bajo esta categoría se encuentran todos los activos de la compañía', b'0', b'0', 3, '2017-08-06 23:23:27', '2017-08-06 23:23:27'),
	(128, 2, 2, 127, 254, 261, 'Activo corriente', NULL, NULL, b'0', b'0', 3, '2017-08-06 23:23:27', '2017-08-06 23:23:27'),
	(129, 2, 2, 128, 255, 256, 'Bancos', NULL, NULL, b'0', b'0', 3, '2017-08-06 23:23:27', '2017-08-06 23:23:27'),
	(130, 2, 2, 128, 257, 258, 'Cuentas por cobrar', NULL, NULL, b'0', b'0', 3, '2017-08-06 23:23:27', '2017-08-06 23:23:27'),
	(131, 2, 2, 128, 259, 260, 'Inventario', NULL, NULL, b'0', b'0', 3, '2017-08-06 23:23:27', '2017-08-06 23:23:27'),
	(132, 2, 2, 127, 262, 263, 'Activos fijos', NULL, 'Bajo esta categoría se encuentran todos los activos principales de la compañía', b'0', b'0', 3, '2017-08-06 23:23:28', '2017-08-06 23:23:28'),
	(133, 2, 2, 127, 264, 265, 'Avances y anticipos entregados', NULL, NULL, b'0', b'0', 3, '2017-08-06 23:23:28', '2017-08-06 23:23:28'),
	(134, 2, 2, 127, 266, 267, 'Cuentas por cobrar - devoluciones', NULL, NULL, b'0', b'0', 3, '2017-08-06 23:23:28', '2017-08-06 23:23:28'),
	(135, 2, 2, 127, 268, 273, 'Impuestos a favor', NULL, NULL, b'0', b'0', 3, '2017-08-06 23:23:28', '2017-08-06 23:23:28'),
	(136, 2, 2, 135, 269, 270, 'ICO a favor', NULL, NULL, b'0', b'0', 3, '2017-08-06 23:23:28', '2017-08-06 23:23:28'),
	(137, 2, 2, 135, 271, 272, 'IVA a favor', NULL, NULL, b'0', b'0', 3, '2017-08-06 23:23:28', '2017-08-06 23:23:28'),
	(138, 2, 2, 127, 274, 275, 'Inversiones', NULL, NULL, b'0', b'0', 3, '2017-08-06 23:23:28', '2017-08-06 23:23:28'),
	(139, 2, 2, 127, 276, 277, 'Préstamos a terceros', NULL, NULL, b'0', b'0', 3, '2017-08-06 23:23:28', '2017-08-06 23:23:28'),
	(140, 2, 2, 127, 278, 287, 'Retenciones a favor', NULL, NULL, b'1', b'0', 3, '2017-08-06 23:23:29', '2017-08-06 23:23:29'),
	(141, 2, 2, 140, 279, 280, 'Retención de CREE a favor', NULL, NULL, b'1', b'0', 3, '2017-08-06 23:23:29', '2017-08-06 23:23:29'),
	(142, 2, 2, 140, 281, 282, 'Retención de Industria y comercio a favor', NULL, NULL, b'1', b'0', 3, '2017-08-06 23:23:29', '2017-08-06 23:23:29'),
	(143, 2, 2, 140, 283, 284, 'Retención de IVA a favor', NULL, NULL, b'1', b'0', 3, '2017-08-06 23:23:29', '2017-08-06 23:23:29'),
	(144, 2, 2, 140, 285, 286, 'Retención en la fuente a favor', NULL, NULL, b'1', b'0', 3, '2017-08-06 23:23:29', '2017-08-06 23:23:29'),
	(145, 2, 2, NULL, 289, 316, 'Pasivos', NULL, NULL, b'0', b'0', 4, '2017-08-06 23:23:29', '2017-08-06 23:23:29'),
	(146, 2, 2, 145, 290, 291, 'Avances y anticipos recibidos', NULL, NULL, b'0', b'0', 4, '2017-08-06 23:23:29', '2017-08-06 23:23:29'),
	(147, 2, 2, 145, 292, 293, 'Cuentas por pagar - devoluciones', NULL, NULL, b'0', b'0', 4, '2017-08-06 23:23:29', '2017-08-06 23:23:29'),
	(148, 2, 2, 145, 294, 295, 'Cuentas por pagar - proveedores', NULL, 'Bajo esta categoría se encuentran los pasivos principales', b'0', b'0', 4, '2017-08-06 23:23:29', '2017-08-06 23:23:29'),
	(149, 2, 2, 145, 296, 297, 'Cuentas por pagar - tarjetas de crédito', NULL, NULL, b'0', b'0', 4, '2017-08-06 23:23:30', '2017-08-06 23:23:30'),
	(150, 2, 2, 145, 298, 303, 'Impuestos por pagar', NULL, NULL, b'0', b'0', 4, '2017-08-06 23:23:30', '2017-08-06 23:23:30'),
	(151, 2, 2, 150, 299, 300, 'ICO por pagar', NULL, NULL, b'0', b'0', 4, '2017-08-06 23:23:30', '2017-08-06 23:23:30'),
	(152, 2, 2, 150, 301, 302, 'IVA por pagar', NULL, NULL, b'0', b'0', 4, '2017-08-06 23:23:30', '2017-08-06 23:23:30'),
	(153, 2, 2, 145, 304, 305, 'Obligaciones financieras y préstamos a terceros', NULL, 'Bajo esta categoría se encuentran todos los Ingresos principales', b'0', b'0', 4, '2017-08-06 23:23:30', '2017-08-06 23:23:30'),
	(154, 2, 2, 145, 306, 315, 'Retenciones por pagar', NULL, NULL, b'0', b'0', 4, '2017-08-06 23:23:30', '2017-08-06 23:23:30'),
	(155, 2, 2, 154, 307, 308, 'Retención de CREE por pagar', NULL, NULL, b'0', b'0', 4, '2017-08-06 23:23:30', '2017-08-06 23:23:30'),
	(156, 2, 2, 154, 309, 310, 'Retención de industria y Comercio por pagar', NULL, NULL, b'0', b'0', 4, '2017-08-06 23:23:30', '2017-08-06 23:23:30'),
	(157, 2, 2, 154, 311, 312, 'Retención de IVA por pagar', NULL, NULL, b'0', b'0', 4, '2017-08-06 23:23:31', '2017-08-06 23:23:31'),
	(158, 2, 2, 154, 313, 314, 'Retención en la fuente por pagar', NULL, NULL, b'0', b'0', 4, '2017-08-06 23:23:31', '2017-08-06 23:23:31'),
	(159, 2, 2, NULL, 317, 326, 'Patrimonio', NULL, NULL, b'0', b'0', 5, '2017-08-06 23:23:31', '2017-08-06 23:23:31'),
	(160, 2, 2, 159, 318, 319, 'Ajustes iniciales - Bancos', NULL, NULL, b'0', b'0', 5, '2017-08-06 23:23:31', '2017-08-06 23:23:31'),
	(161, 2, 2, 159, 320, 321, 'Ajustes iniciales - Inventario', NULL, NULL, b'0', b'0', 5, '2017-08-06 23:23:31', '2017-08-06 23:23:31'),
	(162, 2, 2, 159, 322, 323, 'Capital accionistas', NULL, NULL, b'0', b'0', 5, '2017-08-06 23:23:31', '2017-08-06 23:23:31'),
	(163, 2, 2, 159, 324, 325, 'Utilidades', NULL, 'Bajo esta categoría se encuentra el patrimonio principal', b'0', b'0', 5, '2017-08-06 23:23:31', '2017-08-06 23:23:31'),
	(164, 2, 2, NULL, 327, 328, 'Transferencias bancarias', NULL, 'Bajo esta categoría se encuentran todas las transferencias que se realizen entre bancos de la empresa', b'0', b'0', 6, '2017-08-06 23:23:31', '2017-08-06 23:23:31');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

-- Volcando estructura para tabla krece.category_payment
CREATE TABLE IF NOT EXISTS `category_payment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `payment_id` bigint(20) NOT NULL,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `unit_price` float NOT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `tax_amount` float DEFAULT NULL,
  `tax_total` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `observations` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `payment_id_company_id_category_id_tax_id` (`payment_id`,`account_id`,`category_id`,`tax_id`),
  KEY `FK_cp_tax` (`tax_id`),
  KEY `FK_cp_company_id` (`account_id`),
  KEY `FK_cp_payment_id` (`payment_id`),
  KEY `FK_cp_category` (`category_id`),
  KEY `FK_cp_user` (`user_id`),
  CONSTRAINT `FK_cp_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `FK_cp_company_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_cp_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`),
  CONSTRAINT `FK_cp_tax` FOREIGN KEY (`tax_id`) REFERENCES `tax` (`id`),
  CONSTRAINT `FK_cp_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.category_payment: ~6 rows (aproximadamente)
DELETE FROM `category_payment`;
/*!40000 ALTER TABLE `category_payment` DISABLE KEYS */;
INSERT INTO `category_payment` (`id`, `payment_id`, `account_id`, `user_id`, `category_id`, `unit_price`, `tax_id`, `tax_amount`, `tax_total`, `total`, `quantity`, `observations`, `created_at`, `updated_at`) VALUES
	(1, 1, 1, 1, 42, 2000, NULL, NULL, NULL, 2000, 1, NULL, '2017-04-13 21:25:29', '2017-04-13 21:25:29'),
	(2, 2, 1, 1, 2, 2000, 1, 19, 380, 2000, 1, 'asas', '2017-08-29 19:08:19', '2017-08-29 19:08:19'),
	(3, 32, 1, 1, 18, 20000, 1, 19, 7600, 40000, 2, NULL, '2017-09-07 08:54:55', '2017-09-07 08:54:55'),
	(4, 32, 1, 1, 11, 2345, 2, 19, 1336.65, 7035, 3, NULL, '2017-09-07 08:54:56', '2017-09-07 08:54:56'),
	(5, 33, 1, 1, 12, 34541, 1, 19, 32813.9, 172705, 5, 'observaciones', '2017-09-07 08:57:52', '2017-09-07 08:57:52'),
	(6, 33, 1, 1, 10, 4200, 3, 0, NULL, 4200, 1, 'ob2', '2017-09-07 08:57:52', '2017-09-07 08:57:52'),
	(7, 35, 1, 1, 18, 3000, 1, 19, 570, 3000, 1, NULL, '2017-09-20 09:48:21', '2017-09-20 09:48:21');
/*!40000 ALTER TABLE `category_payment` ENABLE KEYS */;

-- Volcando estructura para tabla krece.category_type
CREATE TABLE IF NOT EXISTS `category_type` (
  `id` int(11) NOT NULL,
  `type` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.category_type: ~6 rows (aproximadamente)
DELETE FROM `category_type`;
/*!40000 ALTER TABLE `category_type` DISABLE KEYS */;
INSERT INTO `category_type` (`id`, `type`) VALUES
	(1, 'Ingreso'),
	(2, 'Egreso'),
	(3, 'Activo'),
	(4, 'Pasivo'),
	(5, 'Patrimonio'),
	(6, 'Transferencia');
/*!40000 ALTER TABLE `category_type` ENABLE KEYS */;

-- Volcando estructura para tabla krece.conciliation
CREATE TABLE IF NOT EXISTS `conciliation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bank_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `date_update` datetime DEFAULT NULL,
  `bank_expens` float DEFAULT NULL,
  `bank_tax` float DEFAULT NULL,
  `bank_in` float DEFAULT NULL,
  `balance_initial` float NOT NULL,
  `balance_last` float NOT NULL,
  `difference` float NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_conciliation_bank` (`bank_id`),
  KEY `FK_conciliation_accountid` (`account_id`),
  KEY `FK_conciliation_user` (`user_id`),
  CONSTRAINT `FK_conciliation_accountid` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_conciliation_bank` FOREIGN KEY (`bank_id`) REFERENCES `bank_account` (`id`),
  CONSTRAINT `FK_conciliation_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='conciliation of accounts';

-- Volcando datos para la tabla krece.conciliation: ~0 rows (aproximadamente)
DELETE FROM `conciliation`;
/*!40000 ALTER TABLE `conciliation` DISABLE KEYS */;
/*!40000 ALTER TABLE `conciliation` ENABLE KEYS */;

-- Volcando estructura para tabla krece.contact
CREATE TABLE IF NOT EXISTS `contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `public_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `nit` varchar(20) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone1` varchar(20) DEFAULT NULL,
  `phone2` varchar(20) DEFAULT NULL,
  `fax` varchar(20) DEFAULT NULL,
  `phone_mobile` varchar(20) DEFAULT NULL,
  `list_price_id` int(11) DEFAULT NULL,
  `seller_id` int(11) DEFAULT NULL,
  `payment_terms_id` int(11) DEFAULT NULL,
  `observation` text DEFAULT NULL,
  `include_account_state` bit(1) NOT NULL DEFAULT b'0',
  `isProvider` bit(1) NOT NULL DEFAULT b'0',
  `isCustomer` bit(1) NOT NULL DEFAULT b'0',
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_contacts_company_id_email` (`account_id`,`public_id`),
  KEY `FK_contacts_seller` (`seller_id`),
  KEY `FK_contacts_payment_term` (`payment_terms_id`),
  KEY `FK_contacts_company` (`account_id`),
  KEY `FK_contacts_list_price` (`list_price_id`),
  KEY `FK_contacts_user` (`user_id`),
  CONSTRAINT `FK_contacts_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_contacts_list_price` FOREIGN KEY (`list_price_id`) REFERENCES `list_price` (`id`),
  CONSTRAINT `FK_contacts_payment_term` FOREIGN KEY (`payment_terms_id`) REFERENCES `payment_terms` (`id`),
  CONSTRAINT `FK_contacts_seller` FOREIGN KEY (`seller_id`) REFERENCES `seller` (`id`),
  CONSTRAINT `FK_contacts_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1 COMMENT='contains the whole set of contacts of each company';

-- Volcando datos para la tabla krece.contact: ~21 rows (aproximadamente)
DELETE FROM `contact`;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` (`id`, `account_id`, `user_id`, `public_id`, `name`, `nit`, `address`, `city`, `email`, `phone1`, `phone2`, `fax`, `phone_mobile`, `list_price_id`, `seller_id`, `payment_terms_id`, `observation`, `include_account_state`, `isProvider`, `isCustomer`, `isDeleted`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, 'pepito perez', '123456', 'asas', 'Bogota', 'pepito.perez@hotmail.com', '1234567', NULL, NULL, '3123633753', 1, 1, 1, NULL, b'0', b'1', b'1', b'0', '2017-04-12 09:26:54', '2018-10-20 23:29:01', '2018-10-20 23:29:01'),
	(2, 1, 1, 2, 'proveedor', '123456', 'calle 1', 'bogota', NULL, '123456', NULL, NULL, '4232212', 1, 1, 1, 'debe llamarse cada mes', b'0', b'0', b'1', b'0', '2017-09-08 17:19:28', '2018-10-20 23:28:38', NULL),
	(3, 1, 1, 3, 'fernando ardila', '80810419', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'0', b'0', b'0', '2017-09-12 10:48:17', '2017-09-12 10:48:17', NULL),
	(4, 1, 1, 4, 'Fernando Ardila 2', '80810419', 'Calle 12 # 2-49', 'Bogotá', 'fernando26@gmail.com', '123456', '122345', 'este es fax', '3123245', 1, 1, 3, NULL, b'0', b'0', b'1', b'0', '2017-09-12 11:26:29', '2018-10-20 23:28:27', NULL),
	(5, 1, 1, 5, 'Fer2', '12345678', NULL, 'chia', NULL, NULL, NULL, NULL, '3120000000', 1, 1, 1, 'no hay observaciones', b'0', b'1', b'1', b'0', '2017-09-12 11:30:12', '2018-10-20 21:11:38', NULL),
	(6, 1, 1, 6, 'Fernando Ardila 2', '80810419', 'Calle 12 # 2-49', 'Bogotá', 'fernando26@gmail.com', NULL, NULL, 'este es fax', NULL, 1, 1, 3, NULL, b'0', b'0', b'1', b'1', '2017-09-12 17:19:46', '2018-10-18 21:54:24', '2018-10-18 21:54:24'),
	(7, 1, 1, 7, 'Fernando Ardila 2', '80810419', 'Calle 12 # 2-49', 'Bogotá', 'fernando26@gmail.com', NULL, NULL, 'este es fax', NULL, 1, 1, 3, NULL, b'0', b'0', b'1', b'1', '2017-09-12 17:19:54', '2018-10-18 21:52:07', '2018-10-18 21:52:07'),
	(8, 1, 1, 8, 'Fernando Ardila 2', '80810419', 'Calle 12 # 2-49', 'Bogotá', 'fernando26@gmail.com', NULL, NULL, 'este es fax', NULL, 1, 1, 3, NULL, b'0', b'0', b'1', b'1', '2017-09-12 17:20:07', '2017-09-12 17:40:44', '2017-09-12 17:40:44'),
	(9, 1, 1, 9, 'TEST', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'1', b'1', b'1', '2017-09-12 17:24:20', '2017-09-12 17:40:05', '2017-09-12 17:40:05'),
	(10, 1, 1, 10, 'TEST', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'0', b'1', b'1', '2017-09-12 17:24:39', '2017-09-12 17:39:16', '2017-09-12 17:39:16'),
	(11, 1, 1, 11, 't', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'0', b'1', b'1', '2017-09-12 17:41:20', '2017-09-12 17:42:53', '2017-09-12 17:42:53'),
	(12, 1, 1, 12, 't2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'0', b'1', b'1', '2017-09-12 17:41:23', '2017-09-12 17:42:49', '2017-09-12 17:42:49'),
	(13, 1, 1, 13, 't24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'0', b'1', b'1', '2017-09-12 17:41:26', '2017-09-12 17:41:37', '2017-09-12 17:41:37'),
	(14, 1, 1, 14, '123', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'0', b'1', b'1', '2017-09-12 17:43:11', '2017-09-12 17:43:21', '2017-09-12 17:43:21'),
	(15, 1, 1, 15, 'rqw', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'0', b'1', b'1', '2017-09-12 17:43:13', '2017-09-12 17:43:17', '2017-09-12 17:43:17'),
	(16, 1, 1, 16, 'prov1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'1', b'0', b'1', '2017-09-12 17:44:21', '2018-10-18 21:54:54', '2018-10-18 21:54:54'),
	(17, 1, 1, 17, 'prov12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'1', b'0', b'1', '2017-09-12 17:44:23', '2017-09-12 17:44:34', '2017-09-12 17:44:34'),
	(18, 1, 1, 18, 'prov124', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'1', b'0', b'1', '2017-09-12 17:44:25', '2017-09-12 17:44:29', '2017-09-12 17:44:29'),
	(19, 1, 1, 19, 'Juan Felipe Ardila', '12345', 'calle 12 # 2-49', 'chia', 'fernando2684@gmail.com', '1234566', 'na', '122', '3000000000', 1, 1, 1, 'no hay', b'0', b'0', b'1', b'0', '2018-10-18 21:49:07', '2018-10-18 21:49:07', NULL),
	(20, 1, 1, 20, 'prov2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'1', b'0', b'0', '2018-10-20 23:07:09', '2018-10-20 23:07:09', NULL),
	(21, 1, 1, 21, 'custo 2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'0', b'1', b'1', '2018-10-20 23:07:28', '2018-10-20 23:36:05', '2018-10-20 23:36:05'),
	(22, 1, 1, 22, 'asas', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'0', b'1', b'1', '2018-10-20 23:19:53', '2018-10-20 23:20:02', '2018-10-20 23:20:02'),
	(23, 1, 1, 23, 'test', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'1', b'0', b'1', '2018-10-20 23:27:29', '2018-10-20 23:36:00', '2018-10-20 23:36:00');
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;

-- Volcando estructura para tabla krece.contact_others
CREATE TABLE IF NOT EXISTS `contact_others` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL COMMENT 'pk about the father of the set included here',
  `contact_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `phone_mobile` varchar(20) DEFAULT NULL,
  `notify` bit(1) NOT NULL DEFAULT b'0' COMMENT 'allows to send automatic notifications to the customer or provider selected',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_contact_others_contact_id_email` (`account_id`,`id`),
  KEY `FK_contacts_others_user` (`user_id`),
  KEY `FK_contacts_contact_id` (`contact_id`),
  CONSTRAINT `FK_contacts_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `FK_contacts_others_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_contacts_others_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=latin1 COMMENT='this table contains other email contacts of any organization';

-- Volcando datos para la tabla krece.contact_others: ~8 rows (aproximadamente)
DELETE FROM `contact_others`;
/*!40000 ALTER TABLE `contact_others` DISABLE KEYS */;
INSERT INTO `contact_others` (`id`, `account_id`, `contact_id`, `user_id`, `name`, `last_name`, `email`, `phone`, `phone_mobile`, `notify`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(26, 1, 10, 1, 'F', NULL, 'T', NULL, NULL, b'0', '2017-09-12 17:24:39', '2017-09-12 17:24:39', NULL),
	(42, 1, 5, 1, 'contacto 1', 'ardilosky', 'pipe@hotmail.com', NULL, NULL, b'1', '2018-10-20 21:18:45', '2018-10-20 21:18:45', NULL),
	(43, 1, 5, 1, 'pipex', 'ardila', 'pixe@sanchez', '312345', '312', b'1', '2018-10-20 21:18:45', '2018-10-20 21:18:45', NULL),
	(44, 1, 1, 1, 'juanito', 'alimaña', 'juanito.alimaña@hotmail.com', '312344', NULL, b'0', '2018-10-20 23:27:48', '2018-10-20 23:27:48', NULL),
	(45, 1, 1, 1, 'andry', NULL, 'andry@yahoo.com', NULL, NULL, b'0', '2018-10-20 23:27:48', '2018-10-20 23:27:48', NULL),
	(51, 1, 4, 1, 'felipe', 'ardila', 'felipao@hotmail.com', '12345678', '3000222', b'1', '2018-10-20 23:28:27', '2018-10-20 23:28:27', NULL),
	(52, 1, 4, 1, 'felipe12456', NULL, 'felipao2@hotmail.com', '1234568', NULL, b'1', '2018-10-20 23:28:27', '2018-10-20 23:28:27', NULL),
	(53, 1, 2, 1, 'fer2', 'ard', '123@hotmail.com', NULL, NULL, b'1', '2018-10-20 23:28:39', '2018-10-20 23:28:39', NULL);
/*!40000 ALTER TABLE `contact_others` ENABLE KEYS */;

-- Volcando estructura para tabla krece.credit_note
CREATE TABLE IF NOT EXISTS `credit_note` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `public_id` int(11) DEFAULT NULL,
  `resolution_id` int(11) DEFAULT NULL,
  `list_price_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `currency_code` varchar(3) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `observations` varchar(255) DEFAULT NULL,
  `exchange_rate` float DEFAULT NULL,
  `sub_total` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `total_discounts` float DEFAULT NULL,
  `total_taxes` float DEFAULT NULL,
  `amount_pending_to_apply` float DEFAULT NULL,
  `isDeleted` bit(1) DEFAULT b'0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_public_account` (`public_id`,`account_id`),
  KEY `FK_credit_note_company` (`account_id`),
  KEY `FK_credit_note_list_price` (`list_price_id`),
  KEY `FK_credit_note_customer` (`customer_id`),
  KEY `FK_credit_note_currency` (`currency_code`),
  KEY `FK_credit_note_user` (`user_id`),
  CONSTRAINT `FK_credit_note_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_credit_note_currency` FOREIGN KEY (`currency_code`) REFERENCES `currency_code` (`code`),
  CONSTRAINT `FK_credit_note_customer` FOREIGN KEY (`customer_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `FK_credit_note_list_price` FOREIGN KEY (`list_price_id`) REFERENCES `list_price` (`id`),
  CONSTRAINT `FK_credit_note_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.credit_note: ~3 rows (aproximadamente)
DELETE FROM `credit_note`;
/*!40000 ALTER TABLE `credit_note` DISABLE KEYS */;
INSERT INTO `credit_note` (`id`, `account_id`, `user_id`, `public_id`, `resolution_id`, `list_price_id`, `customer_id`, `currency_code`, `date`, `notes`, `observations`, `exchange_rate`, `sub_total`, `total`, `total_discounts`, `total_taxes`, `amount_pending_to_apply`, `isDeleted`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, 1, 1, 1, 'COP', '2017-08-29', 'nota credito 1', 'nota credito 1', NULL, 2000, 2000, 0, 0, NULL, b'1', '2017-08-29 13:45:54', '2017-08-29 18:41:04', '2017-08-29 18:41:04'),
	(2, 1, 1, 2, 2, 1, 1, 'COP', '2017-08-29', 'notas nota credito 2', NULL, NULL, 2000, 2142, 200, 342, NULL, b'0', '2017-08-29 18:12:55', '2017-08-29 18:25:18', NULL),
	(3, 1, 1, 3, 3, 1, 1, 'COP', '2017-08-29', 'nptas test 3', 'test', NULL, 9000, 9750, 200, 950, NULL, b'0', '2017-08-29 18:40:48', '2017-08-29 18:40:48', NULL),
	(4, 1, 1, 4, 4, 1, 1, 'COP', '2017-09-04', 'asasas', NULL, NULL, 34000, 39128, 800, 5928, NULL, b'0', '2017-09-03 21:13:42', '2017-09-04 21:58:22', NULL);
/*!40000 ALTER TABLE `credit_note` ENABLE KEYS */;

-- Volcando estructura para tabla krece.credit_note_detail
CREATE TABLE IF NOT EXISTS `credit_note_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `credit_note_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `reference` varchar(50) DEFAULT NULL,
  `unit_price` float NOT NULL,
  `discount` float DEFAULT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `tax_amount` float DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `total_tax` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_credit_note_detail_credit_note_id` (`credit_note_id`),
  KEY `FK_credit_note_detail_item` (`product_id`),
  KEY `FK_credit_note_detail_tax` (`tax_id`),
  KEY `FK_credit_note:user` (`user_id`),
  CONSTRAINT `FK_credit_note:user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_credit_note_detail_item` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FK_credit_note_detail_remision_id` FOREIGN KEY (`credit_note_id`) REFERENCES `credit_note` (`id`),
  CONSTRAINT `FK_credit_note_detail_tax` FOREIGN KEY (`tax_id`) REFERENCES `tax` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.credit_note_detail: ~9 rows (aproximadamente)
DELETE FROM `credit_note_detail`;
/*!40000 ALTER TABLE `credit_note_detail` DISABLE KEYS */;
INSERT INTO `credit_note_detail` (`id`, `credit_note_id`, `user_id`, `product_id`, `reference`, `unit_price`, `discount`, `tax_id`, `tax_amount`, `name`, `description`, `quantity`, `total_tax`, `total`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, NULL, 2000, 0, NULL, 0, 'item venta', NULL, 1, 0, 2000, '2017-08-29 13:45:54', '2017-08-29 13:45:54', NULL),
	(5, 2, 1, 1, NULL, 2000, 10, 2, 19, NULL, NULL, 1, 342, 1800, '2017-08-29 18:25:18', '2017-08-29 18:25:18', NULL),
	(6, 3, 1, 1, NULL, 2000, 0, 2, 19, NULL, NULL, 1, 380, 2000, '2017-08-29 18:40:48', '2017-08-29 18:40:48', NULL),
	(7, 3, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-29 18:40:48', '2017-08-29 18:40:48', NULL),
	(8, 3, 1, 1, NULL, 2000, 10, NULL, 0, NULL, NULL, 1, 0, 1800, '2017-08-29 18:40:48', '2017-08-29 18:40:48', NULL),
	(9, 3, 1, 1, NULL, 3000, 0, 1, 19, NULL, NULL, 1, 570, 3000, '2017-08-29 18:40:48', '2017-08-29 18:40:48', NULL),
	(13, 4, 1, 1, NULL, 2000, 0, 2, 19, NULL, NULL, 12, 4560, 24000, '2017-09-04 21:58:22', '2017-09-04 21:58:22', NULL),
	(14, 4, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-09-04 21:58:22', '2017-09-04 21:58:22', NULL),
	(15, 4, 1, 1, NULL, 8000, 10, 1, 19, NULL, NULL, 1, 1368, 7200, '2017-09-04 21:58:22', '2017-09-04 21:58:22', NULL);
/*!40000 ALTER TABLE `credit_note_detail` ENABLE KEYS */;

-- Volcando estructura para tabla krece.currency
CREATE TABLE IF NOT EXISTS `currency` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `public_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `code_id` varchar(3) NOT NULL,
  `exchange_rate` float NOT NULL,
  `status_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_currency_company_id_code_id` (`account_id`,`public_id`),
  KEY `FK_currency_code` (`code_id`),
  KEY `FK_currency_status` (`status_id`),
  KEY `FK_currency_user` (`user_id`),
  KEY `IDX_currency_public_id` (`public_id`),
  CONSTRAINT `FK_currency_code` FOREIGN KEY (`code_id`) REFERENCES `currency_code` (`code`),
  CONSTRAINT `FK_currency_status` FOREIGN KEY (`status_id`) REFERENCES `currency_status` (`id`),
  CONSTRAINT `FK_currency_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_currency_company` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.currency: ~0 rows (aproximadamente)
DELETE FROM `currency`;
/*!40000 ALTER TABLE `currency` DISABLE KEYS */;
/*!40000 ALTER TABLE `currency` ENABLE KEYS */;

-- Volcando estructura para tabla krece.currency_code
CREATE TABLE IF NOT EXISTS `currency_code` (
  `code` varchar(3) NOT NULL,
  `country` varchar(30) DEFAULT NULL,
  `symbol` varchar(5) DEFAULT NULL,
  `precision` tinyint(4) DEFAULT NULL,
  `thousand_separator` char(1) DEFAULT NULL,
  `decimal_separator` char(1) DEFAULT NULL,
  `name` varchar(150) DEFAULT NULL,
  `isActive` bit(1) NOT NULL DEFAULT b'1',
  `order` int(11) DEFAULT 2,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='default values for the kind of money around the world';

-- Volcando datos para la tabla krece.currency_code: ~37 rows (aproximadamente)
DELETE FROM `currency_code`;
/*!40000 ALTER TABLE `currency_code` DISABLE KEYS */;
INSERT INTO `currency_code` (`code`, `country`, `symbol`, `precision`, `thousand_separator`, `decimal_separator`, `name`, `isActive`, `order`) VALUES
	('AED', NULL, 'DH ', 2, ',', '.', 'United Arab Emirates Dirham', b'1', 2),
	('ARS', NULL, '$', 2, '.', ',', 'Argentine Peso', b'1', 2),
	('AUD', NULL, '$', 2, ',', '.', 'Australian Dollar', b'1', 2),
	('AWG', NULL, 'Afl. ', 2, '', '.', 'Aruban Florin', b'1', 2),
	('BDT', NULL, 'Tk', 2, ',', '.', 'Bangladeshi Taka', b'1', 2),
	('BRL', 'Brasil', 'R$', 2, '.', ',', 'Brazilian Real', b'1', 2),
	('CAD', NULL, 'C$', 2, ',', '.', 'Canadian Dollar', b'1', 2),
	('CNY', NULL, 'RMB ', 2, ',', '.', 'Chinese Renminbi', b'1', 2),
	('COP', 'Colombia', '$', 2, '.', ',', 'Colombian Peso', b'1', 1),
	('DKK', NULL, 'kr ', 2, '.', ',', 'Danish Krone', b'1', 2),
	('EGP', NULL, 'E£', 2, ',', '.', 'Egyptian Pound', b'1', 2),
	('EUR', NULL, '€', 2, '.', ',', 'Euro', b'1', 2),
	('GBP', NULL, '£', 2, ',', '.', 'British Pound', b'1', 2),
	('GTQ', NULL, 'Q', 2, ',', '.', 'Guatemalan Quetzal', b'1', 2),
	('HKR', NULL, 'kn', 2, '.', ',', 'Croatian Kuna', b'1', 2),
	('IDR', NULL, 'Rp', 2, ',', '.', 'Indonesian Rupiah', b'1', 2),
	('ILS', NULL, 'NIS ', 2, ',', '.', 'Israeli Shekel', b'1', 2),
	('INR', NULL, 'Rs. ', 2, ',', '.', 'Indian Rupee', b'1', 2),
	('JPY', NULL, '¥', 0, ',', '.', 'Japanese Yen', b'1', 2),
	('KES', NULL, 'KSh ', 2, ',', '.', 'Kenyan Shilling', b'1', 2),
	('LKR', NULL, 'LKR', 2, ',', '.', 'Sri Lankan Rupee', b'1', 2),
	('MXN', NULL, '$', 2, ',', '.', 'Mexican Peso', b'1', 2),
	('MYR', NULL, 'RM', 2, ',', '.', 'Malaysian Ringgit', b'1', 2),
	('NOK', NULL, 'kr ', 2, '.', ',', 'Norske Kroner', b'1', 2),
	('NZD', NULL, '$', 2, ',', '.', 'New Zealand Dollar', b'1', 2),
	('PHP', NULL, 'P ', 2, ',', '.', 'Philippine Peso', b'1', 2),
	('PKR', NULL, 'Rs ', 0, ',', '.', 'Pakistani Rupee', b'1', 2),
	('PLN', NULL, 'z?', 2, '', ',', 'Polish Zloty', b'1', 2),
	('RWF', NULL, 'RF ', 2, ',', '.', 'Rwandan Franc', b'1', 2),
	('SEK', NULL, 'kr ', 2, '.', ',', 'Swedish Krona', b'1', 2),
	('TRY', NULL, 'TL ', 2, '.', ',', 'Turkish Lira', b'1', 2),
	('TTD', NULL, 'TT$', 2, ',', '.', 'Trinidad and Tobago Dollar', b'1', 2),
	('TZS', NULL, 'TSh ', 2, ',', '.', 'Tanzanian Shilling', b'1', 2),
	('USD', NULL, '$', 2, ',', '.', 'US Dollar', b'1', 1),
	('XCD', NULL, 'EC$', 2, ',', '.', 'East Caribbean Dollar', b'1', 2),
	('XOF', NULL, 'CFA ', 2, ',', '.', 'West African Franc', b'1', 2),
	('ZAR', NULL, 'R', 2, '.', ',', 'South African Rand', b'1', 2);
/*!40000 ALTER TABLE `currency_code` ENABLE KEYS */;

-- Volcando estructura para tabla krece.currency_status
CREATE TABLE IF NOT EXISTS `currency_status` (
  `id` int(11) NOT NULL,
  `description` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.currency_status: ~2 rows (aproximadamente)
DELETE FROM `currency_status`;
/*!40000 ALTER TABLE `currency_status` DISABLE KEYS */;
INSERT INTO `currency_status` (`id`, `description`) VALUES
	(1, 'Activo'),
	(2, 'Eliminado');
/*!40000 ALTER TABLE `currency_status` ENABLE KEYS */;

-- Volcando estructura para tabla krece.debit_note
CREATE TABLE IF NOT EXISTS `debit_note` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL COMMENT 'related with client that will receive the invoice',
  `user_id` int(11) NOT NULL,
  `public_id` int(11) NOT NULL,
  `resolution_id` int(11) NOT NULL COMMENT 'resolution DIAN #',
  `customer_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `observations` text DEFAULT NULL COMMENT 'for customer tracking , just internal',
  `exchange_rate` float DEFAULT NULL,
  `amount_pending_to_apply` float DEFAULT NULL,
  `sub_total` float DEFAULT NULL,
  `total_taxes` float DEFAULT NULL,
  `total_discounts` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `isDeleted` bit(1) DEFAULT b'0',
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_supp_company_id_document_number` (`account_id`,`resolution_id`),
  KEY `FK_debit_note_currency` (`currency_code`),
  KEY `FK_debit_note_customerID` (`customer_id`),
  KEY `FK_debit_note_user` (`user_id`),
  CONSTRAINT `FK_debit_note_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_debit_note_currency` FOREIGN KEY (`currency_code`) REFERENCES `currency_code` (`code`),
  CONSTRAINT `FK_debit_note_customerID` FOREIGN KEY (`customer_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `FK_debit_note_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COMMENT='Header of supplier invoices';

-- Volcando datos para la tabla krece.debit_note: ~3 rows (aproximadamente)
DELETE FROM `debit_note`;
/*!40000 ALTER TABLE `debit_note` DISABLE KEYS */;
INSERT INTO `debit_note` (`id`, `account_id`, `user_id`, `public_id`, `resolution_id`, `customer_id`, `date`, `currency_code`, `observations`, `exchange_rate`, `amount_pending_to_apply`, `sub_total`, `total_taxes`, `total_discounts`, `total`, `isDeleted`, `updated_at`, `created_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, 1, 1, '2017-04-13', 'COP', NULL, NULL, NULL, 300, 0, 0, 300, b'0', '2017-04-13 21:21:57', '2017-04-13 21:21:57', NULL),
	(2, 1, 1, 2, 2, 1, '2017-09-08', 'COP', 'nota debito 5', NULL, NULL, 2000, 0, 0, 2000, b'0', '2017-09-08 13:32:18', '2017-09-08 13:32:18', NULL),
	(3, 1, 1, 3, 3, 1, '2017-09-08', 'COP', 'nota debito 3', NULL, 0, 3456, 656.64, 0, 4112.64, b'0', '2017-09-08 13:36:30', '2017-09-08 13:34:56', NULL),
	(4, 1, 1, 4, 4, 1, '2017-09-26', 'COP', 'asas', NULL, NULL, 2000, 380, 0, 2380, b'0', '2017-09-26 14:11:34', '2017-09-26 14:11:34', NULL);
/*!40000 ALTER TABLE `debit_note` ENABLE KEYS */;

-- Volcando estructura para tabla krece.debit_note_detail
CREATE TABLE IF NOT EXISTS `debit_note_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'header invoice number',
  `debit_note_id` bigint(20) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `unit_price` float NOT NULL,
  `discount` float DEFAULT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `tax_amount` float DEFAULT NULL,
  `total_tax` float DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `total` float NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_debit_note_detail_company` (`user_id`),
  KEY `FK_debit_note_detail_id` (`debit_note_id`),
  KEY `FK_debit_note_detail_tax_id` (`tax_id`),
  KEY `FK_category_id` (`category_id`),
  KEY `FK_debit_note_product` (`product_id`),
  CONSTRAINT `FK_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `FK_debit_note_detail_po` FOREIGN KEY (`debit_note_id`) REFERENCES `debit_note` (`id`),
  CONSTRAINT `FK_debit_note_detail_tax` FOREIGN KEY (`tax_id`) REFERENCES `tax` (`id`),
  CONSTRAINT `FK_debit_note_detail_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_debit_note_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COMMENT='detail of the invoice generated';

-- Volcando datos para la tabla krece.debit_note_detail: ~6 rows (aproximadamente)
DELETE FROM `debit_note_detail`;
/*!40000 ALTER TABLE `debit_note_detail` DISABLE KEYS */;
INSERT INTO `debit_note_detail` (`id`, `debit_note_id`, `user_id`, `category_id`, `product_id`, `name`, `description`, `unit_price`, `discount`, `tax_id`, `tax_amount`, `total_tax`, `quantity`, `total`, `updated_at`, `created_at`) VALUES
	(1, 1, 1, 10, NULL, 'Comisiones y honorarios', NULL, 300, 0, NULL, 0, 0, 1, 300, '2017-04-13 21:21:57', '2017-04-13 21:21:57'),
	(2, 2, 1, 11, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, 1, 0, '2017-09-08 13:32:18', '2017-09-08 13:32:18'),
	(3, 2, 1, 12, NULL, NULL, NULL, 2000, 0, NULL, 0, 0, 1, 2000, '2017-09-08 13:32:18', '2017-09-08 13:32:18'),
	(5, 3, 1, 11, NULL, NULL, 'ssaas', 3456, 0, 1, 19, 656.64, 1, 3456, '2017-09-08 13:36:30', '2017-09-08 13:36:30'),
	(6, 4, 1, 10, NULL, NULL, NULL, 2000, 0, 1, 19, 380, 1, 2000, '2017-09-26 14:11:34', '2017-09-26 14:11:34'),
	(7, 4, 1, 14, NULL, NULL, NULL, 0, 0, NULL, 0, 0, 1, 0, '2017-09-26 14:11:34', '2017-09-26 14:11:34');
/*!40000 ALTER TABLE `debit_note_detail` ENABLE KEYS */;

-- Volcando estructura para tabla krece.documents
CREATE TABLE IF NOT EXISTS `documents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `model_id` int(10) unsigned DEFAULT NULL,
  `model` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `new_filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla krece.documents: ~29 rows (aproximadamente)
DELETE FROM `documents`;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
INSERT INTO `documents` (`id`, `user_id`, `model_id`, `model`, `filename`, `new_filename`, `created_at`, `updated_at`) VALUES
	(13, 1, 24, 'estimate', 'favicon.png', 'public/krece/p5U2XnjWho2oSn3LgWB0hi85mnTum7k0h2g0lqvw.png', '2017-08-23 14:20:25', '2017-08-23 14:20:25'),
	(14, 1, 24, 'estimate', 'formato_de_capacidad_financiera_y_organizacional_0_0.docx', 'public/krece/VZeG15NzVZLri0k6KrS83hN7w2oZKuGTkmmCSn3N.docx', '2017-08-23 14:20:32', '2017-08-23 14:20:32'),
	(15, 1, 24, 'estimate', '02709227MATRICULA MERCANTIL0.pdf', 'public/krece/535ivwWFUHvnitYhaO6qKLBrT88UsGnZyqGlNF20.pdf', '2017-08-23 14:20:37', '2017-08-23 14:20:37'),
	(16, 1, 24, 'estimate', 'Impuestos 2015.zip', 'public/krece/wGvPYgAtQGGP1HJ2L0mVpttzi2FlPVFesBCOaI6Y.zip', '2017-08-23 14:20:47', '2017-08-23 14:20:47'),
	(17, 1, 17, 'estimate', 'Forastero En Tierra Extraña.pdf', 'public/krece/4vt9zMpvNNBibrfo0r7noMMEE2OpJEYKA11sVUJ7.pdf', '2017-08-23 14:21:11', '2017-08-23 14:21:11'),
	(18, 1, 17, 'estimate', 'formato_de_capacidad_financiera_y_organizacional_0_0.docx', 'public/krece/KRKtaMYYlL6azXZVQgT1nnZJxXE5cF5XlFeETiP5.docx', '2017-08-23 14:21:16', '2017-08-23 14:21:16'),
	(19, 1, 17, 'estimate', 'B) CARPE DIEM 7222.pdf', 'public/krece/PGTf7GdpfhyOpeYtULDfvsj9xL1U1LdwLYgjrfMD.pdf', '2017-08-23 14:21:51', '2017-08-23 14:21:51'),
	(20, 1, 1, 'estimate', 'Forastero En Tierra Extraña.pdf', 'public/krece/y6rIqRcrNMj0v8TIHrZoI46otsisyI9zTokMFZBB.pdf', '2017-08-23 14:33:27', '2017-08-23 14:33:27'),
	(21, 1, 23, 'estimate', 'favicon-96x96.png', 'public/krece/v79AexdyzSMsxWnGdaGRj05QfA3wpNFvMDuB9jqa.png', '2017-08-23 14:41:48', '2017-08-23 14:41:48'),
	(22, 1, 2, 'remision', 'Portafolio Servicios tecnológicos - TinnSoft SAS.pdf', 'public/krece/AHh21mNwQHJR7q9mZmXu8aUpCyUWiiHGP0sowgm0.pdf', '2017-08-23 16:08:36', '2017-08-23 16:08:36'),
	(25, 1, 26, 'estimate', 'B) CARPE DIEM 7222.pdf', 'public/krece/RVwyPFT3qGZJwCRfYJ9yfwrzfskxXyvxNQTn8k2j.pdf', '2017-08-28 21:24:26', '2017-08-28 21:24:26'),
	(26, 1, 26, 'estimate', 'B) CARPE DIEM 7222.pdf', 'public/krece/CD3JE4iveza9ochtb2HHMeL2X0X7EZzjGcNCbyY8.pdf', '2017-08-28 21:27:04', '2017-08-28 21:27:04'),
	(28, 1, 3, 'remision', '02709227EXISTENCIA Y REPRESENTACION LEGAL O INSCRIPCION DE DOCUMENTOS REGISTRO MERCANTIL0.pdf', 'public/krece/UbwVwWuFAKJcb5WcrBFKtBVJccdlbAHNN6Q5nX0h.pdf', '2017-08-29 07:28:31', '2017-08-29 07:28:31'),
	(29, 1, 4, 'remision', 'Forastero En Tierra Extraña.pdf', 'public/krece/2Hj421OwouRirFZvCaTJFOhS5khXXacjHuDOFSQa.pdf', '2017-08-29 13:59:28', '2017-08-29 13:59:28'),
	(30, 1, 4, 'remision', 'B) CARPE DIEM 7222.pdf', 'public/krece/XfuFM6yEDs8IG2q2QlMUs2dftes8C6wqQopglJNL.pdf', '2017-08-29 14:00:30', '2017-08-29 14:00:30'),
	(33, 1, 4, 'remision', 'Forastero En Tierra Extraña.pdf', 'public/krece/xHokIVdt6ZQabncJo90wTghg1BK1M1bTcOexHF7T.pdf', '2017-08-29 14:03:00', '2017-08-29 14:03:00'),
	(34, 1, 4, 'remision', 'favicon.png', 'public/krece/RhGYl5n5dGyQvwlSlpqgppzkMa8FRZcdcCdDYrHS.png', '2017-08-29 14:04:00', '2017-08-29 14:04:00'),
	(35, 1, 2, 'credit-note', 'Impuestos 2015.zip', 'public/krece/ZyvZmuoarBoc0DZgdSFOlaYiPniAQlyFoPD50gcb.zip', '2017-08-29 18:21:44', '2017-08-29 18:21:44'),
	(36, 1, 26, 'estimate', 'B) CARPE DIEM 7222.pdf', 'public/krece/925M4JmKaULX6GuTq2glhmL4yWYK9syrLNmhGy8Q.pdf', '2017-09-03 20:17:50', '2017-09-03 20:17:50'),
	(37, 1, 26, 'estimate', 'desprendiblekta2.pdf', 'public/krece/ab2GCHJWo5UoaiEueu0lcYIamq0I0tPMU4C9JzfG.pdf', '2017-09-03 20:17:58', '2017-09-03 20:17:58'),
	(39, 1, 15, 'invoice', 'B) CARPE DIEM 7222.pdf', 'public/krece/OEgXib7z04SeJEmcVsgeANIMyiWPfSW1SSPZO8BW.pdf', '2017-09-07 17:58:18', '2017-09-07 17:58:18'),
	(40, 1, 16, 'invoice', 'desprendiblekta2.pdf', 'public/krece/BCUtCKDqDmA3jIXVHR57EIfGJPPsIitNnRqi4iRF.pdf', '2017-09-07 18:21:42', '2017-09-07 18:21:42'),
	(41, 1, 5, 'bill', 'B) CARPE DIEM 7222.pdf', 'public/krece/ADoRwecBGf9RrjfJmNrpz9An4L3VnUIk94PUon0s.pdf', '2017-09-08 12:47:35', '2017-09-08 12:47:35'),
	(42, 1, 3, 'debit-note', 'desprendiblekta2.pdf', 'public/krece/FaqVFLnjxJ7nYgarBcUNcFVd1KgIP0QVTQIE8ZR3.pdf', '2017-09-08 13:37:04', '2017-09-08 13:37:04'),
	(43, 1, 27, 'estimate', 'IMG_20170908_113159.jpg', 'public/krece/NkRMMhYrbwm9UT8Ifgla1fryl399SS5MvmXSNIRR.jpeg', '2017-09-11 17:42:06', '2017-09-11 17:42:06'),
	(44, 1, 4, 'credit-note', 'IMG_20170913_202006.jpg', 'public/krece/TUK2RLi9trNSHIhgyhA27Z4AHlrwBp5yLIkrf1CJ.jpeg', '2017-09-14 20:56:56', '2017-09-14 20:56:56'),
	(45, 1, 6, 'bill', 'G104M01F01 Plantilla Acuerdo de Confidencialidad Seguridad de la Información V00 UT ControlTech MSPI 2017.output.pdf', 'public/krece/rjN14PmST4YGONGygw5OQFMW3toAZf61kPLILk3j.pdf', '2017-09-26 14:10:12', '2017-09-26 14:10:12'),
	(46, 1, 20, 'invoice', 'Hoja de Vida Fernando Ardila Rodriguez MIT (1).pdf', 'public/krece/NVgMxnHHehq5juWEijBS4I626fiGDT81gdcKpAhn.pdf', '2017-10-02 20:43:42', '2017-10-02 20:43:42'),
	(51, 1, 26, 'invoice', 'Hoja de Vida Fernando Ardila Rodriguez MIT.pdf', 'public/krece/zjVKx4FfGZ93u0YfChDMnE6uc8HTfv1sb7L9y0FS.pdf', '2018-05-16 21:47:33', '2018-05-16 21:47:33'),
	(52, 1, 26, 'invoice', 'TgnC_iudd5ra0iAX_51O0coTIEU4-8mFdgsyws5egPE.html', 'public/krece/7IpvB0spZ0FQL4WSOq53gL8HXitnyMi1bAbtpiyU.txt', '2018-05-16 21:51:27', '2018-05-16 21:51:27'),
	(53, 1, 26, 'invoice', 'form_submissions_20180512.csv', 'public/krece/Yha6VlzcwY81OHHABPVa9zXQ2e46afE0g8N4D89X.txt', '2018-05-16 21:52:29', '2018-05-16 21:52:29'),
	(54, 1, 26, 'invoice', 'Impuestos 2015.zip', 'public/krece/Ov6FeqQDJiwPTfft9qYkr335bckwH7Z2UzD4mNAU.zip', '2018-05-16 21:52:46', '2018-05-16 21:52:46'),
	(55, 1, 26, 'invoice', '02709227EXISTENCIA Y REPRESENTACION LEGAL O INSCRIPCION DE DOCUMENTOS REGISTRO MERCANTIL0.pdf', 'public/krece/XcUYAnLjKnD3g7z9VPv9ejNw3QS2urNHgXfpr1Bo.pdf', '2018-05-16 21:56:22', '2018-05-16 21:56:22'),
	(56, 1, 17, 'invoice', 'Forastero En Tierra Extraña.pdf', 'public/krece/snnsrw34yhP4XEnWwnU3PirBJ3LmIwP3WjS7V6em.pdf', '2018-05-19 09:03:55', '2018-05-19 09:03:55'),
	(57, 1, 33, 'invoice', 'IMG-20180602-WA0002.jpg', 'public/krece/LxgjySReGPte2kJgxPk1FUiSCKX8bZGiN2rW0boP.jpeg', '2018-06-02 21:30:51', '2018-06-02 21:30:51'),
	(58, 1, 35, 'invoice', 'Forastero En Tierra Extraña.pdf', 'public/krece/RGKAzy5xFqyBWQOoReWJhmp03iLUnj1IdPISim1m.pdf', '2018-06-02 23:54:48', '2018-06-02 23:54:48'),
	(59, 1, 32, 'invoice', 'Curriculum Vitae Fernando Ardila MIT EN.pdf', 'public/krece/saPS8ZB5NP2qMt7NZ7s3tLD0d1KuZXU2NroK3uJ1.pdf', '2018-08-15 22:30:30', '2018-08-15 22:30:30'),
	(60, 1, 38, 'invoice', 'Curriculum Vitae Fernando Ardila MIT EN.pdf', 'public/krece/HTwW8vmEyUyP1RnaLEv8yLOm8SkCIXfidVt2MW6p.pdf', '2018-09-09 22:06:21', '2018-09-09 22:06:21');
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;

-- Volcando estructura para tabla krece.estimate
CREATE TABLE IF NOT EXISTS `estimate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `public_id` int(11) DEFAULT NULL,
  `resolution_id` int(11) DEFAULT NULL COMMENT 'Numero definitivo de la cotización',
  `user_id` int(11) DEFAULT NULL,
  `seller_id` int(11) DEFAULT NULL,
  `list_price_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `currency_code` varchar(3) DEFAULT NULL,
  `sub_total` float DEFAULT 0,
  `total_discounts` float DEFAULT 0,
  `total_taxes` float DEFAULT 0,
  `total` float DEFAULT 0,
  `date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `observations` text DEFAULT NULL,
  `exchange_rate` float DEFAULT NULL,
  `isDeleted` bit(1) DEFAULT b'0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_quote_account_id` (`account_id`,`public_id`),
  KEY `FK_estimate_client` (`customer_id`),
  KEY `FK_estimate_currency_code` (`currency_code`),
  KEY `FK_estimate_user` (`user_id`),
  CONSTRAINT `FK_estimate_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_estimate_client` FOREIGN KEY (`customer_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `FK_estimate_currency_code` FOREIGN KEY (`currency_code`) REFERENCES `currency_code` (`code`),
  CONSTRAINT `FK_estimate_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.estimate: ~21 rows (aproximadamente)
DELETE FROM `estimate`;
/*!40000 ALTER TABLE `estimate` DISABLE KEYS */;
INSERT INTO `estimate` (`id`, `account_id`, `public_id`, `resolution_id`, `user_id`, `seller_id`, `list_price_id`, `customer_id`, `currency_code`, `sub_total`, `total_discounts`, `total_taxes`, `total`, `date`, `due_date`, `notes`, `observations`, `exchange_rate`, `isDeleted`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 2, 1, 1, 2, NULL, 1, 1, 'COP', 2000, 0, 0, 2000, '2017-04-12', '2017-05-12', 'asas', NULL, NULL, b'0', '2017-04-12 09:27:34', '2017-08-28 09:13:37', '2017-08-28 09:13:37'),
	(2, 1, 2, 2, 1, NULL, 1, 1, 'COP', 76000, 0, 0, 76000, '2017-04-12', '2017-04-20', 'as', NULL, NULL, b'1', '2017-04-12 21:53:18', '2017-08-19 08:55:23', '2017-08-19 08:55:23'),
	(3, 1, 3, 3, 1, 1, 1, 1, 'COP', 20000, 200, 1102, 20902, '2017-08-18', '2017-09-17', 'notas prueba 1', 'prueba 1', NULL, b'1', '2017-08-18 18:18:55', '2017-08-19 09:01:49', '2017-08-19 09:01:49'),
	(4, 1, 4, 4, 1, 1, 1, 1, 'COP', 2000, 0, 0, 2000, '2017-08-18', '2017-09-17', 'prueba 2', NULL, NULL, b'1', '2017-08-18 18:25:32', '2017-08-19 08:42:47', '2017-08-19 08:42:47'),
	(5, 1, 5, 5, 1, 1, 1, 1, 'COP', 6000, 0, 0, 6000, '2017-08-18', '2017-09-17', 'asas', NULL, NULL, b'1', '2017-08-18 18:27:59', '2017-08-19 08:55:17', '2017-08-19 08:55:17'),
	(6, 1, 6, 6, 1, 1, 1, 1, 'COP', 2000, 0, 0, 2000, '2017-08-18', '2017-09-17', 'asas', 'a', NULL, b'1', '2017-08-18 18:30:16', '2017-08-19 09:02:24', '2017-08-19 09:02:24'),
	(7, 1, 7, 7, 1, 1, 1, 1, 'COP', 6000, 0, 0, 6000, '2017-08-18', '2017-09-17', 'asas', 'as', NULL, b'1', '2017-08-18 18:30:58', '2017-08-19 08:41:59', '2017-08-19 08:41:59'),
	(8, 1, 8, 8, 1, 1, 1, 1, 'COP', 46000, 2860, 3636.6, 46776.6, '2017-08-18', '2017-09-17', 'qewqw', 'preasa', NULL, b'1', '2017-08-18 18:46:54', '2017-08-19 09:02:44', '2017-08-19 09:02:44'),
	(9, 1, 9, 9, 1, 1, 1, 1, 'COP', 6000, 0, 0, 6000, '2017-08-18', '2017-09-17', 'asas', NULL, NULL, b'1', '2017-08-18 18:51:10', '2017-08-19 08:41:26', '2017-08-19 08:41:26'),
	(10, 1, 10, 10, 1, 1, 1, 1, 'COP', 8000, 0, 0, 8000, '2017-08-18', '2017-09-17', 'as', 'as', NULL, b'1', '2017-08-18 18:56:00', '2017-08-19 09:05:05', '2017-08-19 09:05:05'),
	(11, 1, 11, 11, 1, 1, 1, 1, 'COP', 4000, 0, 0, 4000, '2017-08-18', '2017-09-17', 'asa', 'sas', NULL, b'1', '2017-08-18 18:57:25', '2017-08-19 09:05:15', '2017-08-19 09:05:15'),
	(12, 1, 12, 12, 1, 1, 1, 1, 'COP', 2000, 0, 0, 2000, '2017-08-19', '2017-09-18', 'aasas', NULL, NULL, b'0', '2017-08-18 19:18:08', '2017-08-18 19:18:08', NULL),
	(13, 1, 13, 13, 1, 1, 1, 1, 'COP', 6000, 0, 0, 6000, '2017-08-19', '2017-09-18', 'qwqwqw', NULL, NULL, b'1', '2017-08-18 19:19:12', '2017-08-19 08:55:12', '2017-08-19 08:55:12'),
	(14, 1, 14, 14, 1, 1, 1, 1, 'COP', 2000, 0, 0, 2000, '2017-08-19', '2017-09-18', 'asas', NULL, NULL, b'0', '2017-08-18 19:20:53', '2017-08-19 10:02:11', NULL),
	(15, 1, 15, 15, 1, 1, 1, 1, 'COP', 2000, 0, 0, 2000, '2017-08-19', '2017-09-18', 'qwqwqw', 'asas', NULL, b'1', '2017-08-18 19:24:24', '2017-08-19 08:41:46', '2017-08-19 08:41:46'),
	(16, 1, 16, 16, 1, 1, 1, 1, 'COP', 24000, 200, 4180, 27980, '2017-08-19', '2017-09-18', 'asas', NULL, NULL, b'1', '2017-08-18 19:25:55', '2017-08-19 08:40:41', '2017-08-19 08:40:41'),
	(17, 1, 17, 17, 1, 1, 1, 1, 'COP', 30000, 0, 4940, 34940, '2017-08-19', '2017-09-22', 'as', 'asas', NULL, b'0', '2017-08-18 19:35:21', '2017-08-20 07:34:18', NULL),
	(18, 1, 18, 18, 1, 1, 1, 1, 'COP', 6000, 0, 0, 6000, '2017-08-19', '2017-09-18', 'asas', NULL, NULL, b'1', '2017-08-18 19:43:48', '2017-08-19 08:40:37', '2017-08-19 08:40:37'),
	(19, 1, 19, 19, 1, 1, 1, 1, 'COP', 222022, 0, 42184.2, 264206, '2017-08-19', '2017-09-18', 'asas', NULL, NULL, b'1', '2017-08-18 19:44:29', '2017-08-19 08:41:19', '2017-08-19 08:41:19'),
	(20, 1, 20, 20, 1, 1, 1, 1, 'COP', 4000, 0, 0, 4000, '2017-08-19', '2017-09-18', 'asas', 'asas', NULL, b'1', '2017-08-18 19:46:38', '2017-08-19 08:41:12', '2017-08-19 08:41:12'),
	(21, 1, 21, 21, 1, 1, 1, 1, 'COP', 8000, 0, 0, 8000, '2017-08-19', '2017-09-18', 'asasas', NULL, NULL, b'1', '2017-08-18 19:47:22', '2017-08-19 08:41:06', '2017-08-19 08:41:06'),
	(22, 1, 22, 22, 1, 1, 1, 1, 'COP', 6000, 0, 0, 6000, '2017-08-19', '2017-09-18', 'asas', 'as', NULL, b'1', '2017-08-18 19:48:00', '2017-08-19 08:40:23', '2017-08-19 08:40:23'),
	(23, 1, 23, 23, 1, 1, 1, 1, 'COP', 32000, 0, 4940, 36940, '2017-08-20', '2017-08-31', 'clonada de cotización 23', 'asas', NULL, b'0', '2017-08-20 07:47:56', '2017-08-20 07:47:56', NULL),
	(24, 1, 24, 24, 1, 1, 1, 1, 'COP', 34000, 0, 4940, 38940, '2017-08-20', '2017-08-23', 'clon de la # 23', 'asas', NULL, b'0', '2017-08-20 07:48:45', '2017-08-29 14:08:03', NULL),
	(25, 1, 25, 25, 1, 1, 1, 1, 'COP', 6000, 0, 0, 6000, '2017-08-26', '2017-09-25', 'asas', NULL, NULL, b'0', '2017-08-25 21:37:43', '2017-08-25 21:38:36', NULL),
	(26, 1, 26, 26, 1, 1, 1, 1, 'COP', 4000, 0, 0, 4000, '2017-08-27', '2017-09-26', 'asas', NULL, NULL, b'0', '2017-08-27 09:32:43', '2017-08-29 08:40:19', NULL),
	(27, 1, 27, 27, 1, 1, 1, 1, 'COP', 4000, 200, 380, 4180, '2017-09-11', '2017-10-11', 'Cotización desde cell', NULL, NULL, b'0', '2017-09-11 17:41:31', '2017-09-11 17:41:31', NULL),
	(28, 1, 28, 28, 1, 1, 1, 1, 'COP', 2000, 0, 0, 2000, '2017-11-07', '2017-12-07', 'Gbn', NULL, NULL, b'0', '2017-11-06 21:02:10', '2017-11-06 21:02:10', NULL),
	(29, 1, 29, 29, 1, 1, 1, 1, 'COP', 2000, 0, 0, 2000, '2017-11-06', '2017-12-06', 'Vbjj', NULL, NULL, b'0', '2017-11-06 21:02:37', '2017-11-06 21:02:37', NULL),
	(30, 1, 30, 30, 1, 1, 1, 4, 'COP', 35000, 0, 0, 35000, '2017-11-14', '2017-12-14', 'Not as', NULL, NULL, b'0', '2017-11-13 19:59:13', '2017-11-13 19:59:13', NULL);
/*!40000 ALTER TABLE `estimate` ENABLE KEYS */;

-- Volcando estructura para tabla krece.estimate_detail
CREATE TABLE IF NOT EXISTS `estimate_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estimate_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `reference` varchar(50) DEFAULT NULL,
  `unit_price` float NOT NULL,
  `discount` float DEFAULT 0,
  `tax_id` int(11) DEFAULT NULL,
  `tax_amount` float DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `total_tax` float DEFAULT 0,
  `total` float DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_quote_detail_quote_id` (`estimate_id`),
  KEY `FK_quote_detail_company` (`user_id`),
  KEY `FK_quote_detail_item` (`product_id`),
  KEY `FK_quote_detail_tax` (`tax_id`),
  CONSTRAINT `FK_estimate_detail_item` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FK_estimate_detail_remision_id` FOREIGN KEY (`estimate_id`) REFERENCES `estimate` (`id`),
  CONSTRAINT `FK_estimate_detail_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_estimate_tax` FOREIGN KEY (`tax_id`) REFERENCES `tax` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.estimate_detail: ~76 rows (aproximadamente)
DELETE FROM `estimate_detail`;
/*!40000 ALTER TABLE `estimate_detail` DISABLE KEYS */;
INSERT INTO `estimate_detail` (`id`, `estimate_id`, `user_id`, `product_id`, `reference`, `unit_price`, `discount`, `tax_id`, `tax_amount`, `name`, `description`, `quantity`, `total_tax`, `total`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-04-12 09:27:34', '2017-04-12 09:27:34', NULL),
	(8, 2, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-14 16:53:31', '2017-08-14 16:53:31', NULL),
	(9, 2, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-14 16:53:31', '2017-08-14 16:53:31', NULL),
	(10, 2, 1, 1, NULL, 50000, 0, NULL, 0, NULL, NULL, 1, 0, 50000, '2017-08-14 16:53:31', '2017-08-14 16:53:31', NULL),
	(11, 2, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-14 16:53:31', '2017-08-14 16:53:31', NULL),
	(12, 2, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-14 16:53:31', '2017-08-14 16:53:31', NULL),
	(13, 2, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-14 16:53:31', '2017-08-14 16:53:31', NULL),
	(14, 2, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-14 16:53:31', '2017-08-14 16:53:31', NULL),
	(15, 2, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-14 16:53:31', '2017-08-14 16:53:31', NULL),
	(16, 2, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-14 16:53:31', '2017-08-14 16:53:31', NULL),
	(17, 2, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-14 16:53:31', '2017-08-14 16:53:31', NULL),
	(18, 2, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-14 16:53:31', '2017-08-14 16:53:31', NULL),
	(19, 2, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-14 16:53:31', '2017-08-14 16:53:31', NULL),
	(20, 2, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-14 16:53:31', '2017-08-14 16:53:31', NULL),
	(21, 2, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-14 16:53:31', '2017-08-14 16:53:31', NULL),
	(22, 3, 1, 1, NULL, 2000, 0, 2, 19, NULL, 'desc', 2, 760, 4000, '2017-08-18 18:18:56', '2017-08-18 18:18:56', NULL),
	(23, 3, 1, 1, NULL, 2000, 10, 1, 19, NULL, NULL, 1, 342, 1800, '2017-08-18 18:18:56', '2017-08-18 18:18:56', NULL),
	(24, 3, 1, 1, NULL, 2000, 0, 3, 0, NULL, NULL, 3, 0, 6000, '2017-08-18 18:18:56', '2017-08-18 18:18:56', NULL),
	(25, 3, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 4, 0, 8000, '2017-08-18 18:18:56', '2017-08-18 18:18:56', NULL),
	(26, 4, 1, 1, NULL, 2000, 0, NULL, NULL, NULL, NULL, 1, 0, 2000, '2017-08-18 18:25:32', '2017-08-18 18:25:32', NULL),
	(27, 5, 1, 1, NULL, 2000, 0, NULL, NULL, NULL, NULL, 1, 0, 2000, '2017-08-18 18:27:59', '2017-08-18 18:27:59', NULL),
	(28, 5, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-18 18:27:59', '2017-08-18 18:27:59', NULL),
	(29, 5, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-18 18:27:59', '2017-08-18 18:27:59', NULL),
	(30, 6, 1, 1, NULL, 2000, 0, NULL, NULL, NULL, NULL, 1, 0, 2000, '2017-08-18 18:30:16', '2017-08-18 18:30:16', NULL),
	(31, 7, 1, 1, NULL, 2000, 0, NULL, NULL, NULL, NULL, 1, 0, 2000, '2017-08-18 18:30:59', '2017-08-18 18:30:59', NULL),
	(32, 7, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-18 18:30:59', '2017-08-18 18:30:59', NULL),
	(33, 7, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-18 18:30:59', '2017-08-18 18:30:59', NULL),
	(34, 8, 1, 1, NULL, 2000, 12, 1, 19, NULL, NULL, 10, 3344, 17600, '2017-08-18 18:46:54', '2017-08-18 18:46:54', NULL),
	(35, 8, 1, 1, NULL, 2000, 0, NULL, 0, NULL, 'asq1', 12, 0, 24000, '2017-08-18 18:46:54', '2017-08-18 18:46:54', NULL),
	(36, 8, 1, 1, NULL, 2000, 23, 2, 19, NULL, 'asas', 1, 292.6, 1540, '2017-08-18 18:46:54', '2017-08-18 18:46:54', NULL),
	(37, 9, 1, 1, NULL, 2000, 0, NULL, NULL, NULL, NULL, 1, 0, 2000, '2017-08-18 18:51:10', '2017-08-18 18:51:10', NULL),
	(38, 9, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-18 18:51:10', '2017-08-18 18:51:10', NULL),
	(39, 9, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-18 18:51:10', '2017-08-18 18:51:10', NULL),
	(40, 10, 1, 1, NULL, 2000, 0, NULL, NULL, NULL, NULL, 1, 0, 2000, '2017-08-18 18:56:00', '2017-08-18 18:56:00', NULL),
	(41, 10, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-18 18:56:00', '2017-08-18 18:56:00', NULL),
	(42, 10, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-18 18:56:00', '2017-08-18 18:56:00', NULL),
	(43, 10, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-18 18:56:00', '2017-08-18 18:56:00', NULL),
	(44, 11, 1, 1, NULL, 2000, 0, NULL, NULL, NULL, NULL, 1, 0, 2000, '2017-08-18 18:57:25', '2017-08-18 18:57:25', NULL),
	(45, 11, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-18 18:57:25', '2017-08-18 18:57:25', NULL),
	(46, 12, 1, 1, NULL, 2000, 0, NULL, NULL, NULL, NULL, 1, 0, 2000, '2017-08-18 19:18:08', '2017-08-18 19:18:08', NULL),
	(47, 13, 1, 1, NULL, 2000, 0, NULL, NULL, NULL, NULL, 1, 0, 2000, '2017-08-18 19:19:12', '2017-08-18 19:19:12', NULL),
	(48, 13, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-18 19:19:12', '2017-08-18 19:19:12', NULL),
	(49, 13, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-18 19:19:12', '2017-08-18 19:19:12', NULL),
	(51, 15, 1, 1, NULL, 2000, 0, NULL, NULL, NULL, NULL, 1, 0, 2000, '2017-08-18 19:24:24', '2017-08-18 19:24:24', NULL),
	(52, 16, 1, 1, NULL, 2000, 0, 1, 19, NULL, 'qwq', 10, 3800, 20000, '2017-08-18 19:25:55', '2017-08-18 19:25:55', NULL),
	(53, 16, 1, 1, NULL, 2000, 0, 2, 19, NULL, NULL, 1, 380, 2000, '2017-08-18 19:25:55', '2017-08-18 19:25:55', NULL),
	(54, 16, 1, 1, NULL, 2000, 10, 3, 0, NULL, NULL, 1, 0, 1800, '2017-08-18 19:25:55', '2017-08-18 19:25:55', NULL),
	(59, 18, 1, 1, NULL, 2000, 0, NULL, NULL, NULL, NULL, 1, 0, 2000, '2017-08-18 19:43:48', '2017-08-18 19:43:48', NULL),
	(60, 18, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-18 19:43:48', '2017-08-18 19:43:48', NULL),
	(61, 18, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-18 19:43:48', '2017-08-18 19:43:48', NULL),
	(62, 19, 1, 1, NULL, 20002, 0, 1, 19, NULL, NULL, 11, 41804.2, 220022, '2017-08-18 19:44:29', '2017-08-18 19:44:29', NULL),
	(63, 19, 1, 1, NULL, 2000, 0, 2, 19, NULL, NULL, 1, 380, 2000, '2017-08-18 19:44:29', '2017-08-18 19:44:29', NULL),
	(64, 20, 1, 1, NULL, 2000, 0, NULL, NULL, NULL, NULL, 1, 0, 2000, '2017-08-18 19:46:38', '2017-08-18 19:46:38', NULL),
	(65, 20, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-18 19:46:38', '2017-08-18 19:46:38', NULL),
	(66, 21, 1, 1, NULL, 2000, 0, NULL, NULL, NULL, NULL, 1, 0, 2000, '2017-08-18 19:47:22', '2017-08-18 19:47:22', NULL),
	(67, 21, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-18 19:47:23', '2017-08-18 19:47:23', NULL),
	(68, 21, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-18 19:47:23', '2017-08-18 19:47:23', NULL),
	(69, 21, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-18 19:47:23', '2017-08-18 19:47:23', NULL),
	(70, 22, 1, 1, NULL, 2000, 0, NULL, NULL, NULL, NULL, 1, 0, 2000, '2017-08-18 19:48:00', '2017-08-18 19:48:00', NULL),
	(71, 22, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-18 19:48:00', '2017-08-18 19:48:00', NULL),
	(72, 22, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-18 19:48:00', '2017-08-18 19:48:00', NULL),
	(86, 14, 1, 1, NULL, 2000, 0, NULL, NULL, NULL, NULL, 1, 0, 2000, '2017-08-19 10:02:11', '2017-08-19 10:02:11', NULL),
	(94, 17, 1, 1, NULL, 2000, 0, 1, 19, NULL, 'desc1', 13, 4940, 26000, '2017-08-20 07:34:18', '2017-08-20 07:34:18', NULL),
	(95, 17, 1, 1, NULL, 2000, 0, NULL, 0, NULL, 'desc2', 1, 0, 2000, '2017-08-20 07:34:18', '2017-08-20 07:34:18', NULL),
	(96, 17, 1, 1, NULL, 2000, 0, NULL, 0, NULL, 'desc3', 1, 0, 2000, '2017-08-20 07:34:18', '2017-08-20 07:34:18', NULL),
	(97, 23, 1, 1, NULL, 2000, 0, 1, 19, NULL, 'desc1', 13, 4940, 26000, '2017-08-20 07:47:56', '2017-08-20 07:47:56', NULL),
	(98, 23, 1, 1, NULL, 2000, 0, NULL, 0, NULL, 'desc2', 1, 0, 2000, '2017-08-20 07:47:56', '2017-08-20 07:47:56', NULL),
	(99, 23, 1, 1, NULL, 2000, 0, NULL, 0, NULL, 'desc3', 1, 0, 2000, '2017-08-20 07:47:56', '2017-08-20 07:47:56', NULL),
	(100, 23, 1, 1, NULL, 2000, 0, NULL, 0, NULL, 'clone add', 1, 0, 2000, '2017-08-20 07:47:57', '2017-08-20 07:47:57', NULL),
	(118, 25, 1, 1, NULL, 2000, 0, NULL, NULL, NULL, NULL, 1, 0, 2000, '2017-08-25 21:38:36', '2017-08-25 21:38:36', NULL),
	(119, 25, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-25 21:38:36', '2017-08-25 21:38:36', NULL),
	(120, 25, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-08-25 21:38:36', '2017-08-25 21:38:36', NULL),
	(127, 26, 1, 1, NULL, 2000, 0, 3, 0, NULL, NULL, 1, 0, 2000, '2017-08-29 08:40:19', '2017-08-29 08:40:19', NULL),
	(128, 26, 1, 1, NULL, 2000, 0, 3, 0, NULL, NULL, 1, 0, 2000, '2017-08-29 08:40:20', '2017-08-29 08:40:20', NULL),
	(129, 24, 1, 1, NULL, 2000, 0, 1, 19, NULL, 'desc1', 13, 4940, 26000, '2017-08-29 14:08:03', '2017-08-29 14:08:03', NULL),
	(130, 24, 1, 1, NULL, 2000, 0, NULL, 0, NULL, 'desc2', 1, 0, 2000, '2017-08-29 14:08:03', '2017-08-29 14:08:03', NULL),
	(131, 24, 1, 1, NULL, 2000, 0, NULL, 0, NULL, 'desc3', 1, 0, 2000, '2017-08-29 14:08:03', '2017-08-29 14:08:03', NULL),
	(132, 24, 1, 1, NULL, 2000, 0, NULL, 0, NULL, 'clone add', 1, 0, 2000, '2017-08-29 14:08:04', '2017-08-29 14:08:04', NULL),
	(133, 24, 1, 1, NULL, 2000, 0, NULL, 0, NULL, 'clone 2', 1, 0, 2000, '2017-08-29 14:08:04', '2017-08-29 14:08:04', NULL),
	(134, 27, 1, 1, NULL, 2000, 0, 1, 19, NULL, NULL, 1, 380, 2000, '2017-09-11 17:41:31', '2017-09-11 17:41:31', NULL),
	(135, 27, 1, 1, NULL, 2000, 10, NULL, 0, NULL, NULL, 1, 0, 1800, '2017-09-11 17:41:31', '2017-09-11 17:41:31', NULL),
	(136, 28, 1, 1, NULL, 2000, 0, NULL, NULL, NULL, NULL, 1, 0, 2000, '2017-11-06 21:02:11', '2017-11-06 21:02:11', NULL),
	(137, 29, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 0, 2000, '2017-11-06 21:02:37', '2017-11-06 21:02:37', NULL),
	(138, 30, 1, 4, '127ngas', 5000, 0, NULL, NULL, NULL, 'descripción alcancia prueba', 1, 0, 5000, '2017-11-13 19:59:13', '2017-11-13 19:59:13', NULL),
	(139, 30, 1, 3, 'HGAL124', 30000, 0, NULL, 0, NULL, 'esta es una descripción de prueba', 1, 0, 30000, '2017-11-13 19:59:13', '2017-11-13 19:59:13', NULL);
/*!40000 ALTER TABLE `estimate_detail` ENABLE KEYS */;

-- Volcando estructura para tabla krece.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla krece.failed_jobs: ~0 rows (aproximadamente)
DELETE FROM `failed_jobs`;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_sale_order
CREATE TABLE IF NOT EXISTS `invoice_sale_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `public_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL COMMENT 'related with client that will receive the invoice',
  `account_id` int(11) NOT NULL,
  `resolution_id` int(11) unsigned NOT NULL COMMENT 'resolution DIAN #',
  `resolution_id_ref` int(11) unsigned DEFAULT NULL COMMENT 'join with resolution table',
  `customer_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `due_date` date NOT NULL,
  `payment_terms_id` varchar(20) NOT NULL,
  `status_id` int(11) NOT NULL COMMENT 'Status of the invoice that could be open, closed, revoked',
  `notes` text DEFAULT NULL COMMENT 'vissible inf the sale invoice',
  `observations` text DEFAULT NULL COMMENT 'for customer tracking , just internal',
  `seller_id` int(11) DEFAULT NULL,
  `list_price_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL,
  `sub_total` float DEFAULT NULL,
  `total_discounts` float DEFAULT NULL,
  `total_taxes` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `currency_code_multicurrency` varchar(3) DEFAULT NULL,
  `exchange_rate` float DEFAULT NULL,
  `isRecurring` bit(1) NOT NULL DEFAULT b'0',
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_ISS_public_id_account_id` (`public_id`,`account_id`),
  KEY `FK_invoice_sale_currency` (`currency_code`),
  KEY `FK_invoice_sale_customerID` (`customer_id`),
  KEY `FK_invoice_sale_status` (`status_id`),
  KEY `FK_invoice_sale_list_price` (`list_price_id`),
  KEY `FK_invocie_sale_account` (`account_id`),
  KEY `FK_invoice_sale_seller` (`seller_id`),
  KEY `FK_invoice_sale_user` (`user_id`),
  KEY `FK_invoice_sale_category` (`category_id`),
  CONSTRAINT `FK_invocie_sale_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_invoice_sale_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `FK_invoice_sale_currency` FOREIGN KEY (`currency_code`) REFERENCES `currency_code` (`code`),
  CONSTRAINT `FK_invoice_sale_customerID` FOREIGN KEY (`customer_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `FK_invoice_sale_listprice` FOREIGN KEY (`list_price_id`) REFERENCES `list_price` (`id`),
  CONSTRAINT `FK_invoice_sale_seller` FOREIGN KEY (`seller_id`) REFERENCES `seller` (`id`),
  CONSTRAINT `FK_invoice_sale_status` FOREIGN KEY (`status_id`) REFERENCES `invoice_sale_order_status` (`id`),
  CONSTRAINT `FK_invoice_sale_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1 COMMENT='Header of sale invoices';

-- Volcando datos para la tabla krece.invoice_sale_order: ~37 rows (aproximadamente)
DELETE FROM `invoice_sale_order`;
/*!40000 ALTER TABLE `invoice_sale_order` DISABLE KEYS */;
INSERT INTO `invoice_sale_order` (`id`, `public_id`, `user_id`, `account_id`, `resolution_id`, `resolution_id_ref`, `customer_id`, `date`, `due_date`, `payment_terms_id`, `status_id`, `notes`, `observations`, `seller_id`, `list_price_id`, `category_id`, `currency_code`, `sub_total`, `total_discounts`, `total_taxes`, `total`, `currency_code_multicurrency`, `exchange_rate`, `isRecurring`, `isDeleted`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, 1, NULL, 1, '2017-04-12', '2017-04-12', '1', 2, 'notas', NULL, NULL, 1, 7, 'COP', 2000, 0, 0, 2000, NULL, NULL, b'0', b'0', '2017-04-12 09:38:37', '2018-06-01 20:57:05', NULL),
	(2, 2, 1, 1, 2, NULL, 1, '2017-04-12', '2017-04-12', '2', 2, 'asas', NULL, NULL, 1, 7, 'COP', 2000, 0, 0, 2000, NULL, NULL, b'0', b'0', '2017-04-12 21:54:42', '2018-06-01 20:57:06', NULL),
	(3, 3, 1, 1, 3, NULL, 1, '2017-04-18', '2017-04-18', '1', 2, 'asas', NULL, NULL, 1, 7, 'COP', 2000, 0, 0, 2000, NULL, NULL, b'0', b'0', '2017-04-18 19:21:02', '2018-06-01 20:57:07', NULL),
	(4, 4, 1, 1, 4, NULL, 1, '2017-04-18', '2017-05-18', '1', 2, 'asas', NULL, NULL, 1, 7, 'COP', 2000, 0, 0, 2000, NULL, NULL, b'0', b'0', '2017-04-18 19:21:14', '2018-06-01 20:57:08', NULL),
	(5, 5, 1, 1, 5, NULL, 1, '2017-04-18', '2017-05-18', '1', 2, 'asas', NULL, NULL, 1, 7, 'COP', 2000, 0, 0, 2000, NULL, NULL, b'0', b'0', '2017-04-18 19:21:25', '2018-06-01 20:57:08', NULL),
	(6, 6, 1, 1, 6, NULL, 1, '2017-04-18', '2017-05-18', '1', 2, 'asas', NULL, NULL, 1, 7, 'COP', 2000, 0, 0, 2000, NULL, NULL, b'0', b'0', '2017-04-18 19:21:34', '2018-06-01 20:57:09', NULL),
	(7, 7, 1, 1, 7, NULL, 1, '2017-04-18', '2017-05-18', '1', 1, 'assa', NULL, NULL, 1, 7, 'COP', 2000, 0, 0, 2000, NULL, NULL, b'0', b'0', '2017-04-18 19:21:44', '2017-04-18 19:21:44', NULL),
	(8, 8, 1, 1, 8, NULL, 1, '2017-04-18', '2017-05-18', '1', 1, 'asas', NULL, NULL, 1, 7, 'COP', 2000, 0, 0, 2000, NULL, NULL, b'0', b'0', '2017-04-18 19:21:55', '2017-04-18 19:21:55', NULL),
	(9, 9, 1, 1, 9, NULL, 1, '2017-04-18', '2017-05-18', '1', 1, 'asas', NULL, NULL, 1, 7, 'COP', 2000, 0, 0, 2000, NULL, NULL, b'0', b'0', '2017-04-18 19:22:05', '2017-04-18 19:22:05', NULL),
	(10, 10, 1, 1, 10, NULL, 1, '2017-04-18', '2017-05-18', '1', 1, 'asas', NULL, NULL, 1, 7, 'COP', 2000, 0, 0, 2000, NULL, NULL, b'0', b'0', '2017-04-18 19:22:14', '2017-04-18 19:22:14', NULL),
	(11, 11, 1, 1, 11, NULL, 1, '2017-04-18', '2017-05-18', '1', 1, 'asas', NULL, NULL, 1, 7, 'COP', 4000, 0, 0, 4000, NULL, NULL, b'0', b'0', '2017-04-18 19:22:25', '2017-04-18 19:22:25', NULL),
	(12, 12, 1, 1, 12, NULL, 1, '2017-05-10', '2017-05-10', '1', 1, 'asasas', NULL, NULL, 1, 7, 'COP', 2000, 0, 0, 2000, NULL, NULL, b'0', b'0', '2017-05-10 09:26:43', '2017-05-10 09:26:43', NULL),
	(13, 13, 1, 1, 13, 1, 1, '2017-07-12', '2017-07-12', '1', 2, 'asa', NULL, NULL, 1, 7, 'COP', 2000, 0, 0, 2000, NULL, NULL, b'0', b'0', '2017-07-12 14:35:15', '2018-06-01 20:57:12', NULL),
	(14, 14, 1, 1, 14, 1, 1, '2017-07-12', '2017-07-12', '1', 1, 'as', 'as', NULL, 1, 7, 'COP', 4000, 0, 0, 4000, NULL, NULL, b'0', b'0', '2017-07-12 15:43:11', '2017-09-14 20:34:46', NULL),
	(15, 15, 1, 1, 15, 1, 1, '2017-09-07', '2017-09-07', '2', 1, 'asasasas', NULL, 1, 1, 7, 'COP', 34567, 0, 0, 34567, NULL, NULL, b'0', b'1', '2017-09-07 16:56:21', '2018-06-02 20:34:54', '2018-06-02 20:34:54'),
	(16, 16, 1, 1, 16, 1, 1, '2017-09-07', '2017-09-07', '2', 1, 'asas', 'asas', 1, 1, 7, 'COP', 2514000, 3364.03, 471200, 2981840, NULL, NULL, b'0', b'0', '2017-09-07 18:20:38', '2017-09-14 20:34:42', NULL),
	(17, 17, 1, 1, 17, 1, 1, '2017-09-07', '2017-10-07', '2', 1, 'clon de factura 16', 'asas', 1, 1, 7, 'COP', 2516000, 3364.03, 471200, 2983840, NULL, NULL, b'0', b'0', '2017-09-07 18:47:58', '2017-09-07 18:47:58', NULL),
	(18, 18, 1, 1, 18, 1, 1, '2017-09-07', '2017-09-07', '2', 1, 'asas', NULL, 1, 1, 7, 'COP', 2000, 0, 0, 2000, NULL, NULL, b'0', b'0', '2017-09-07 18:50:31', '2018-05-06 20:48:20', NULL),
	(19, 19, 1, 1, 19, 1, 1, '2017-09-07', '2017-10-07', '2', 2, 'clon de factyra 18', NULL, 1, 1, 7, 'COP', 4000, 0, 0, 4000, NULL, NULL, b'0', b'0', '2017-09-07 18:50:53', '2018-06-01 20:58:29', NULL),
	(20, 20, 1, 1, 20, 1, 1, '2017-09-19', '2017-09-19', '1', 1, 'asas', NULL, 1, 1, 7, 'COP', 4000, 0, 0, 4000, NULL, NULL, b'0', b'1', '2017-09-18 21:39:00', '2018-06-02 20:34:44', '2018-06-02 20:34:44'),
	(21, 21, 1, 1, 21, 1, 1, '2017-10-14', '2017-10-14', '1', 1, 'notas', NULL, 1, 1, 7, 'COP', 4000, 0, 0, 4000, NULL, NULL, b'0', b'1', '2017-10-14 11:51:12', '2018-06-02 20:34:28', '2018-06-02 20:34:28'),
	(22, 22, 1, 1, 22, 1, 1, '2017-11-06', '2017-11-06', '2', 2, 'Notas', NULL, 1, 1, 7, 'COP', 2000, 0, 0, 2000, NULL, NULL, b'0', b'0', '2017-11-06 20:56:23', '2018-06-01 21:00:02', NULL),
	(23, 23, 1, 1, 23, 1, 1, '2017-11-07', '2017-11-07', '1', 2, 'Gdgh', NULL, 1, 1, 7, 'COP', 316000, 0, 0, 316000, NULL, NULL, b'0', b'0', '2017-11-06 20:58:02', '2018-06-01 20:59:36', NULL),
	(24, 24, 1, 1, 24, 1, 1, '2017-11-14', '2017-11-22', '3', 2, 'No así', NULL, 1, 1, 7, 'COP', 32000, 0, 0, 32000, NULL, NULL, b'0', b'0', '2017-11-13 19:55:06', '2018-06-01 20:56:52', NULL),
	(25, 25, 1, 1, 25, 1, 1, '2017-11-14', '2017-11-22', '3', 1, 'jghgsuaksijsa', NULL, 1, 1, 7, 'COP', 37000, 0, 0, 37000, NULL, NULL, b'0', b'0', '2017-11-13 20:23:37', '2018-06-01 20:59:26', NULL),
	(26, 26, 1, 1, 26, 1, 1, '2017-12-30', '2017-12-30', '2', 1, 'asas', NULL, 1, 1, 7, 'COP', 9000, 0, 0, 9000, NULL, NULL, b'0', b'0', '2017-12-30 13:05:05', '2018-06-01 21:04:47', NULL),
	(27, 27, 1, 1, 27, 1, 1, '2018-06-03', '2018-06-11', '3', 1, 'asas', NULL, 1, 1, 7, 'COP', 5000, 0, 0, 5000, NULL, NULL, b'0', b'0', '2018-06-02 21:08:57', '2018-06-02 21:08:57', NULL),
	(28, 28, 1, 1, 28, 1, 1, '2018-06-03', '2018-06-18', '4', 1, 'asas', NULL, 1, 1, 7, 'COP', 35000, 0, 0, 35000, NULL, NULL, b'0', b'0', '2018-06-02 21:10:07', '2018-06-02 21:10:07', NULL),
	(29, 29, 1, 1, 29, 1, 2, '2018-06-03', '2018-06-11', '3', 1, 'asqw', 'saas', 1, 1, 7, 'COP', 5000, 0, 0, 5000, NULL, NULL, b'0', b'0', '2018-06-02 21:10:36', '2018-06-02 21:10:36', NULL),
	(30, 30, 1, 1, 30, 1, 1, '2018-06-03', '2018-06-03', '1', 1, 'asas', 'as', 1, 1, 7, 'COP', 5000, 0, 0, 5000, NULL, NULL, b'0', b'0', '2018-06-02 21:13:06', '2018-06-02 21:13:06', NULL),
	(31, 31, 1, 1, 31, 1, 2, '2018-06-03', '2018-07-04', '5', 1, 'as', NULL, 1, 1, 7, 'COP', 5000, 0, 0, 5000, NULL, NULL, b'0', b'0', '2018-06-02 21:14:46', '2018-06-02 21:14:46', NULL),
	(32, 32, 1, 1, 32, 1, 5, '2018-06-03', '2018-06-18', '4', 1, 'asas', NULL, 1, 1, 7, 'COP', 267879, 0, 0, 267879, NULL, NULL, b'0', b'0', '2018-06-02 21:16:30', '2018-08-15 22:31:49', NULL),
	(33, 33, 1, 1, 33, 1, 2, '2018-06-03', '2018-06-18', '4', 1, 'asas', 'pruebaaaaaaaaaa', 1, 1, 7, 'COP', 69000, 0, 1330, 70330, NULL, NULL, b'0', b'0', '2018-06-02 21:19:10', '2018-06-02 21:20:22', NULL),
	(34, 34, 1, 1, 34, 1, 2, '2018-06-03', '2018-06-03', '1', 2, 'Test', NULL, 1, 1, 7, 'COP', 35000, 2000, 855, 33855, NULL, NULL, b'0', b'0', '2018-06-02 23:11:23', '2018-06-02 23:51:15', NULL),
	(35, 35, 1, 1, 35, 1, 4, '2018-06-03', '2018-06-11', '3', 1, 'Ggv', NULL, 1, 1, 7, 'COP', 2000, 0, 0, 2000, NULL, NULL, b'0', b'1', '2018-06-02 23:22:13', '2018-06-03 09:45:44', '2018-06-03 09:45:44'),
	(36, 36, 1, 1, 36, 1, 2, '2018-06-04', '2018-06-19', '4', 2, 'asas', 'as', 1, 1, 7, 'COP', 5000, 0, 0, 5000, NULL, NULL, b'0', b'0', '2018-06-03 20:01:25', '2018-06-04 13:44:59', NULL),
	(37, 37, 1, 1, 37, 1, 1, '2018-06-04', '2018-06-12', '3', 1, 'asas', NULL, 1, 1, 7, 'COP', 64000, 3000, 6080, 67080, NULL, NULL, b'0', b'0', '2018-06-03 22:02:32', '2018-06-03 22:02:53', NULL),
	(38, 38, 1, 1, 38, 1, 1, '2018-06-05', '2018-06-13', '3', 1, 'pruebas', NULL, 1, 1, 7, 'COP', 35000, 0, 0, 35000, NULL, NULL, b'0', b'0', '2018-06-04 19:11:12', '2018-10-23 21:53:37', NULL);
/*!40000 ALTER TABLE `invoice_sale_order` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_sale_order_detail
CREATE TABLE IF NOT EXISTS `invoice_sale_order_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'header invoice number',
  `invoice_sale_order_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `product_id` int(10) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `reference` varchar(50) DEFAULT NULL,
  `unit_price` float NOT NULL,
  `discount` float DEFAULT NULL,
  `tax_amount` float DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `total` float DEFAULT NULL,
  `total_tax` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `FK_ISOI_invoice_sale_order` (`invoice_sale_order_id`),
  KEY `FK_ISOI_item` (`product_id`),
  KEY `FK_ISOI_company` (`user_id`),
  KEY `FK_ISOI_tax` (`tax_id`),
  CONSTRAINT `FK_ISOI_company` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_ISOI_invoice_sale_order` FOREIGN KEY (`invoice_sale_order_id`) REFERENCES `invoice_sale_order` (`id`),
  CONSTRAINT `FK_ISOI_item` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FK_ISOI_tax` FOREIGN KEY (`tax_id`) REFERENCES `tax` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=latin1 COMMENT='detail of the invoice generated';

-- Volcando datos para la tabla krece.invoice_sale_order_detail: ~62 rows (aproximadamente)
DELETE FROM `invoice_sale_order_detail`;
/*!40000 ALTER TABLE `invoice_sale_order_detail` DISABLE KEYS */;
INSERT INTO `invoice_sale_order_detail` (`id`, `invoice_sale_order_id`, `user_id`, `tax_id`, `product_id`, `name`, `description`, `reference`, `unit_price`, `discount`, `tax_amount`, `quantity`, `total`, `total_tax`, `created_at`, `updated_at`) VALUES
	(1, 1, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, 0, 1, 2000, 0, '2017-04-12 09:38:37', '2017-04-12 09:38:37'),
	(2, 2, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, 0, 1, 2000, 0, '2017-04-12 21:54:42', '2017-04-12 21:54:42'),
	(3, 3, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, 0, 1, 2000, 0, '2017-04-18 19:21:02', '2017-04-18 19:21:02'),
	(4, 4, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, 0, 1, 2000, 0, '2017-04-18 19:21:14', '2017-04-18 19:21:14'),
	(5, 5, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, 0, 1, 2000, 0, '2017-04-18 19:21:25', '2017-04-18 19:21:25'),
	(6, 6, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, 0, 1, 2000, 0, '2017-04-18 19:21:34', '2017-04-18 19:21:34'),
	(7, 7, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, 0, 1, 2000, 0, '2017-04-18 19:21:44', '2017-04-18 19:21:44'),
	(8, 8, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, 0, 1, 2000, 0, '2017-04-18 19:21:55', '2017-04-18 19:21:55'),
	(9, 9, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, 0, 1, 2000, 0, '2017-04-18 19:22:05', '2017-04-18 19:22:05'),
	(10, 10, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, 0, 1, 2000, 0, '2017-04-18 19:22:14', '2017-04-18 19:22:14'),
	(11, 11, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, 0, 1, 2000, 0, '2017-04-18 19:22:27', '2017-04-18 19:22:27'),
	(12, 11, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, 0, 1, 2000, 0, '2017-04-18 19:22:27', '2017-04-18 19:22:27'),
	(13, 12, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, 0, 1, 2000, 0, '2017-05-10 09:26:43', '2017-05-10 09:26:43'),
	(16, 13, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, 0, 1, 2000, 0, '2017-07-12 14:45:48', '2017-07-12 14:45:48'),
	(17, 14, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, 0, 1, 2000, 0, '2017-07-12 15:43:11', '2017-07-12 15:43:11'),
	(18, 14, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, 0, 1, 2000, 0, '2017-07-12 15:43:11', '2017-07-12 15:43:11'),
	(22, 15, 1, NULL, 1, NULL, NULL, NULL, 34567, 0, NULL, 1, 34567, 0, '2017-09-07 18:01:50', '2017-09-07 18:01:50'),
	(27, 16, 1, NULL, 1, NULL, 'producto 1', NULL, 2000, 10, NULL, 16, 28800, 0, '2017-09-07 18:22:19', '2017-09-07 18:22:19'),
	(28, 16, 1, 1, 1, NULL, 'prod 2', NULL, 2434000, 0, 19, 1, 2434000, 462460, '2017-09-07 18:22:19', '2017-09-07 18:22:19'),
	(29, 16, 1, 2, 1, NULL, 'prod 3', NULL, 2000, 0, 19, 23, 46000, 8740, '2017-09-07 18:22:19', '2017-09-07 18:22:19'),
	(30, 16, 1, 3, 1, NULL, 'prod 4', NULL, 2000.34, 8.2, 0, 1, 1836.31, 0, '2017-09-07 18:22:19', '2017-09-07 18:22:19'),
	(31, 17, 1, NULL, 1, NULL, 'producto 1', NULL, 2000, 10, NULL, 16, 28800, 0, '2017-09-07 18:47:58', '2017-09-07 18:47:58'),
	(32, 17, 1, 1, 1, NULL, 'prod 2', NULL, 2434000, 0, 19, 1, 2434000, 462460, '2017-09-07 18:47:58', '2017-09-07 18:47:58'),
	(33, 17, 1, 2, 1, NULL, 'prod 3', NULL, 2000, 0, 19, 23, 46000, 8740, '2017-09-07 18:47:58', '2017-09-07 18:47:58'),
	(34, 17, 1, 3, 1, NULL, 'prod 4', NULL, 2000.34, 8.2, 0, 1, 1836.31, 0, '2017-09-07 18:47:58', '2017-09-07 18:47:58'),
	(35, 17, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, 0, 1, 2000, 0, '2017-09-07 18:47:58', '2017-09-07 18:47:58'),
	(36, 18, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, NULL, 1, 2000, 0, '2017-09-07 18:50:31', '2017-09-07 18:50:31'),
	(37, 19, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, NULL, 1, 2000, 0, '2017-09-07 18:50:53', '2017-09-07 18:50:53'),
	(38, 19, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, 0, 1, 2000, 0, '2017-09-07 18:50:53', '2017-09-07 18:50:53'),
	(39, 20, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, NULL, 1, 2000, 0, '2017-09-18 21:39:00', '2017-09-18 21:39:00'),
	(40, 20, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, 0, 1, 2000, 0, '2017-09-18 21:39:00', '2017-09-18 21:39:00'),
	(41, 21, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, NULL, 1, 2000, 0, '2017-10-14 11:51:12', '2017-10-14 11:51:12'),
	(42, 21, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, 0, 1, 2000, 0, '2017-10-14 11:51:12', '2017-10-14 11:51:12'),
	(43, 22, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, 0, 1, 2000, 0, '2017-11-06 20:56:23', '2017-11-06 20:56:23'),
	(44, 23, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, NULL, 158, 316000, 0, '2017-11-06 20:58:02', '2017-11-06 20:58:02'),
	(47, 24, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, NULL, 1, 2000, 0, '2017-11-13 19:56:18', '2017-11-13 19:56:18'),
	(48, 24, 1, NULL, 3, NULL, 'esta es una descripción de prueba', 'HGAL124', 30000, 0, 0, 1, 30000, 0, '2017-11-13 19:56:18', '2017-11-13 19:56:18'),
	(49, 25, 1, NULL, 4, NULL, 'descripción alcancia prueba', '127ngas', 5000, 0, NULL, 1, 5000, 0, '2017-11-13 20:23:37', '2017-11-13 20:23:37'),
	(50, 25, 1, NULL, 3, NULL, 'esta es una descripción de prueba', 'HGAL124', 30000, 0, 0, 1, 30000, 0, '2017-11-13 20:23:37', '2017-11-13 20:23:37'),
	(51, 25, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, 0, 1, 2000, 0, '2017-11-13 20:23:37', '2017-11-13 20:23:37'),
	(52, 26, 1, NULL, 4, NULL, 'descripción alcancia prueba', '127ngas', 5000, 0, NULL, 1, 5000, 0, '2017-12-30 13:05:05', '2017-12-30 13:05:05'),
	(53, 26, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, 0, 1, 2000, 0, '2017-12-30 13:05:05', '2017-12-30 13:05:05'),
	(54, 26, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, 0, 1, 2000, 0, '2017-12-30 13:05:05', '2017-12-30 13:05:05'),
	(55, 27, 1, NULL, 4, NULL, 'descripción alcancia prueba', '127ngas', 5000, 0, NULL, 1, 5000, 0, '2018-06-02 21:08:58', '2018-06-02 21:08:58'),
	(56, 28, 1, NULL, 4, NULL, 'descripción alcancia prueba', '127ngas', 5000, 0, NULL, 1, 5000, 0, '2018-06-02 21:10:08', '2018-06-02 21:10:08'),
	(57, 28, 1, NULL, 3, NULL, 'esta es una descripción de prueba', 'HGAL124', 30000, 0, 0, 1, 30000, 0, '2018-06-02 21:10:08', '2018-06-02 21:10:08'),
	(58, 29, 1, NULL, 4, NULL, 'descripción alcancia prueba', '127ngas', 5000, 0, NULL, 1, 5000, 0, '2018-06-02 21:10:36', '2018-06-02 21:10:36'),
	(59, 30, 1, NULL, 4, NULL, 'descripción alcancia prueba', '127ngas', 5000, 0, NULL, 1, 5000, 0, '2018-06-02 21:13:06', '2018-06-02 21:13:06'),
	(60, 31, 1, NULL, 4, NULL, 'descripción alcancia prueba', '127ngas', 5000, 0, NULL, 1, 5000, 0, '2018-06-02 21:14:46', '2018-06-02 21:14:46'),
	(66, 33, 1, 1, 4, NULL, 'descripción alcancia prueba', '127ngas', 5000, 0, 19, 1, 5000, 950, '2018-06-02 21:20:22', '2018-06-02 21:20:22'),
	(67, 33, 1, 2, 1, NULL, NULL, NULL, 2000, 0, 19, 1, 2000, 380, '2018-06-02 21:20:22', '2018-06-02 21:20:22'),
	(68, 33, 1, 3, 3, NULL, 'esta es una descripción de prueba', 'HGAL124', 30000, 0, 0, 1, 30000, 0, '2018-06-02 21:20:22', '2018-06-02 21:20:22'),
	(69, 33, 1, NULL, 3, NULL, 'esta es una descripción de prueba', 'HGAL124', 30000, 0, 0, 1, 30000, 0, '2018-06-02 21:20:22', '2018-06-02 21:20:22'),
	(70, 33, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, 0, 1, 2000, 0, '2018-06-02 21:20:22', '2018-06-02 21:20:22'),
	(73, 34, 1, 2, 4, NULL, 'descripción alcancia prueba', '127ngas', 5000, 10, 19, 1, 4500, 855, '2018-06-02 23:15:57', '2018-06-02 23:15:57'),
	(74, 34, 1, NULL, 3, NULL, 'esta es una descripción de prueba', 'HGAL124', 30000, 5, 0, 1, 28500, 0, '2018-06-02 23:15:57', '2018-06-02 23:15:57'),
	(75, 35, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, NULL, 1, 2000, 0, '2018-06-02 23:22:14', '2018-06-02 23:22:14'),
	(76, 36, 1, NULL, 4, NULL, 'descripción alcancia prueba', '127ngas', 5000, 0, NULL, 1, 5000, 0, '2018-06-03 20:01:25', '2018-06-03 20:01:25'),
	(79, 37, 1, 1, 1, NULL, NULL, NULL, 2000, 0, 19, 1, 2000, 380, '2018-06-03 22:02:54', '2018-06-03 22:02:54'),
	(80, 37, 1, NULL, 3, NULL, 'esta es una descripción de prueba', 'HGAL124', 30000, 10, 0, 1, 27000, 0, '2018-06-03 22:02:54', '2018-06-03 22:02:54'),
	(81, 37, 1, 2, 3, NULL, 'esta es una descripción de prueba', 'HGAL124', 30000, 0, 19, 1, 30000, 5700, '2018-06-03 22:02:54', '2018-06-03 22:02:54'),
	(82, 37, 1, NULL, 1, NULL, NULL, NULL, 2000, 0, 0, 1, 2000, 0, '2018-06-03 22:02:54', '2018-06-03 22:02:54'),
	(83, 38, 1, NULL, 4, NULL, 'descripción alcancia prueba', '127ngas', 5000, 0, NULL, 1, 5000, 0, '2018-06-04 19:11:12', '2018-06-04 19:11:12'),
	(84, 38, 1, NULL, 3, NULL, 'esta es una descripción de prueba', 'HGAL124', 30000, 0, 0, 1, 30000, 0, '2018-06-04 19:11:12', '2018-06-04 19:11:12'),
	(85, 32, 1, NULL, 5, NULL, 'computador de escritorio', 'REF1234', 20000, 0, NULL, 1, 20000, 0, '2018-08-15 22:31:49', '2018-08-15 22:31:49'),
	(86, 32, 1, NULL, 7, NULL, NULL, 'as', 123312, 0, 0, 1, 123312, 0, '2018-08-15 22:31:49', '2018-08-15 22:31:49'),
	(87, 32, 1, NULL, 9, NULL, NULL, 'XSVC', 124567, 0, 0, 1, 124567, 0, '2018-08-15 22:31:49', '2018-08-15 22:31:49');
/*!40000 ALTER TABLE `invoice_sale_order_detail` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_sale_order_status
CREATE TABLE IF NOT EXISTS `invoice_sale_order_status` (
  `id` int(11) NOT NULL,
  `description` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.invoice_sale_order_status: ~7 rows (aproximadamente)
DELETE FROM `invoice_sale_order_status`;
/*!40000 ALTER TABLE `invoice_sale_order_status` DISABLE KEYS */;
INSERT INTO `invoice_sale_order_status` (`id`, `description`) VALUES
	(1, 'Abierta'),
	(2, 'Anulada'),
	(3, 'Aprobada'),
	(4, 'Pagada'),
	(5, 'Borrador'),
	(6, 'Cerrada'),
	(7, 'Enviada');
/*!40000 ALTER TABLE `invoice_sale_order_status` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_withholding_tax
CREATE TABLE IF NOT EXISTS `invoice_withholding_tax` (
  `withholding_tax_values_id` int(11) NOT NULL,
  `invoice_id` bigint(20) NOT NULL COMMENT 'contain sale e and supplier orders',
  `invoice_type_id` tinyint(4) NOT NULL,
  KEY `FK_iwt_tax_values` (`withholding_tax_values_id`),
  KEY `FK_iwt_invoice_type` (`invoice_type_id`),
  CONSTRAINT `FK_iwt_invoice_type` FOREIGN KEY (`invoice_type_id`) REFERENCES `todelete_invoice_type` (`id`),
  CONSTRAINT `FK_iwt_tax_values` FOREIGN KEY (`withholding_tax_values_id`) REFERENCES `invoice_withholding_tax_values` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='set the join between the with holding tax and the invoices tables (that could be ingresos and egresos)';

-- Volcando datos para la tabla krece.invoice_withholding_tax: ~0 rows (aproximadamente)
DELETE FROM `invoice_withholding_tax`;
/*!40000 ALTER TABLE `invoice_withholding_tax` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_withholding_tax` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_withholding_tax_values
CREATE TABLE IF NOT EXISTS `invoice_withholding_tax_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `public_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `withholding_tax_id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `amount` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_iwt_withholding_tax` (`withholding_tax_id`),
  KEY `FK_iwt_account` (`account_id`),
  KEY `FK_iwt_user` (`user_id`),
  CONSTRAINT `FK_iwt_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_iwt_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_iwt_withholding_tax` FOREIGN KEY (`withholding_tax_id`) REFERENCES `retention` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.invoice_withholding_tax_values: ~0 rows (aproximadamente)
DELETE FROM `invoice_withholding_tax_values`;
/*!40000 ALTER TABLE `invoice_withholding_tax_values` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_withholding_tax_values` ENABLE KEYS */;

-- Volcando estructura para tabla krece.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla krece.jobs: ~0 rows (aproximadamente)
DELETE FROM `jobs`;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;

-- Volcando estructura para tabla krece.list_price
CREATE TABLE IF NOT EXISTS `list_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `public_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(100) NOT NULL DEFAULT '0',
  `type_id` tinyint(4) NOT NULL DEFAULT 0,
  `value` float NOT NULL DEFAULT 0,
  `isDefault` bit(1) NOT NULL DEFAULT b'0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `isEnabled` bit(1) NOT NULL DEFAULT b'1',
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_list_price_company_id_name` (`account_id`,`public_id`),
  KEY `FK_list_price_type` (`type_id`),
  KEY `FK_list_price_user` (`user_id`),
  CONSTRAINT `FK_list_price_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_list_price_type` FOREIGN KEY (`type_id`) REFERENCES `list_price_type` (`id`),
  CONSTRAINT `FK_list_price_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COMMENT='Store the list price information';

-- Volcando datos para la tabla krece.list_price: ~0 rows (aproximadamente)
DELETE FROM `list_price`;
/*!40000 ALTER TABLE `list_price` DISABLE KEYS */;
INSERT INTO `list_price` (`id`, `account_id`, `user_id`, `public_id`, `name`, `type_id`, `value`, `isDefault`, `created_at`, `updated_at`, `deleted_at`, `isEnabled`, `isDeleted`) VALUES
	(1, 1, 1, 1, 'General', 2, 0, b'1', '2017-04-12 09:26:16', '2017-04-12 09:26:16', NULL, b'1', b'0'),
	(2, 2, 2, 1, 'General', 2, 0, b'1', '2017-08-06 23:23:32', '2017-08-06 23:23:32', NULL, b'1', b'0');
/*!40000 ALTER TABLE `list_price` ENABLE KEYS */;

-- Volcando estructura para tabla krece.list_price_type
CREATE TABLE IF NOT EXISTS `list_price_type` (
  `id` tinyint(4) NOT NULL,
  `type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.list_price_type: ~2 rows (aproximadamente)
DELETE FROM `list_price_type`;
/*!40000 ALTER TABLE `list_price_type` DISABLE KEYS */;
INSERT INTO `list_price_type` (`id`, `type`) VALUES
	(1, 'Porcentaje'),
	(2, 'Valor');
/*!40000 ALTER TABLE `list_price_type` ENABLE KEYS */;

-- Volcando estructura para tabla krece.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla krece.migrations: ~7 rows (aproximadamente)
DELETE FROM `migrations`;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_resets_table', 2),
	(3, '2016_06_01_000001_create_oauth_auth_codes_table', 2),
	(4, '2016_06_01_000002_create_oauth_access_tokens_table', 2),
	(5, '2016_06_01_000003_create_oauth_refresh_tokens_table', 2),
	(6, '2016_06_01_000004_create_oauth_clients_table', 2),
	(7, '2016_06_01_000005_create_oauth_personal_access_clients_table', 2),
	(8, '2017_08_23_113428_create_documents_table', 3);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Volcando estructura para tabla krece.modules
CREATE TABLE IF NOT EXISTS `modules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL,
  `label` varchar(100) NOT NULL,
  `functionality` varchar(100) NOT NULL,
  `isActive` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id`),
  KEY `FK_modules_parent` (`parent_id`),
  CONSTRAINT `FK_modules_parent` FOREIGN KEY (`parent_id`) REFERENCES `modules_parent` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.modules: ~0 rows (aproximadamente)
DELETE FROM `modules`;
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
/*!40000 ALTER TABLE `modules` ENABLE KEYS */;

-- Volcando estructura para tabla krece.modules_parent
CREATE TABLE IF NOT EXISTS `modules_parent` (
  `id` int(11) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.modules_parent: ~0 rows (aproximadamente)
DELETE FROM `modules_parent`;
/*!40000 ALTER TABLE `modules_parent` DISABLE KEYS */;
/*!40000 ALTER TABLE `modules_parent` ENABLE KEYS */;

-- Volcando estructura para tabla krece.oauth_access_tokens
CREATE TABLE IF NOT EXISTS `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla krece.oauth_access_tokens: ~97 rows (aproximadamente)
DELETE FROM `oauth_access_tokens`;
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
	('03537b70d119b894fb9287a0b11df559a838abb65309d454c8dc75bd84f93c4962f2bc527954286a', 1, 2, NULL, '[]', 0, '2017-08-25 20:50:28', '2017-08-25 20:50:28', '2018-08-25 20:50:28'),
	('09d8ac5b496e34fe60cfe27b989870ba1cea06e0576bc1a628305f4c2fb1039f73526110cd216215', 1, 2, NULL, '[]', 0, '2017-08-25 21:29:53', '2017-08-25 21:29:53', '2018-08-25 21:29:53'),
	('0d9cbdd5573e35a7bfc9e518e6dc98283e4d0dd377c656be6744a12aed878dd3b74dc90e3d16aa3e', 1, 2, NULL, '[]', 0, '2017-08-27 20:59:01', '2017-08-27 20:59:01', '2018-08-27 20:59:01'),
	('0e780b88da83f890f6cbde94dd0580acfc7e9d2fac7be7ab551d74a7f43586ae9df6bd3a32bc070d', 1, 2, NULL, '[]', 0, '2017-08-06 08:23:00', '2017-08-06 08:23:00', '2018-08-06 08:23:00'),
	('0f34f544d911ea4471a3e14595bc33d7d58beca51de24389a36a33a291a136dce64865a2104a1d16', 1, 2, NULL, '[]', 0, '2017-08-27 19:24:07', '2017-08-27 19:24:07', '2018-08-27 19:24:07'),
	('16bf26b47a3ab30d5abadbc3fb5cd5259808500b78d998f5f795e2ab9fa4b1349c445b9dee64e72b', 1, 2, NULL, '[]', 0, '2017-08-28 08:28:31', '2017-08-28 08:28:31', '2018-08-28 08:28:31'),
	('1b3f9121facac3f1769f738fe1a465bd8246ee758e04bf2253754bf3e75771ea6e56d56eef832f0a', 1, 2, NULL, '[]', 0, '2017-08-25 21:27:13', '2017-08-25 21:27:13', '2018-08-25 21:27:13'),
	('1c06eb656617a138bc45f1ba48b84442638f8049488ebefb3046d5eab4437a744f0802642158df07', 1, 2, NULL, '[]', 0, '2017-08-28 08:51:27', '2017-08-28 08:51:27', '2018-08-28 08:51:27'),
	('1e4f0e042a75a5ea7514d9b5f96bb0aa9707698b6405e96a39ff899e2ac791b0a9a7ceccb32ef82b', 1, 2, NULL, '[]', 0, '2017-08-28 08:27:25', '2017-08-28 08:27:25', '2018-08-28 08:27:25'),
	('246984b9e99ffaa33715197039f0f66f3a46c1dcc06a57879d32ae2c81cad7093543a7aae06ce4bb', 1, 2, NULL, '[]', 0, '2017-08-27 21:03:18', '2017-08-27 21:03:18', '2018-08-27 21:03:18'),
	('25ab2fc4930522963ede0f8e9a0ea246025400a983b411a93d336be0e5a5b5ad20872b40eeda76b8', 1, 2, NULL, '[]', 0, '2017-08-06 08:22:51', '2017-08-06 08:22:51', '2018-08-06 08:22:51'),
	('26db2b971248171707e8de9375c5869b6b45ee01721e5199ba562b25022b2aa993667d577d97c422', 1, 2, NULL, '[]', 0, '2017-08-28 07:43:18', '2017-08-28 07:43:18', '2018-08-28 07:43:18'),
	('2748fd37241a2e86307f892007453cec2b3370282f6ec725e2d742913dc02767e416b9deef706654', 1, 2, NULL, '[]', 0, '2017-08-25 20:45:46', '2017-08-25 20:45:46', '2018-08-25 20:45:46'),
	('3021fa8178de500e212bae03c2fcfc93d8f82ebe4e9dca314ad11af9b09d1e3540fba9491bf31569', 1, 2, NULL, '[]', 0, '2017-08-25 21:29:38', '2017-08-25 21:29:38', '2018-08-25 21:29:38'),
	('33687717057837fc95a3ac500c6c3ae3b2922a43ae712610aed00b2ec8f8982b1614359103722936', 1, 2, NULL, '[]', 0, '2017-08-28 09:26:23', '2017-08-28 09:26:23', '2018-08-28 09:26:23'),
	('337276a37de61d95b3b163ab3f420282f2d6f2419724d8473400464dfdc33cd5ce95ea9549607da5', 2, 2, NULL, '[]', 0, '2017-08-28 10:22:25', '2017-08-28 10:22:25', '2018-08-28 10:22:25'),
	('35d174677754a981e717bf3bdd5492801f3b65e2e7e575bb6a6f9506d0031f4fe5bfa23d7cd59fd5', 1, 2, NULL, '[]', 0, '2017-08-28 08:43:48', '2017-08-28 08:43:48', '2018-08-28 08:43:48'),
	('3a13b0e3bf4aafe30b7e51145e06d43717fbc41ba6e5651013257e7b8bf6afd9eea334a3f96c3bba', 1, 2, NULL, '[]', 0, '2017-08-28 09:24:06', '2017-08-28 09:24:06', '2018-08-28 09:24:06'),
	('3a873fbc3a4579f2afd9eabf08b5ab33b6c14bc4bd849fa4ba94c8f5dfba3fc0e321152dad6a6f72', 1, 2, NULL, '[]', 0, '2017-08-25 17:44:52', '2017-08-25 17:44:52', '2018-08-25 17:44:52'),
	('3af139fa90efef95f5fe493a77077f2c8e6cee3b7401f29281376ec96ec912de380fc229f489ea85', 1, 2, NULL, '[]', 0, '2017-08-06 08:21:46', '2017-08-06 08:21:46', '2018-08-06 08:21:46'),
	('3e2a6fdc3f8429e0bbbdf8dacdbf4aad6868ef88399fa0e24fabaf21d09003841fbacaec9238a96c', 1, 2, NULL, '[]', 0, '2017-08-28 06:58:45', '2017-08-28 06:58:45', '2018-08-28 06:58:45'),
	('3f9ca87d690da53e913cf48282f8c6bed083562d4a9a6d0ed3d141c16e0588decdc12cfc44d40ba4', 1, 2, NULL, '[]', 0, '2017-08-27 20:58:53', '2017-08-27 20:58:53', '2018-08-27 20:58:53'),
	('41723f984a1ca4c59bc14e878b430612e49c318ad5ee1da65af1282c7ac168a0377f2fd694db8ff8', 1, 2, NULL, '[]', 0, '2017-08-06 08:25:12', '2017-08-06 08:25:12', '2018-08-06 08:25:12'),
	('45128caad678d84fea2160f3870d4f4e73cfa60f0ae0abf1e00be86fed7f4cfe34071fe6b488ce92', 1, 2, NULL, '[]', 0, '2017-08-25 17:46:19', '2017-08-25 17:46:19', '2018-08-25 17:46:19'),
	('455dee90b9da16c38030a0683837bffea34482d364ac2e14f5bfdf5d8b4da0f380120afeb3821d67', 1, 2, NULL, '[]', 0, '2017-08-28 09:03:28', '2017-08-28 09:03:28', '2018-08-28 09:03:28'),
	('46fcd53845d405b3d3d148550e2436a3a5410e742bb307da6c2e755c38296e9d711c58b279b306b2', 1, 2, NULL, '[]', 0, '2017-08-28 11:49:56', '2017-08-28 11:49:56', '2018-08-28 11:49:56'),
	('48193c7b20e1378a8481ddfa06fce34904294681276fb15e92f6b3f694edfe3d98dfc88557176209', 1, 2, NULL, '[]', 0, '2017-08-25 21:30:22', '2017-08-25 21:30:22', '2018-08-25 21:30:22'),
	('4ba2081cbfb371265f821b48bc369024277eac7a33ff6a39f6cc1bb82c242ad404fb4b9b8034c330', 1, 2, NULL, '[]', 0, '2017-08-25 21:48:42', '2017-08-25 21:48:42', '2018-08-25 21:48:42'),
	('4c6931d9f6e93730d4e99da8bd5516aa4c8a0cde6bfbdca7927cbbb51d8306d3474e96d276d6a10a', 1, 2, NULL, '[]', 0, '2017-08-25 20:48:51', '2017-08-25 20:48:51', '2018-08-25 20:48:51'),
	('506aa7f18cac3608e9f326c54bfb72c79ff938e15d4d395dd69209774023e3d0616ff32363dc6e69', 1, 2, NULL, '[]', 0, '2017-08-28 08:54:40', '2017-08-28 08:54:40', '2018-08-28 08:54:40'),
	('517dd2a06a2051e83846002fb17bff825420129f814fc49f62a6d6a3d0e51b47edcb82c43c5808ba', 1, 2, NULL, '[]', 0, '2017-08-06 08:23:23', '2017-08-06 08:23:23', '2018-08-06 08:23:23'),
	('5271f2ca9263ea37234b50f2249214cfd1ec7ffe540a0683d8c4b30cceb1f29b5a99d64868604731', 1, 2, NULL, '[]', 0, '2017-08-27 21:01:56', '2017-08-27 21:01:56', '2018-08-27 21:01:56'),
	('52d239fbead79f410fe052fc44eed54ca8e40c263ae3aa1e6782961f25b7f0257285b9a505e48539', 1, 2, NULL, '[]', 0, '2017-08-25 21:26:37', '2017-08-25 21:26:37', '2018-08-25 21:26:37'),
	('54a74d66a12351a1909d9ec5c0683f671237dfe658cf5191d4962c29c995a099c4686912c016529b', 1, 2, NULL, '[]', 0, '2017-08-25 21:30:43', '2017-08-25 21:30:43', '2018-08-25 21:30:43'),
	('5803257585d236fd1e9d8ca92955527fce5243cb77e4907e676a54cb313dd5b77c73a801951fb475', 1, 2, NULL, '[]', 0, '2017-08-28 08:46:55', '2017-08-28 08:46:55', '2018-08-28 08:46:55'),
	('58a67948415ad144b67227adf29b725c16e6ab35accf80245c05da310e5a3d7ec26cc01f3394401a', 1, 2, NULL, '[]', 0, '2017-08-25 21:29:58', '2017-08-25 21:29:58', '2018-08-25 21:29:58'),
	('59d9ce9e4c121d9d4a3cc45f23bb2056966ecc1aea908608d144d602482476dfdf218a263370fbda', 1, 2, NULL, '[]', 0, '2017-08-28 08:52:23', '2017-08-28 08:52:23', '2018-08-28 08:52:23'),
	('5c46578ffe68aa24de5f5ec2d84f42441dd11781da35d1ff1155f4039960eff5d12cd7ad257801b1', 1, 2, NULL, '[]', 0, '2017-08-28 07:45:28', '2017-08-28 07:45:28', '2018-08-28 07:45:28'),
	('5c5b5203c3cdae9a5d176604d178de4f9ded9575e107d6c3d01c7e9b07864a4e76846486bf2b4374', 1, 2, NULL, '[]', 0, '2017-08-25 21:22:45', '2017-08-25 21:22:45', '2018-08-25 21:22:45'),
	('5e905e9c371b183d0500f6b5cdfbbb4d1c4c492c781e19718e04117691e462af29bd7fbdf903175d', 1, 2, NULL, '[]', 0, '2017-08-28 09:09:41', '2017-08-28 09:09:41', '2018-08-28 09:09:41'),
	('63e12c0b10d5b4f0f33900ee53be97b3a35564ecf085ecadd61896872911afa974773550aea2727d', 1, 2, NULL, '[]', 0, '2017-08-28 07:38:33', '2017-08-28 07:38:33', '2018-08-28 07:38:33'),
	('674824804b46a81dd6b7fa611a0f2dbf83fb62b135d31d223ae1b9072a1da4a91c8d23d1d4f24b1d', 1, 2, NULL, '[]', 0, '2017-08-28 07:43:00', '2017-08-28 07:43:00', '2018-08-28 07:43:00'),
	('68488ef7ea0cad99373ddee5d7f31740c83f159c4ebfc3a5a59d8a8985be399020e02effe5d307b5', 1, 2, NULL, '[]', 0, '2017-08-25 17:45:51', '2017-08-25 17:45:51', '2018-08-25 17:45:51'),
	('693a0a886d6faf405df866d2d94fac1418c9ed17e7a44da22569299d84ac8eed0a8322b9465712e6', 1, 2, NULL, '[]', 0, '2017-08-25 20:37:34', '2017-08-25 20:37:34', '2018-08-25 20:37:34'),
	('69db3a2c6ce944e70563bd13f88090726d7bc027859edf7b2ad4adeaa508cc7997d3f9ab741fa115', 1, 2, NULL, '[]', 0, '2017-08-25 20:45:19', '2017-08-25 20:45:19', '2018-08-25 20:45:19'),
	('6e2d1f3727ab72c48b9918f80b94bf58c439fe34912e050cbb4289c10423101c92c16b5b6a07177e', 1, 2, NULL, '[]', 0, '2017-08-28 08:48:06', '2017-08-28 08:48:06', '2018-08-28 08:48:06'),
	('6fc158348bb1ce004697ca221e2112268650971c5477e50b9175ab828461ba180dbef1d395cf6a8a', 1, 2, NULL, '[]', 0, '2017-08-25 20:50:37', '2017-08-25 20:50:37', '2018-08-25 20:50:37'),
	('722f2c5595e4d9bd11c14ecc9b860b63dcda29a0161c4b3a331e5402624d224051eeb49667114a04', 1, 2, NULL, '[]', 0, '2017-08-25 17:46:40', '2017-08-25 17:46:40', '2018-08-25 17:46:40'),
	('72f8a04856ce7bc79951ac157adeaa72328863c60a115e17d992dcb28de34f7f8943511d68221e8a', 1, 2, NULL, '[]', 0, '2017-08-27 20:56:23', '2017-08-27 20:56:23', '2018-08-27 20:56:23'),
	('794c23ff299eefe193f3ce9acace7706da400bcd365514dc4cf697cb24af5660435bf55f58e67b90', 1, 2, NULL, '[]', 0, '2017-08-28 08:41:33', '2017-08-28 08:41:33', '2018-08-28 08:41:33'),
	('794cdd070e9b786ed3efc8a895765bfb0a8c1d980650455dc398259d8e63cf9c30f9f0250d081248', 1, 2, NULL, '[]', 0, '2017-08-28 06:42:21', '2017-08-28 06:42:21', '2018-08-28 06:42:21'),
	('874f1d112951750bee076bd1f6aaf1eb58c25e5e2f51b3b7a3452d7885d73d85e4c3f0956c432965', 1, 2, NULL, '[]', 0, '2017-08-28 06:42:21', '2017-08-28 06:42:21', '2018-08-28 06:42:21'),
	('8843596931b959f293cc3318dddc7e87fbcd5b0ac569b8c82abf964df914a5a7def280cce5216a1e', 1, 2, NULL, '[]', 0, '2017-08-28 08:47:28', '2017-08-28 08:47:28', '2018-08-28 08:47:28'),
	('8bcf48309d6e5df0e5e15aac4ea1097463c21090783f8bc5cd4ce5c0765157d64c6cae79c4fc69a7', 1, 2, NULL, '[]', 0, '2017-08-28 12:13:47', '2017-08-28 12:13:47', '2018-08-28 12:13:47'),
	('91aa487aa263b7befd03c75925f25c4c73924695e4b15dd5c118eb258f9fbbf328279ee4cc51d1f6', 1, 2, NULL, '[]', 0, '2017-08-28 07:45:14', '2017-08-28 07:45:14', '2018-08-28 07:45:14'),
	('930c2bc4992624b8003b007a4f9245e6cc38020b8138e55fbd8ad19ab8739008112b05fb83604385', 1, 2, NULL, '[]', 0, '2017-08-28 20:28:55', '2017-08-28 20:28:55', '2018-08-28 20:28:55'),
	('93169f25c6b49c4fbae78fa2aaaffa59af100f59ad211aeddf635244d58d0654f05d0450e7d6532f', 1, 2, NULL, '[]', 0, '2017-08-28 07:44:40', '2017-08-28 07:44:40', '2018-08-28 07:44:40'),
	('9cd5921f51a487bca0fcd13bdef52fb515130252805800a13d8353a60d1b50816f3e4b4527a70f89', 1, 2, NULL, '[]', 0, '2017-08-28 08:53:49', '2017-08-28 08:53:49', '2018-08-28 08:53:49'),
	('9f7ecce987f5225adc8f8c60cdb5dbb60d56dea385094ea3bdb9139c1b830669ad3855228f5da07f', 1, 2, NULL, '[]', 0, '2017-08-28 08:52:57', '2017-08-28 08:52:57', '2018-08-28 08:52:57'),
	('a190d85cd537c46b289a544ab3507e5c7517792ea36a5f42698b5c526f95305ba0386ca2efa9a7fa', 1, 2, NULL, '[]', 0, '2017-08-27 21:02:20', '2017-08-27 21:02:20', '2018-08-27 21:02:20'),
	('a3782fd76e276fdc4cd245e29194743235c9459cc0e55491363b57a20a43d8c7e4c881a97981b463', 1, 2, NULL, '[]', 0, '2017-08-28 08:27:53', '2017-08-28 08:27:53', '2018-08-28 08:27:53'),
	('a9369afbe133c6b763e3ce9e3d5fe76f9a479358ceffc4a899916c8271427c73d2d9d72475bff973', 1, 2, NULL, '[]', 0, '2017-08-28 07:48:17', '2017-08-28 07:48:17', '2018-08-28 07:48:17'),
	('ab4b70d457dbe2ad4bc67dfd2dd677b4da47599cad93aab77bc29cc5658d60042df966363f0c6b78', 1, 2, NULL, '[]', 0, '2017-08-28 06:55:30', '2017-08-28 06:55:30', '2018-08-28 06:55:30'),
	('aba259475b6df17ef96d4c516632e88efe95b3a965fc89ebfa0c74b205e21b1b652c401395b39082', 1, 2, NULL, '[]', 0, '2017-08-25 17:46:04', '2017-08-25 17:46:04', '2018-08-25 17:46:04'),
	('ae6202ab83de5110a70b75bf2f772b63b20a2a323d60495ef547638fc58c078fe76593e82eee81c9', 1, 2, NULL, '[]', 0, '2017-08-06 08:32:42', '2017-08-06 08:32:42', '2018-08-06 08:32:42'),
	('aee7dee77945d6b35eaa0d11f8d357e243c6b82900a1a71be14f96c14784d33d3cccdcbc60c683aa', 1, 2, NULL, '[]', 0, '2017-08-25 20:49:45', '2017-08-25 20:49:45', '2018-08-25 20:49:45'),
	('b03399870e1327c2695d6a11ce3701bd47eebe5503cdf815b3f2c10163bc5bc1090fbb69a7175259', 1, 2, NULL, '[]', 0, '2017-08-28 09:22:16', '2017-08-28 09:22:16', '2018-08-28 09:22:16'),
	('b249855ed4dfdca92f9ecc1f090bdb90c384468743ce861d6555ad3032c9a1a6615efc194f941e88', 1, 2, NULL, '[]', 0, '2017-08-27 09:12:46', '2017-08-27 09:12:46', '2018-08-27 09:12:46'),
	('b55be0aa3796a2eb000e03cf26b7821ad5dcc211f12f9e15b428f5ac14a640ccb42d55e50da84cde', 1, 2, NULL, '[]', 0, '2017-08-27 20:59:01', '2017-08-27 20:59:01', '2018-08-27 20:59:01'),
	('b8f8ac775e3fc5b2eb4bb2f1a4c79c87158fb4218e4f3046d66fb30f2b93953fd2da93a69c8880f7', 1, 2, NULL, '[]', 0, '2017-08-28 07:44:58', '2017-08-28 07:44:58', '2018-08-28 07:44:58'),
	('b9a581c8b158c1cb011e239457ac4987bd880d980842d5abdd73f07fa41e3897219c134164284957', 1, 2, NULL, '[]', 0, '2017-08-28 07:00:33', '2017-08-28 07:00:33', '2018-08-28 07:00:33'),
	('bc1953ef83df154f3a5cf3dc616601027ab50bde03f4638923a8a437585f1c522b4029680f8aa505', 2, 2, NULL, '[]', 0, '2017-08-28 10:22:03', '2017-08-28 10:22:03', '2018-08-28 10:22:03'),
	('bc1d32da5686f32a4fdf0474e7e28efbe1c8056503049d7bca6a4f08c3cd72f04a4e2623d56dd4ef', 1, 2, NULL, '[]', 0, '2017-08-28 08:47:16', '2017-08-28 08:47:16', '2018-08-28 08:47:16'),
	('be46b97aa43822d2258a5ec8d4f2803fc0b91173c85d656f74a831f1a7caf7c130d8a748dfede24a', 1, 2, NULL, '[]', 0, '2017-08-25 21:55:32', '2017-08-25 21:55:32', '2018-08-25 21:55:32'),
	('be6f58c3f03b215d1f3a3e7d134d4776a1e7c29449bac5ac12fad82eb7067fbb53ac9538aa137bf6', 1, 2, NULL, '[]', 0, '2017-08-25 22:05:39', '2017-08-25 22:05:39', '2018-08-25 22:05:39'),
	('c0066683c6dbb11cd55afe69d8aab1da5454ab3da6a85f6e1fb465efc9979107c22c0502a808606a', 1, 2, NULL, '[]', 0, '2017-08-28 07:46:08', '2017-08-28 07:46:08', '2018-08-28 07:46:08'),
	('c21175cf72537d30925f9ada5397533c44a7b8ee1e7ce9e985197ab3bbe9a6fda04e5d8010616b47', 1, 2, NULL, '[]', 0, '2017-08-28 08:53:19', '2017-08-28 08:53:19', '2018-08-28 08:53:19'),
	('c34aa07bb24169f23686705681ed8618adce42bf4fc537f784c5820af8c7a8d1381ee86789cd9792', 1, 2, NULL, '[]', 0, '2017-08-28 06:59:04', '2017-08-28 06:59:04', '2018-08-28 06:59:04'),
	('c5c98a1ab857820c7090971dd6963b08d37f6d255d2199cdf5da5dabdefdb0969db166fdbfcc558b', 1, 2, NULL, '[]', 0, '2017-08-06 08:22:34', '2017-08-06 08:22:34', '2018-08-06 08:22:34'),
	('d2ff9ac39823243252e399306ca9b515f97bf6100872b3598d93e84305294b85ea4b99cc322fb968', 1, 2, NULL, '[]', 0, '2017-08-25 21:35:54', '2017-08-25 21:35:54', '2018-08-25 21:35:54'),
	('d66063ee5c3e5ba8a3b0a3158c4fbc6b0057dbc76f8c00508b5b13e3d5d8789411835df14eeee727', 1, 2, NULL, '[]', 0, '2017-08-25 17:45:07', '2017-08-25 17:45:07', '2018-08-25 17:45:07'),
	('d72fdb664b2f1395a887ff5c8e84ce7b5f8d80cbf5ca2f1936a3cb6325dbb1ca2a314819a4e08301', 1, 2, NULL, '[]', 0, '2017-08-25 20:50:59', '2017-08-25 20:50:59', '2018-08-25 20:50:59'),
	('d7b3c08b8bc593fe92442519a415078c2098d5deee0cc90ba22400fab9a19cbbc2e983b88696e14a', 1, 2, NULL, '[]', 0, '2017-08-28 08:00:58', '2017-08-28 08:00:58', '2018-08-28 08:00:58'),
	('da204899f3929c14be3a7f2ec4be42f5d42af71c7e3d8a5301733b3681d3c128a382b72d4677f7ba', 1, 2, NULL, '[]', 0, '2017-08-27 20:56:38', '2017-08-27 20:56:38', '2018-08-27 20:56:38'),
	('db6138e0d0f1f8798688c2c15496923040065d54ab290550c31f62df6766f905f6941b561d8d5442', 1, 2, NULL, '[]', 0, '2017-08-25 21:25:21', '2017-08-25 21:25:21', '2018-08-25 21:25:21'),
	('ddc1bcabf3b031155c99a719fecaebca02175b411b7e89e0bf4b313f3bb761893812cf4fe5cf50d6', 1, 2, NULL, '[]', 0, '2017-08-28 08:54:22', '2017-08-28 08:54:22', '2018-08-28 08:54:22'),
	('e01f892ad99a0adf0e9bd4d9308ca3b1086d50cc01840f0eec4ede93a8b6929efc02a97f19c897a8', 1, 2, NULL, '[]', 0, '2017-08-28 20:35:53', '2017-08-28 20:35:53', '2018-08-28 20:35:53'),
	('e2cffbbf42cdff3a358bca5a5298fce06babfb4ccca65f0b8a93e20681ef38447212de62fa95fa93', 1, 2, NULL, '[]', 0, '2017-08-28 08:40:37', '2017-08-28 08:40:37', '2018-08-28 08:40:37'),
	('e30770ede35bca65e1622314fa34638355db453e94374bf4042930b22ca0e061169b9787624cf43b', 1, 2, NULL, '[]', 0, '2017-08-28 08:01:20', '2017-08-28 08:01:20', '2018-08-28 08:01:20'),
	('e4ba51e10a4322b469e9748035ce529a4b49e819fb2497cb91790fa01601edba00b2352008cd8aa8', 1, 2, NULL, '[]', 0, '2017-08-28 09:30:51', '2017-08-28 09:30:51', '2018-08-28 09:30:51'),
	('e5646e44e94d36f24b0fcef086a25c564395548689b407c3ab8793758f80bbc96b48dbaa5a9be80b', 1, 2, NULL, '[]', 0, '2017-08-27 20:58:33', '2017-08-27 20:58:33', '2018-08-27 20:58:33'),
	('e56680da568b25dd1dd393852798786fda9d62cd058d632f023e1b989d9154b50de5d6d5874d651d', 1, 2, NULL, '[]', 0, '2017-08-06 08:24:30', '2017-08-06 08:24:30', '2018-08-06 08:24:30'),
	('ed054ad79161a9718935e4bf48c422f33546b45644e96e48af54ece52442ddc2ccdff43d2c295214', 1, 2, NULL, '[]', 0, '2017-08-25 22:08:25', '2017-08-25 22:08:25', '2018-08-25 22:08:25'),
	('f37df34d0de72b6d57d3b1e6253c878044c2d732e69542a2b91cad3f686093ac0bc9a344034456ad', 1, 2, NULL, '[]', 0, '2017-08-25 21:27:42', '2017-08-25 21:27:42', '2018-08-25 21:27:42'),
	('f47a88b0ff462b3528ad5190ee7742ccaeafed461722b4167a9fae2906f2024cfaf97fbf117a16b1', 1, 2, NULL, '[]', 0, '2017-08-25 21:26:09', '2017-08-25 21:26:09', '2018-08-25 21:26:09'),
	('f4b393b365cb2723e7f565f564c58d85fcf54c6717518ff8d0811ac41b78b70ca660413093889818', 1, 2, NULL, '[]', 0, '2017-08-28 09:03:40', '2017-08-28 09:03:40', '2018-08-28 09:03:40'),
	('f53cd16618b3bff5375389a875167db5f53486602ee20156eeb38f592dee6cf214a0b5be12a36478', 1, 2, NULL, '[]', 0, '2017-08-25 20:40:09', '2017-08-25 20:40:09', '2018-08-25 20:40:09'),
	('f5fdcf9c74780d9717ecbcf919cba2813d7d854ac8eb24e5911cc4652f25bc9a87b6036f065a0cb8', 1, 2, NULL, '[]', 0, '2017-08-28 08:40:56', '2017-08-28 08:40:56', '2018-08-28 08:40:56'),
	('f6a9d57b3fe118ffc68213e8d91a16ae9b7f740edcf4f07123658fcb718ec28303d96243d0f21bec', 1, 2, NULL, '[]', 0, '2017-08-25 17:43:06', '2017-08-25 17:43:06', '2018-08-25 17:43:06'),
	('f7621f25de1c20636ff41f2c831199ef4ccf1a810c29c4538577efb452bf5899ee77041c8605672d', 1, 2, NULL, '[]', 0, '2017-08-28 09:13:21', '2017-08-28 09:13:21', '2018-08-28 09:13:21'),
	('f9a0e300958e3c5c2c141e92b7ce7279727dc8aefab498d21b65b9a9495afde6bfa73ff3bc0ef3fd', 1, 2, NULL, '[]', 0, '2017-08-28 08:28:19', '2017-08-28 08:28:19', '2018-08-28 08:28:19'),
	('fab8e1ca040e0534c84067020f8b1f5f725c31e90d2f4749f491de482a52b81d1f1e813ef07c4519', 1, 2, NULL, '[]', 0, '2017-08-28 07:58:00', '2017-08-28 07:58:00', '2018-08-28 07:58:00'),
	('fc266e645db221b2356cf19bc2609e0507cbc2a30fb4fc09f0d9311eb141ececf50b97eb868de1a4', 1, 2, NULL, '[]', 0, '2017-08-28 07:00:49', '2017-08-28 07:00:49', '2018-08-28 07:00:49'),
	('fd249233f41b6de58250381ce72662de556c9e741b6e8b49b69d5556cddc87584b79669fc9dadc72', 1, 2, NULL, '[]', 0, '2017-08-25 21:57:15', '2017-08-25 21:57:15', '2018-08-25 21:57:15');
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;

-- Volcando estructura para tabla krece.oauth_auth_codes
CREATE TABLE IF NOT EXISTS `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla krece.oauth_auth_codes: ~0 rows (aproximadamente)
DELETE FROM `oauth_auth_codes`;
/*!40000 ALTER TABLE `oauth_auth_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_auth_codes` ENABLE KEYS */;

-- Volcando estructura para tabla krece.oauth_clients
CREATE TABLE IF NOT EXISTS `oauth_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla krece.oauth_clients: ~2 rows (aproximadamente)
DELETE FROM `oauth_clients`;
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
	(1, NULL, 'Krece Personal Access Client', 'XP7K9ob6TAPRr7aeDmXg1YqQBiztzX7TjV7rUU5B', 'http://localhost', 1, 0, 0, '2017-08-27 19:16:22', '2017-08-27 19:16:22'),
	(2, NULL, 'Krece Password Grant Client', 'BlJ5gebqS6riqucAJaGHfEZ4W67HWnhJdGP2rjZv', 'http://localhost', 0, 1, 0, '2017-08-27 19:16:22', '2017-08-27 19:16:22');
/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;

-- Volcando estructura para tabla krece.oauth_personal_access_clients
CREATE TABLE IF NOT EXISTS `oauth_personal_access_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_personal_access_clients_client_id_index` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla krece.oauth_personal_access_clients: ~3 rows (aproximadamente)
DELETE FROM `oauth_personal_access_clients`;
/*!40000 ALTER TABLE `oauth_personal_access_clients` DISABLE KEYS */;
INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
	(1, 1, '2017-08-05 21:04:50', '2017-08-05 21:04:50'),
	(2, 3, '2017-08-27 15:12:49', '2017-08-27 15:12:49'),
	(3, 5, '2017-08-27 15:13:23', '2017-08-27 15:13:23'),
	(4, 1, '2017-08-27 19:16:22', '2017-08-27 19:16:22');
/*!40000 ALTER TABLE `oauth_personal_access_clients` ENABLE KEYS */;

-- Volcando estructura para tabla krece.oauth_refresh_tokens
CREATE TABLE IF NOT EXISTS `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla krece.oauth_refresh_tokens: ~97 rows (aproximadamente)
DELETE FROM `oauth_refresh_tokens`;
/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;
INSERT INTO `oauth_refresh_tokens` (`id`, `access_token_id`, `revoked`, `expires_at`) VALUES
	('04fdd078dda5ef1a4f40ec5383ca6af2f2f8a68efa6fa92445aabbc21b4a294febe1e3490d0c0f2d', '794cdd070e9b786ed3efc8a895765bfb0a8c1d980650455dc398259d8e63cf9c30f9f0250d081248', 0, '2018-08-28 06:42:22'),
	('0543008739e3343b39a4f558b735f599435c38a9ae0567aba62f07ec013bcad3583ec49c9ad77a58', 'f4b393b365cb2723e7f565f564c58d85fcf54c6717518ff8d0811ac41b78b70ca660413093889818', 0, '2018-08-28 09:03:40'),
	('0c45d1914d56a7f51beea6a95b677eea04003cabb5c151a45f9c3af36626851b554bb02fd510147b', 'e01f892ad99a0adf0e9bd4d9308ca3b1086d50cc01840f0eec4ede93a8b6929efc02a97f19c897a8', 0, '2018-08-28 20:35:53'),
	('0cfa01804da07c5e5c9c56830a052fbc2d53096271b18ff13ef234b85485027e1be430b3aa84908a', 'ae6202ab83de5110a70b75bf2f772b63b20a2a323d60495ef547638fc58c078fe76593e82eee81c9', 0, '2018-08-06 08:32:42'),
	('0d896cccaf20c2ad75fbeb06ad69854ac0257ad7febe323058b287c45cef3aed504a8686004d81fd', 'd2ff9ac39823243252e399306ca9b515f97bf6100872b3598d93e84305294b85ea4b99cc322fb968', 0, '2018-08-25 21:35:54'),
	('0f7a0ae0c5b4decc3089494b7d06b8f7748b2d7d26c5b92472b7abf89934f2491df9e3b6cd0ebd62', 'a3782fd76e276fdc4cd245e29194743235c9459cc0e55491363b57a20a43d8c7e4c881a97981b463', 0, '2018-08-28 08:27:53'),
	('172315ddcfad562972dac444807f0ee8be46aedde5e3ef9ab67e0f94b5d4c772ccf39e62821308d3', '5e905e9c371b183d0500f6b5cdfbbb4d1c4c492c781e19718e04117691e462af29bd7fbdf903175d', 0, '2018-08-28 09:09:41'),
	('1a787999ffe997f98fe93557f979ea5bb02f34665fe5375b311676c5d8162797cc04938aba5bd7fb', '69db3a2c6ce944e70563bd13f88090726d7bc027859edf7b2ad4adeaa508cc7997d3f9ab741fa115', 0, '2018-08-25 20:45:19'),
	('1c4bc6a1d85c33a498bf03c643981c2a61b3be9bd66a3856f12d42809e552d08d4f624e3696b4302', 'e56680da568b25dd1dd393852798786fda9d62cd058d632f023e1b989d9154b50de5d6d5874d651d', 0, '2018-08-06 08:24:30'),
	('1c4c5a3954233a825e2babfc0c61484bdc04a90e3dde6df29e0f15c42be57c5c4c1c898a1a566335', 'b55be0aa3796a2eb000e03cf26b7821ad5dcc211f12f9e15b428f5ac14a640ccb42d55e50da84cde', 0, '2018-08-27 20:59:01'),
	('2027d63701f8be5786ada3304d37d3ed8945b9553b1c2159cf051c8dfc4a1e2f2d23652a61c2e596', '3a13b0e3bf4aafe30b7e51145e06d43717fbc41ba6e5651013257e7b8bf6afd9eea334a3f96c3bba', 0, '2018-08-28 09:24:06'),
	('222dfef2e4ae6d9f30b7ae05964831b2d207a4caa51904207102428e92969919decfe9134ac77b6c', 'ab4b70d457dbe2ad4bc67dfd2dd677b4da47599cad93aab77bc29cc5658d60042df966363f0c6b78', 0, '2018-08-28 06:55:30'),
	('2239d30e67d53576f7e572359cefd143667f588dbb0522d01af5343fe30a740b0ef4aa77c39035b5', '506aa7f18cac3608e9f326c54bfb72c79ff938e15d4d395dd69209774023e3d0616ff32363dc6e69', 0, '2018-08-28 08:54:40'),
	('230ac59195e73af230d94601271edd6a27be21a8f850c3e751748055384061e12fdfe5c12103a1f3', '5c5b5203c3cdae9a5d176604d178de4f9ded9575e107d6c3d01c7e9b07864a4e76846486bf2b4374', 0, '2018-08-25 21:22:46'),
	('23a9510bec0baafbe5e95e028a32422d967a1f1f0b6d12aefabf4c521e1fa7b7d93e35df2673c060', '0e780b88da83f890f6cbde94dd0580acfc7e9d2fac7be7ab551d74a7f43586ae9df6bd3a32bc070d', 0, '2018-08-06 08:23:00'),
	('24260502315094776c3737b1fbab81eb8bac281a12e6f271601127ad671fcb63540e2a9de453d9be', 'f47a88b0ff462b3528ad5190ee7742ccaeafed461722b4167a9fae2906f2024cfaf97fbf117a16b1', 0, '2018-08-25 21:26:10'),
	('247d566c7cf7637536cd90b37293c3f207bef32dadfb325bb4945b7e9cc3ea0e124255ff35298140', '5803257585d236fd1e9d8ca92955527fce5243cb77e4907e676a54cb313dd5b77c73a801951fb475', 0, '2018-08-28 08:46:55'),
	('28cb9ad234d5fb5bff5b64ff95c6ed8c10533d9085a326916463e5b249f663983b2443bd44b6ca99', 'e30770ede35bca65e1622314fa34638355db453e94374bf4042930b22ca0e061169b9787624cf43b', 0, '2018-08-28 08:01:20'),
	('2bae99f59345fb0851fe7fc1838a656b1ee8966ae1b8b046127d2c61493847fd42e2e53f0f1dc4ed', '45128caad678d84fea2160f3870d4f4e73cfa60f0ae0abf1e00be86fed7f4cfe34071fe6b488ce92', 0, '2018-08-25 17:46:19'),
	('2c3109e24b5461d9d28ebcf5ed6eb5c66a859ea6207c7c518f9fbf18b516c8c70b10f9f61fd37440', '8843596931b959f293cc3318dddc7e87fbcd5b0ac569b8c82abf964df914a5a7def280cce5216a1e', 0, '2018-08-28 08:47:28'),
	('2ff1f5ebfe37653e958ccff19557fb541d96e7e0f24335ec11f7ad1a46063785da43ee671e6ff1fe', 'e5646e44e94d36f24b0fcef086a25c564395548689b407c3ab8793758f80bbc96b48dbaa5a9be80b', 0, '2018-08-27 20:58:33'),
	('30d95b417889d70f160d47dc6bade8f0cf60a602f99defd818871cb88bf10a4bcf7dc73c7e5fb388', '58a67948415ad144b67227adf29b725c16e6ab35accf80245c05da310e5a3d7ec26cc01f3394401a', 0, '2018-08-25 21:29:58'),
	('315fc659a852e86e3f29cac6f10ced43c233aa9c367edff5b98a81542757cf3f00ee18c263ce4dfd', 'ed054ad79161a9718935e4bf48c422f33546b45644e96e48af54ece52442ddc2ccdff43d2c295214', 0, '2018-08-25 22:08:25'),
	('351dff4ab5b9c9fc0c9c57da8f551952eb9486a5264d05cc3bb17c3bdf3bd024d0fc59385d82a44f', 'f5fdcf9c74780d9717ecbcf919cba2813d7d854ac8eb24e5911cc4652f25bc9a87b6036f065a0cb8', 0, '2018-08-28 08:40:56'),
	('359b9978f6b67acdd54d1328f49c11725f3c976bf463cc13ff18a0635b80fc714cac70eaef8a08c5', 'a190d85cd537c46b289a544ab3507e5c7517792ea36a5f42698b5c526f95305ba0386ca2efa9a7fa', 0, '2018-08-27 21:02:20'),
	('35ed003dcb1d2b233a6b9eb2058624bdc9bf475488bb95a9864efbf23475f10efa607ac02361448e', 'bc1953ef83df154f3a5cf3dc616601027ab50bde03f4638923a8a437585f1c522b4029680f8aa505', 0, '2018-08-28 10:22:04'),
	('39af2d4a8b6f0bd32d2e03440913382513a1772ed13c17aa24c0175a68842f5638a3d0570840bc66', '3af139fa90efef95f5fe493a77077f2c8e6cee3b7401f29281376ec96ec912de380fc229f489ea85', 0, '2018-08-06 08:21:47'),
	('3ba9a3052b5a51ecbe4342bf7b1681d2ee2a71de574a0f2040dc3b2e3731fec6a370eadd04b1e7a7', '8bcf48309d6e5df0e5e15aac4ea1097463c21090783f8bc5cd4ce5c0765157d64c6cae79c4fc69a7', 0, '2018-08-28 12:13:47'),
	('3da383e030194dec978d496b6b77d9a914b6739b629e160e83da1195124dda05c5606d2577c2cd4d', '35d174677754a981e717bf3bdd5492801f3b65e2e7e575bb6a6f9506d0031f4fe5bfa23d7cd59fd5', 0, '2018-08-28 08:43:48'),
	('3ef131804be75800dd13ec4835b6273e9709c37a4d5d3f1a4b74dbfe21ea9a86d4165cf9c91aa28b', '794c23ff299eefe193f3ce9acace7706da400bcd365514dc4cf697cb24af5660435bf55f58e67b90', 0, '2018-08-28 08:41:33'),
	('3f6dbb150b57ab91107c2aaf4079ccaaf15aff928fe1627acd8fa5a2179f50d8978cd056fcb2384c', 'bc1d32da5686f32a4fdf0474e7e28efbe1c8056503049d7bca6a4f08c3cd72f04a4e2623d56dd4ef', 0, '2018-08-28 08:47:16'),
	('47943f170fcbd0c48dfe5ba9295aa96a2e2a1ebb874b34a878823df98350b10f54b04e785ee214c8', '2748fd37241a2e86307f892007453cec2b3370282f6ec725e2d742913dc02767e416b9deef706654', 0, '2018-08-25 20:45:46'),
	('48e37aabf8a2bc68085c50bb5f06edad5f2191cc9ef901c02eb3c9f12605d68e1f4356ed8434a125', '3e2a6fdc3f8429e0bbbdf8dacdbf4aad6868ef88399fa0e24fabaf21d09003841fbacaec9238a96c', 0, '2018-08-28 06:58:45'),
	('4dbd350d2afb95003cbe721d224b6c8bbb78ac6cc09269d1288304ffa26a2b979db9b34060b0d36b', 'be6f58c3f03b215d1f3a3e7d134d4776a1e7c29449bac5ac12fad82eb7067fbb53ac9538aa137bf6', 0, '2018-08-25 22:05:39'),
	('55b3ec97c8c3f897ea831cda1f66a5b50bee3f82a2b23e8cab0069f113f9683229cd37da514f49c0', 'db6138e0d0f1f8798688c2c15496923040065d54ab290550c31f62df6766f905f6941b561d8d5442', 0, '2018-08-25 21:25:21'),
	('599b553b5e8f500088b2f35b1be59d90a9cf64e780e810b2de90550592d8a0d3595f3da6339cb263', '1e4f0e042a75a5ea7514d9b5f96bb0aa9707698b6405e96a39ff899e2ac791b0a9a7ceccb32ef82b', 0, '2018-08-28 08:27:26'),
	('5a9b99e9f4a6191bbad04cb11f6b9216027fa0eab59fe8d8bf66d2f4f6f01649911fe75dbbd6ad54', 'f6a9d57b3fe118ffc68213e8d91a16ae9b7f740edcf4f07123658fcb718ec28303d96243d0f21bec', 0, '2018-08-25 17:43:07'),
	('5f89014d07805f3ac76d64a4cdaf7d57865acdc73f3b538393e73988be8f718666d96563d9bd73d7', 'aee7dee77945d6b35eaa0d11f8d357e243c6b82900a1a71be14f96c14784d33d3cccdcbc60c683aa', 0, '2018-08-25 20:49:45'),
	('606ce6266c98401929a4853b513caf4ed7c2d7aa5bf9568654aa743c8cbaf839dc0f52de4af1a0ee', 'b9a581c8b158c1cb011e239457ac4987bd880d980842d5abdd73f07fa41e3897219c134164284957', 0, '2018-08-28 07:00:33'),
	('63c2c8024f10bb8fd3c5c25ebc00222d7119d8735504726bab2e7624efd341dc5ecbe24c7d7905ee', '46fcd53845d405b3d3d148550e2436a3a5410e742bb307da6c2e755c38296e9d711c58b279b306b2', 0, '2018-08-28 11:49:56'),
	('662c7afb993bc6f5d4fe84473974066bba90cd5eb5f5657d7b3b98ea896f81852849cf7a823a9601', '0d9cbdd5573e35a7bfc9e518e6dc98283e4d0dd377c656be6744a12aed878dd3b74dc90e3d16aa3e', 0, '2018-08-27 20:59:01'),
	('66fd60b498e5216d273de0cf5cda736c86336c9c5cd1c9119836bf8b01d28f4c1bcdc05a69fccc58', '91aa487aa263b7befd03c75925f25c4c73924695e4b15dd5c118eb258f9fbbf328279ee4cc51d1f6', 0, '2018-08-28 07:45:14'),
	('6792c3bb9032db0f4bd4c037f49ffe1499a2fc0f181e5641bee6de5d62e78d2970729067d0de7ace', '52d239fbead79f410fe052fc44eed54ca8e40c263ae3aa1e6782961f25b7f0257285b9a505e48539', 0, '2018-08-25 21:26:37'),
	('69577cd4a50ee7ece66bc8ee718e67d997454795a7bb7190bf2cc1c534d631d15376f5ef223ac7d0', '4ba2081cbfb371265f821b48bc369024277eac7a33ff6a39f6cc1bb82c242ad404fb4b9b8034c330', 0, '2018-08-25 21:48:42'),
	('6a096bc34094313c60a38e554c634940b402c3117e01a14ecabad6ac951c231b8465e2111f3da981', 'f9a0e300958e3c5c2c141e92b7ce7279727dc8aefab498d21b65b9a9495afde6bfa73ff3bc0ef3fd', 0, '2018-08-28 08:28:19'),
	('6a147b386558e7fd0f136143787d4ac2dcb6dee0ab52f8819df6572b515b0daadf183b76fd169025', '1b3f9121facac3f1769f738fe1a465bd8246ee758e04bf2253754bf3e75771ea6e56d56eef832f0a', 0, '2018-08-25 21:27:14'),
	('6a1eff7e1b7c998713ac390e1cf9c14dcedd94a34ac1cb817864757a6eabe1857571d97d4f21f4c8', '5c46578ffe68aa24de5f5ec2d84f42441dd11781da35d1ff1155f4039960eff5d12cd7ad257801b1', 0, '2018-08-28 07:45:28'),
	('6cea19ca1f64b743a25b1c0ab9151867c54a1800393085e45335e43811bfcd0d3b1644d0c3749fec', '59d9ce9e4c121d9d4a3cc45f23bb2056966ecc1aea908608d144d602482476dfdf218a263370fbda', 0, '2018-08-28 08:52:23'),
	('6d12bae94d9794cff587a0714980fd384403b90cdc19962ebaaddb785b960f6e8bdf9ec1daf9a5c0', '93169f25c6b49c4fbae78fa2aaaffa59af100f59ad211aeddf635244d58d0654f05d0450e7d6532f', 0, '2018-08-28 07:44:40'),
	('6d940f66735222e9a4b8c413eef6f0b4446d9b1d988a6ee66665009fa4fa9cae04621efd2cb51c3d', '246984b9e99ffaa33715197039f0f66f3a46c1dcc06a57879d32ae2c81cad7093543a7aae06ce4bb', 0, '2018-08-27 21:03:18'),
	('703830fef7e273aa9fb357fe4a8bfaa8c69aa7bd279a0145ac862ca5150b364a3dcdfe4051036f2d', 'c5c98a1ab857820c7090971dd6963b08d37f6d255d2199cdf5da5dabdefdb0969db166fdbfcc558b', 0, '2018-08-06 08:22:34'),
	('72ec65e9c1e09a5d5daf8f609df7ecf7c6f55ebadb2b2f1a2d6b85f31af5471610e8f23188ec0b9b', '674824804b46a81dd6b7fa611a0f2dbf83fb62b135d31d223ae1b9072a1da4a91c8d23d1d4f24b1d', 0, '2018-08-28 07:43:00'),
	('74c7371f6943f87b795529496348cb9766406666b963b7e7b09ee5f44fb40e2e8bcabf4321ceead1', '0f34f544d911ea4471a3e14595bc33d7d58beca51de24389a36a33a291a136dce64865a2104a1d16', 0, '2018-08-27 19:24:07'),
	('778c469dbf875d76865c88700af46ef4e5de72cb4e37e2569287b36df32980ebc55e5f8cd7aba16e', 'fd249233f41b6de58250381ce72662de556c9e741b6e8b49b69d5556cddc87584b79669fc9dadc72', 0, '2018-08-25 21:57:15'),
	('796fa1c74f66c9928e3e25f0828459f9800084463186478b4dbd81569a91d78da9676e71deb0c5d2', 'b8f8ac775e3fc5b2eb4bb2f1a4c79c87158fb4218e4f3046d66fb30f2b93953fd2da93a69c8880f7', 0, '2018-08-28 07:44:58'),
	('7975984b95703189260b98f6005b857809db0d2731df1a6a91b57813cfd44cd9cadcda5f1f4146e8', '3a873fbc3a4579f2afd9eabf08b5ab33b6c14bc4bd849fa4ba94c8f5dfba3fc0e321152dad6a6f72', 0, '2018-08-25 17:44:52'),
	('7b06a254bf9a7ec0b9dc07a3e48dc6b96bdbb4207b7453a834e2e4909b153a6fc394109be78f798a', '9f7ecce987f5225adc8f8c60cdb5dbb60d56dea385094ea3bdb9139c1b830669ad3855228f5da07f', 0, '2018-08-28 08:52:57'),
	('7d6f73bd957e6b0e63efd726d802ed04c4e1f68993ed9a5aaa40e23d86e316f5e539f663d9b5af54', '54a74d66a12351a1909d9ec5c0683f671237dfe658cf5191d4962c29c995a099c4686912c016529b', 0, '2018-08-25 21:30:43'),
	('87c860bf2a910efb8bba1e2e25afec1258df72e35624a312604e5dc8d707e7ff96f36cfac37c1f50', 'aba259475b6df17ef96d4c516632e88efe95b3a965fc89ebfa0c74b205e21b1b652c401395b39082', 0, '2018-08-25 17:46:04'),
	('8c0909a1a3732e258bcf407b1dbc03b5ba70af2118a638b66febe2a98f48cd1680e371d3cfcf3bdd', '72f8a04856ce7bc79951ac157adeaa72328863c60a115e17d992dcb28de34f7f8943511d68221e8a', 0, '2018-08-27 20:56:23'),
	('8e4b3245d478de5b35b0762b52d196c2299eae2f755fd0408946c1affd91d11a4643eb76a5818691', '48193c7b20e1378a8481ddfa06fce34904294681276fb15e92f6b3f694edfe3d98dfc88557176209', 0, '2018-08-25 21:30:22'),
	('9844d051f460e58213ec337ada7938e20c08b750b00e7670586a1058e7c6b1719540831e9e505def', '6fc158348bb1ce004697ca221e2112268650971c5477e50b9175ab828461ba180dbef1d395cf6a8a', 0, '2018-08-25 20:50:37'),
	('9a4750f814d99e6c0463db7f222cd075e5fc98eacb08c8994b624d72b5b8ad32c4bf67289be5ae9a', '5271f2ca9263ea37234b50f2249214cfd1ec7ffe540a0683d8c4b30cceb1f29b5a99d64868604731', 0, '2018-08-27 21:01:56'),
	('9d653bcf48690915ebb0edf66b7ce568f4c53ac08fb67a5689792341def64f35729d9abc0ef43a09', '25ab2fc4930522963ede0f8e9a0ea246025400a983b411a93d336be0e5a5b5ad20872b40eeda76b8', 0, '2018-08-06 08:22:51'),
	('a14a8d696d2010d013aac82a2338d248c06960ff16a40dd799938ff23e1ca9b0510d806cf31f75ce', 'b249855ed4dfdca92f9ecc1f090bdb90c384468743ce861d6555ad3032c9a1a6615efc194f941e88', 0, '2018-08-27 09:12:46'),
	('a1526ca95d1a39ae3499be806f2c94011618dd8ddd68b5490b4b3f6b5e3731383e0ebdae85f7c314', 'd66063ee5c3e5ba8a3b0a3158c4fbc6b0057dbc76f8c00508b5b13e3d5d8789411835df14eeee727', 0, '2018-08-25 17:45:07'),
	('a7d065cc5fea51b56faa02688c56027b0286f7dc2f8dd863a2490978d16400b448c5dc065de269cf', 'c34aa07bb24169f23686705681ed8618adce42bf4fc537f784c5820af8c7a8d1381ee86789cd9792', 0, '2018-08-28 06:59:04'),
	('aaafdbdf1ea0df3482958367b8347c4f1afddffa94d0c00b7ff465bd9203d9d038d01aaa9ac5d261', '4c6931d9f6e93730d4e99da8bd5516aa4c8a0cde6bfbdca7927cbbb51d8306d3474e96d276d6a10a', 0, '2018-08-25 20:48:51'),
	('ae9e8dea7c370afbde71e482f78c56244f73358863967c5c31577fa9d349d0f3b1e908ae98697db9', '874f1d112951750bee076bd1f6aaf1eb58c25e5e2f51b3b7a3452d7885d73d85e4c3f0956c432965', 0, '2018-08-28 06:42:22'),
	('afcbbb4590a6b9f3c544c1a540e7f7f9abf76f96a4b522ed2bb9308d0a3b10038d039117503338ba', 'a9369afbe133c6b763e3ce9e3d5fe76f9a479358ceffc4a899916c8271427c73d2d9d72475bff973', 0, '2018-08-28 07:48:18'),
	('afd835672e7ddcc2121afec6067274aec6fe3716fa1bf76432ede38dd917d979884460d9ff3da238', '03537b70d119b894fb9287a0b11df559a838abb65309d454c8dc75bd84f93c4962f2bc527954286a', 0, '2018-08-25 20:50:28'),
	('b25d694d284110ae3e0264f146293e06bab4cd0a0720bb76b23bd5e6129b9143963ff67c69f853be', 'f7621f25de1c20636ff41f2c831199ef4ccf1a810c29c4538577efb452bf5899ee77041c8605672d', 0, '2018-08-28 09:13:21'),
	('b367a0f55de20aff6b5af4b9cf0243e2a7604e7e163a0720ecd298ef7f8d570f6ae0fe057298dac2', '337276a37de61d95b3b163ab3f420282f2d6f2419724d8473400464dfdc33cd5ce95ea9549607da5', 0, '2018-08-28 10:22:25'),
	('b5fe48b4e867c8dab7734620c77b513a4c9c10e44b4bcc5a7113b67628a93692021da666bd323e91', '33687717057837fc95a3ac500c6c3ae3b2922a43ae712610aed00b2ec8f8982b1614359103722936', 0, '2018-08-28 09:26:23'),
	('b8e65eae4ef8af44a2175f9438cc325c6e11a33b137d82eb5ee06af5870a198a41f925276cafac44', 'b03399870e1327c2695d6a11ce3701bd47eebe5503cdf815b3f2c10163bc5bc1090fbb69a7175259', 0, '2018-08-28 09:22:16'),
	('c25fc38617d00a7ff7e0086bec577b17618f4a0c3a469329083d19c197b272d00a96460764b794de', '693a0a886d6faf405df866d2d94fac1418c9ed17e7a44da22569299d84ac8eed0a8322b9465712e6', 0, '2018-08-25 20:37:34'),
	('c2ee8bb70dd5e6dab5ccd06a0cc0f50d639ad3adff7a721fab7250d2c0d9e34f825dd1e5ad9aabd1', 'e4ba51e10a4322b469e9748035ce529a4b49e819fb2497cb91790fa01601edba00b2352008cd8aa8', 0, '2018-08-28 09:30:51'),
	('cba372eeb0a2bb89717d431ca98c3faa5f30db941f11a15f24a328ee572ad3c45207876fddf6e25b', 'd7b3c08b8bc593fe92442519a415078c2098d5deee0cc90ba22400fab9a19cbbc2e983b88696e14a', 0, '2018-08-28 08:00:58'),
	('d0d11a47f9158fc140b09be8279886e008cbeb7960bac6ac28c6382ecf785c484c0bfd70934c51b5', 'ddc1bcabf3b031155c99a719fecaebca02175b411b7e89e0bf4b313f3bb761893812cf4fe5cf50d6', 0, '2018-08-28 08:54:22'),
	('d0fc290a40bfe6b288f1b435425b62d6902079884be52d65580311a56fd4fcc4913d00a072b2a452', 'c0066683c6dbb11cd55afe69d8aab1da5454ab3da6a85f6e1fb465efc9979107c22c0502a808606a', 0, '2018-08-28 07:46:08'),
	('d35def281849c407e4f764230362f6a2a3b5e4da20648358c51ef3c34df96c4fffec46c35fccc6fe', '6e2d1f3727ab72c48b9918f80b94bf58c439fe34912e050cbb4289c10423101c92c16b5b6a07177e', 0, '2018-08-28 08:48:06'),
	('d3d4f9abe22c03784f5cdd22973a4aff9072ab9d1dd5937db7ea5e6f6af749f41ecb36bbc31fda82', '722f2c5595e4d9bd11c14ecc9b860b63dcda29a0161c4b3a331e5402624d224051eeb49667114a04', 0, '2018-08-25 17:46:40'),
	('d45753c4adcbab9bc9178a7e5074eefcba86b9eb9a71c6e1741e13de7a8b3be4c20cfcb959472971', 'be46b97aa43822d2258a5ec8d4f2803fc0b91173c85d656f74a831f1a7caf7c130d8a748dfede24a', 0, '2018-08-25 21:55:32'),
	('d5499cf859128c3e974d61dff52306c661e000c22595ef6fd5ae122d67166de0cf8eccb43e73917b', '16bf26b47a3ab30d5abadbc3fb5cd5259808500b78d998f5f795e2ab9fa4b1349c445b9dee64e72b', 0, '2018-08-28 08:28:31'),
	('d5966a24a14514759df6382f752d4ed7ae6d2faf38c3bbf0d0ca278ef6f29e283563ae6f4c04109a', 'fab8e1ca040e0534c84067020f8b1f5f725c31e90d2f4749f491de482a52b81d1f1e813ef07c4519', 0, '2018-08-28 07:58:00'),
	('d724358428a7a29796c2ebda87a7aa633d22a676de610a4e0db420c7aaf400b1d43ad9d88179e173', '26db2b971248171707e8de9375c5869b6b45ee01721e5199ba562b25022b2aa993667d577d97c422', 0, '2018-08-28 07:43:18'),
	('d9e9411aa3d9d43b113ad96c39cf971c15f9a1cf2daa65ad718bb4bebf8170e3202a797a47761179', '930c2bc4992624b8003b007a4f9245e6cc38020b8138e55fbd8ad19ab8739008112b05fb83604385', 0, '2018-08-28 20:28:56'),
	('db13d4475e2e827b45af6d387833d663ba9c873d2aa84bbd07857bcd09b8b6ab9af804c5315dcc1c', 'fc266e645db221b2356cf19bc2609e0507cbc2a30fb4fc09f0d9311eb141ececf50b97eb868de1a4', 0, '2018-08-28 07:00:49'),
	('db513e8b48f3232dd8ab6fa8c7cff8703a9c64936855ee66903f2a267d85f4764963dbf94647b5f9', '63e12c0b10d5b4f0f33900ee53be97b3a35564ecf085ecadd61896872911afa974773550aea2727d', 0, '2018-08-28 07:38:33'),
	('dc2a7e7884c80876c9c0f2bb944801fa064973d449a8ce6af6981741f118909f42bcdb4d0f0b88df', 'f53cd16618b3bff5375389a875167db5f53486602ee20156eeb38f592dee6cf214a0b5be12a36478', 0, '2018-08-25 20:40:09'),
	('e0de86d19a71ac58b843c1af593a067b264afb376bd3c5e0cabf1944b99d500e745b3b2588557743', 'f37df34d0de72b6d57d3b1e6253c878044c2d732e69542a2b91cad3f686093ac0bc9a344034456ad', 0, '2018-08-25 21:27:42'),
	('e69469a9de36f4b2f37e4b575011a2e47f7ec53d75b2dcec3ba3d84acb669bdcbc6d1acbc3956501', '68488ef7ea0cad99373ddee5d7f31740c83f159c4ebfc3a5a59d8a8985be399020e02effe5d307b5', 0, '2018-08-25 17:45:51'),
	('eb4f6e82416faff616bf0c91acddbaf0678f47d7deef5e56a4d91a73dfc7dccd9334974bc3aa1879', '3021fa8178de500e212bae03c2fcfc93d8f82ebe4e9dca314ad11af9b09d1e3540fba9491bf31569', 0, '2018-08-25 21:29:38'),
	('ed7d1d448185c7386158990a4fcf2849ab58f224ba9a0710f9d6abb2921ecd1f4b3b369c5037d2aa', '1c06eb656617a138bc45f1ba48b84442638f8049488ebefb3046d5eab4437a744f0802642158df07', 0, '2018-08-28 08:51:27'),
	('ef3f1ace810fcc348677f10c84dcedc62b3717194faa6b769659f9b79aae1777a1dc17e3481cb84e', '3f9ca87d690da53e913cf48282f8c6bed083562d4a9a6d0ed3d141c16e0588decdc12cfc44d40ba4', 0, '2018-08-27 20:58:54'),
	('f0fbd46c433d117af2a81bfb2a933bfe09b225fc42ea8288fb39fda40407e2dd71b93f47737030a8', '09d8ac5b496e34fe60cfe27b989870ba1cea06e0576bc1a628305f4c2fb1039f73526110cd216215', 0, '2018-08-25 21:29:53'),
	('f667514edc4fa540285d02eca1cf8e0f82851ffd04ae097d0be94255d97aa633f05f6e3eef9fb031', '41723f984a1ca4c59bc14e878b430612e49c318ad5ee1da65af1282c7ac168a0377f2fd694db8ff8', 0, '2018-08-06 08:25:12'),
	('f95500d056a9c24131005d6c939c062d06046f547889986d946e5d5ea250773c832c37d3d0a74759', 'da204899f3929c14be3a7f2ec4be42f5d42af71c7e3d8a5301733b3681d3c128a382b72d4677f7ba', 0, '2018-08-27 20:56:38'),
	('f9d59508682e1e84735fa03b36466b2477b5c33eb165639a950ef9441fca394b3701250317df2801', '9cd5921f51a487bca0fcd13bdef52fb515130252805800a13d8353a60d1b50816f3e4b4527a70f89', 0, '2018-08-28 08:53:49'),
	('fb3ef57533ec42372170cd1e17d46b8afba1a0917cc4731c876d4818393ef53d0cf7f6e63eae9baa', 'e2cffbbf42cdff3a358bca5a5298fce06babfb4ccca65f0b8a93e20681ef38447212de62fa95fa93', 0, '2018-08-28 08:40:38'),
	('fbfeb8b6921c82cd6affdd3497a485c066b8a787a6fc5c4e6a46ac2259630f9a256aa2c46dc7920b', 'c21175cf72537d30925f9ada5397533c44a7b8ee1e7ce9e985197ab3bbe9a6fda04e5d8010616b47', 0, '2018-08-28 08:53:19'),
	('fd95380546ce6ae7e34e4640f7780c9abcfb0ee9067c631e2e3d0b387d89f165d60bbec54fe6b259', 'd72fdb664b2f1395a887ff5c8e84ce7b5f8d80cbf5ca2f1936a3cb6325dbb1ca2a314819a4e08301', 0, '2018-08-25 20:50:59'),
	('fea786552520ce75d262dae52f113efdba92958458e58298a683d1473ce8634706c588f9adbed9f9', '517dd2a06a2051e83846002fb17bff825420129f814fc49f62a6d6a3d0e51b47edcb82c43c5808ba', 0, '2018-08-06 08:23:23'),
	('ffbd6970124df6e5853c2c1084c221617bacddf2a130a93cabec423275e9e7dc79c16abf4e013675', '455dee90b9da16c38030a0683837bffea34482d364ac2e14f5bfdf5d8b4da0f380120afeb3821d67', 0, '2018-08-28 09:03:28');
/*!40000 ALTER TABLE `oauth_refresh_tokens` ENABLE KEYS */;

-- Volcando estructura para tabla krece.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla krece.password_resets: ~0 rows (aproximadamente)
DELETE FROM `password_resets`;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
INSERT INTO `password_resets` (`email`, `token`, `created_at`) VALUES
	('fernando2684@gmail.com', '$2y$10$su2cKR/e1uz0gY81xe2FxucSTWj7fJ4TrBgudxRLdQu1P2NNzGxJy', '2017-12-27 22:24:33');
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;

-- Volcando estructura para tabla krece.payment
CREATE TABLE IF NOT EXISTS `payment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `resolution_id` int(11) NOT NULL,
  `public_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `bank_account_id` int(11) NOT NULL,
  `observations` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `payment_method_id` tinyint(4) NOT NULL,
  `currency_code` varchar(3) DEFAULT NULL,
  `type_id` char(2) NOT NULL,
  `status_id` tinyint(4) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL COMMENT 'permite asociar un pago de tipo ingreso a uno de tipo  egreso',
  `isInvoice` bit(1) NOT NULL,
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `payment_id_company_id_type_id` (`resolution_id`,`account_id`,`type_id`),
  KEY `FK_payment_customer` (`customer_id`),
  KEY `FK_payment_type` (`type_id`),
  KEY `FK_payment_status` (`status_id`),
  KEY `FK_payment_payment_method_id` (`payment_method_id`),
  KEY `FK_payment_bank` (`bank_account_id`),
  KEY `FK_payment_account` (`account_id`),
  KEY `FK_payment_user` (`user_id`),
  CONSTRAINT `FK_payment_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_payment_bank` FOREIGN KEY (`bank_account_id`) REFERENCES `bank_account` (`id`),
  CONSTRAINT `FK_payment_customer` FOREIGN KEY (`customer_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `FK_payment_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`id`),
  CONSTRAINT `FK_payment_status` FOREIGN KEY (`status_id`) REFERENCES `payment_status` (`id`),
  CONSTRAINT `FK_payment_type` FOREIGN KEY (`type_id`) REFERENCES `payment_type` (`type`),
  CONSTRAINT `FK_payment_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.payment: ~13 rows (aproximadamente)
DELETE FROM `payment`;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` (`id`, `resolution_id`, `public_id`, `user_id`, `account_id`, `customer_id`, `date`, `bank_account_id`, `observations`, `notes`, `payment_method_id`, `currency_code`, `type_id`, `status_id`, `parent_id`, `isInvoice`, `isDeleted`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, 1, 1, '2017-04-13', 1, NULL, NULL, 2, 'COP', 'eg', 1, NULL, b'0', b'0', '2017-04-13 21:25:29', '2017-09-08 15:43:44', NULL),
	(2, 1, 2, 1, 1, 1, '2017-08-29', 1, NULL, NULL, 2, 'COP', 'in', 1, NULL, b'0', b'1', '2017-08-29 19:08:19', '2017-09-07 08:59:09', '2017-09-07 08:59:09'),
	(3, 2, 3, 1, 1, 1, '2017-08-29', 2, NULL, NULL, 1, 'COP', 'in', 2, NULL, b'1', b'0', '2017-08-29 20:21:22', '2018-10-23 21:50:43', NULL),
	(4, 3, 4, 1, 1, 1, '2017-09-01', 1, 'asas', 'asas', 1, 'COP', 'in', 1, NULL, b'1', b'0', '2017-09-01 22:17:25', '2018-10-23 21:44:35', NULL),
	(24, 4, 5, 1, 1, 1, '2017-09-06', 1, NULL, 'asas', 1, 'COP', 'in', 1, NULL, b'1', b'0', '2017-09-06 10:52:20', '2017-09-06 10:52:20', NULL),
	(25, 5, 6, 1, 1, 1, '2017-09-06', 1, 'test obervaciones', 'test', 2, 'COP', 'in', 1, NULL, b'1', b'0', '2017-09-06 10:54:51', '2017-09-06 10:54:51', NULL),
	(26, 6, 7, 1, 1, 1, '2017-09-06', 1, NULL, 'notas', 2, 'COP', 'in', 1, NULL, b'1', b'0', '2017-09-06 10:57:35', '2017-09-06 10:57:35', NULL),
	(27, 7, 8, 1, 1, 1, '2017-09-07', 1, NULL, 'asas', 1, 'COP', 'in', 1, NULL, b'0', b'0', '2017-09-06 21:25:05', '2017-09-06 21:25:05', NULL),
	(31, 8, 9, 1, 1, 1, '2017-09-07', 1, NULL, 'asasa', 1, 'COP', 'in', 1, NULL, b'0', b'0', '2017-09-06 21:31:49', '2017-09-06 21:31:49', NULL),
	(32, 9, 10, 1, 1, 1, '2017-09-07', 1, NULL, 'asas', 1, 'COP', 'in', 1, NULL, b'0', b'1', '2017-09-07 08:54:55', '2018-10-23 21:43:14', '2018-10-23 21:43:14'),
	(33, 10, 11, 1, 1, 1, '2017-09-07', 1, NULL, 'asas', 1, 'COP', 'in', 1, NULL, b'0', b'0', '2017-09-07 08:57:52', '2017-09-07 08:57:52', NULL),
	(34, 2, 12, 1, 1, 1, '2017-09-08', 1, 'asas', 'as', 2, 'COP', 'eg', 1, NULL, b'1', b'0', '2017-09-08 16:13:57', '2017-09-08 16:13:57', NULL),
	(35, 11, 13, 1, 1, 2, '2017-09-20', 1, 'OBSERVACIONES', 'NOTAS COMPROBANTE DE PAGO', 1, 'COP', 'in', 1, NULL, b'0', b'0', '2017-09-20 09:48:21', '2018-10-23 21:43:35', '2018-10-23 21:43:35');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;

-- Volcando estructura para tabla krece.payment_history
CREATE TABLE IF NOT EXISTS `payment_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `payment_id` bigint(20) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `invoice_sale_order_id` int(11) DEFAULT NULL,
  `bill_id` int(11) DEFAULT NULL,
  `amount` float NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `FK_payment_history_account_id` (`account_id`),
  KEY `FK_payment_history_user` (`user_id`),
  KEY `FK_payment_history_payment` (`payment_id`),
  CONSTRAINT `FK_payment_history_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_payment_history_payment` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`),
  CONSTRAINT `FK_payment_history_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.payment_history: ~9 rows (aproximadamente)
DELETE FROM `payment_history`;
/*!40000 ALTER TABLE `payment_history` DISABLE KEYS */;
INSERT INTO `payment_history` (`id`, `account_id`, `payment_id`, `user_id`, `invoice_sale_order_id`, `bill_id`, `amount`, `created_at`, `updated_at`) VALUES
	(1, 1, 3, 1, 14, NULL, 267, '2017-09-04 21:52:21', '2017-09-04 21:52:21'),
	(2, 1, 4, 1, 13, NULL, 235, '2017-09-04 21:53:00', '2017-09-04 21:53:00'),
	(3, 1, 4, 1, 13, NULL, 235, '2017-09-04 21:53:00', '2017-09-04 21:53:00'),
	(4, 1, 24, 1, 14, NULL, 267, '2017-09-06 10:52:20', '2017-09-06 10:52:20'),
	(5, 1, 24, 1, 13, NULL, 470, '2017-09-06 10:52:20', '2017-09-06 10:52:20'),
	(6, 1, 25, 1, 14, NULL, 2000, '2017-09-06 10:54:51', '2017-09-06 10:54:51'),
	(7, 1, 25, 1, 12, NULL, 500, '2017-09-06 10:54:51', '2017-09-06 10:54:51'),
	(8, 1, 25, 1, 9, NULL, 300, '2017-09-06 10:54:51', '2017-09-06 10:54:51'),
	(9, 1, 26, 1, 14, NULL, 500, '2017-09-06 10:57:35', '2017-09-06 10:57:35'),
	(10, 1, 26, 1, 13, NULL, 300, '2017-09-06 10:57:35', '2017-09-06 10:57:35'),
	(11, 1, 26, 1, 12, NULL, 200, '2017-09-06 10:57:35', '2017-09-06 10:57:35'),
	(12, 1, 34, 1, NULL, 6, 2000, '2017-09-08 16:13:57', '2017-09-08 16:13:57');
/*!40000 ALTER TABLE `payment_history` ENABLE KEYS */;

-- Volcando estructura para tabla krece.payment_method
CREATE TABLE IF NOT EXISTS `payment_method` (
  `id` tinyint(4) NOT NULL,
  `name` varchar(50) NOT NULL,
  `isActive` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='paymeth method list';

-- Volcando datos para la tabla krece.payment_method: ~6 rows (aproximadamente)
DELETE FROM `payment_method`;
/*!40000 ALTER TABLE `payment_method` DISABLE KEYS */;
INSERT INTO `payment_method` (`id`, `name`, `isActive`) VALUES
	(1, 'Efectivo', b'1'),
	(2, 'Consignación', b'1'),
	(3, 'Transferencia', b'1'),
	(4, 'Cheque', b'1'),
	(5, 'Tarjeta crédito', b'1'),
	(6, 'Tarjeta débito', b'1');
/*!40000 ALTER TABLE `payment_method` ENABLE KEYS */;

-- Volcando estructura para tabla krece.payment_status
CREATE TABLE IF NOT EXISTS `payment_status` (
  `id` tinyint(4) NOT NULL,
  `description` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.payment_status: ~4 rows (aproximadamente)
DELETE FROM `payment_status`;
/*!40000 ALTER TABLE `payment_status` DISABLE KEYS */;
INSERT INTO `payment_status` (`id`, `description`) VALUES
	(1, 'Aplicado'),
	(2, 'Anulado'),
	(3, 'Devuelto'),
	(4, 'Completo');
/*!40000 ALTER TABLE `payment_status` ENABLE KEYS */;

-- Volcando estructura para tabla krece.payment_terms
CREATE TABLE IF NOT EXISTS `payment_terms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `public_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `days` int(11) NOT NULL,
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_company_id_name_days` (`account_id`,`name`,`days`,`isDeleted`),
  KEY `FK_payment_terms_user` (`user_id`),
  CONSTRAINT `FK_payment_terms_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_payment_terms_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.payment_terms: ~18 rows (aproximadamente)
DELETE FROM `payment_terms`;
/*!40000 ALTER TABLE `payment_terms` DISABLE KEYS */;
INSERT INTO `payment_terms` (`id`, `account_id`, `user_id`, `public_id`, `name`, `days`, `isDeleted`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, 'Vencimiento manual', 0, b'0', NULL, '2017-04-12 09:26:15', NULL),
	(2, 1, 1, 2, 'De contado', 0, b'0', NULL, '2017-04-12 09:26:15', NULL),
	(3, 1, 1, 3, '8 días', 8, b'0', NULL, '2017-04-12 09:26:15', NULL),
	(4, 1, 1, 4, '15 días', 15, b'0', NULL, '2017-04-12 09:26:15', NULL),
	(5, 1, 1, 5, '30 días', 30, b'0', NULL, '2018-09-09 20:44:12', NULL),
	(6, 1, 1, 6, '60 días', 60, b'1', NULL, '2017-09-14 18:04:58', '2017-09-14 18:04:58'),
	(7, 2, 2, 1, 'Vencimiento manual', 0, b'0', NULL, '2017-08-06 23:23:32', NULL),
	(8, 2, 2, 2, 'De contado', 0, b'0', NULL, '2017-08-06 23:23:32', NULL),
	(9, 2, 2, 3, '8 días', 8, b'0', NULL, '2017-08-06 23:23:32', NULL),
	(10, 2, 2, 4, '15 días', 15, b'0', NULL, '2017-08-06 23:23:32', NULL),
	(11, 2, 2, 5, '30 días', 30, b'0', NULL, '2017-08-06 23:23:32', NULL),
	(12, 2, 2, 6, '60 días', 60, b'0', NULL, '2017-08-06 23:23:32', NULL),
	(13, 1, 1, 7, 'test1', 20, b'1', '2017-09-14 18:01:31', '2017-09-14 18:04:56', '2017-09-14 18:04:56'),
	(14, 1, 1, 8, 'prueba', 23, b'1', '2017-09-14 18:05:31', '2017-09-14 19:55:59', '2017-09-14 19:55:59'),
	(15, 1, 1, 9, 'Prueba 8', 0, b'1', '2017-09-14 21:40:53', '2017-09-14 21:41:03', '2017-09-14 21:41:03'),
	(16, 1, 1, 10, 'prueba 81912esasa', 23, b'1', '2018-09-09 20:19:15', '2018-09-09 20:43:56', '2018-09-09 20:43:56'),
	(17, 1, 1, 11, 'test1', 12, b'1', '2018-09-09 20:22:32', '2018-09-09 20:44:01', '2018-09-09 20:44:01'),
	(18, 1, 1, 12, 'prueba21245456', 12, b'1', '2018-09-09 20:25:10', '2018-09-09 20:42:56', '2018-09-09 20:42:56');
/*!40000 ALTER TABLE `payment_terms` ENABLE KEYS */;

-- Volcando estructura para tabla krece.payment_type
CREATE TABLE IF NOT EXISTS `payment_type` (
  `type` char(2) NOT NULL,
  `description` char(20) NOT NULL,
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='determines if the payment is D or C';

-- Volcando datos para la tabla krece.payment_type: ~2 rows (aproximadamente)
DELETE FROM `payment_type`;
/*!40000 ALTER TABLE `payment_type` DISABLE KEYS */;
INSERT INTO `payment_type` (`type`, `description`) VALUES
	('eg', 'Credito'),
	('in', 'Debito');
/*!40000 ALTER TABLE `payment_type` ENABLE KEYS */;

-- Volcando estructura para tabla krece.payment_withholding_tax
CREATE TABLE IF NOT EXISTS `payment_withholding_tax` (
  `withholding_tax_values_id` int(11) NOT NULL,
  `payment_id` bigint(20) NOT NULL,
  PRIMARY KEY (`withholding_tax_values_id`,`payment_id`),
  KEY `FK_wht_tax_values_payment` (`payment_id`),
  CONSTRAINT `FK_wht_tax_values_id` FOREIGN KEY (`withholding_tax_values_id`) REFERENCES `invoice_withholding_tax_values` (`id`),
  CONSTRAINT `FK_wht_tax_values_payment` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.payment_withholding_tax: ~0 rows (aproximadamente)
DELETE FROM `payment_withholding_tax`;
/*!40000 ALTER TABLE `payment_withholding_tax` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_withholding_tax` ENABLE KEYS */;

-- Volcando estructura para tabla krece.product
CREATE TABLE IF NOT EXISTS `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `public_id` int(11) NOT NULL COMMENT 'id of item by company',
  `user_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `reference` varchar(50) DEFAULT NULL,
  `sale_price` float NOT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `list_price_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `inv_quantity_initial` int(11) DEFAULT NULL,
  `inv_quantity_actual` int(11) DEFAULT NULL,
  `inv_type_id` int(11) DEFAULT NULL,
  `inv_unit_cost` float DEFAULT NULL,
  `inv_inStock` bit(1) DEFAULT b'0',
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `isActive` bit(1) NOT NULL DEFAULT b'1',
  `created_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_products_public_id_account_id` (`public_id`,`account_id`),
  KEY `FK_products_tax` (`tax_id`),
  KEY `id_auto` (`id`),
  KEY `FK_products_account` (`account_id`),
  KEY `FK_products_user` (`user_id`),
  KEY `FK_products_category` (`category_id`),
  KEY `FK_products_inv_type` (`inv_type_id`),
  KEY `FK_products_listprice` (`list_price_id`),
  CONSTRAINT `FK_products_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_products_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `FK_products_inv_type` FOREIGN KEY (`inv_type_id`) REFERENCES `product_inventory_type` (`id`),
  CONSTRAINT `FK_products_listprice` FOREIGN KEY (`list_price_id`) REFERENCES `list_price` (`id`),
  CONSTRAINT `FK_products_tax` FOREIGN KEY (`tax_id`) REFERENCES `tax` (`id`),
  CONSTRAINT `FK_products_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.product: ~9 rows (aproximadamente)
DELETE FROM `product`;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` (`id`, `public_id`, `user_id`, `account_id`, `name`, `description`, `reference`, `sale_price`, `tax_id`, `list_price_id`, `category_id`, `inv_quantity_initial`, `inv_quantity_actual`, `inv_type_id`, `inv_unit_cost`, `inv_inStock`, `isDeleted`, `isActive`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, 'item venta 23', NULL, NULL, 2000, 1, 1, 7, NULL, NULL, NULL, 0, b'0', b'1', b'1', '2018-08-11 22:25:49', '2018-08-11 22:25:49', '2018-08-11 22:25:49'),
	(2, 2, 1, 1, 'producto 23', 'prueba de producto', 'mi ref 2', 304922, 1, 1, 7, NULL, NULL, NULL, 0, b'0', b'0', b'0', '2018-08-11 22:18:37', '2018-08-11 22:18:37', NULL),
	(3, 3, 1, 1, 'prueba 13012017 1', 'esta es una descripción de prueba', 'HGAL124', 30000, 1, 1, 2, 200, NULL, 8, 0, b'1', b'1', b'1', '2018-08-11 22:01:02', '2018-08-11 22:01:02', '2018-08-11 22:01:02'),
	(4, 4, 1, 1, 'alcancia prueba', 'descripción alcancia prueba', '127ngas', 5000, 2, 1, 7, 300, NULL, 2, 2500, b'1', b'1', b'1', '2018-07-24 21:12:38', '2018-07-24 21:12:38', '2018-07-24 21:12:38'),
	(5, 5, 1, 1, 'Computadro XBGR', 'computador de escritorio', 'REF1234', 20000, 1, 1, 3, NULL, NULL, NULL, 0, b'0', b'0', b'1', '2018-08-11 22:26:36', '2018-08-11 22:26:36', NULL),
	(6, 6, 1, 1, 'teas112', NULL, '12', 12123, 1, NULL, 3, NULL, NULL, NULL, 0, b'0', b'1', b'1', '2018-08-11 22:32:22', '2018-08-11 22:32:22', '2018-08-11 22:32:22'),
	(7, 7, 1, 1, 'tes12', NULL, 'as', 123312, 1, NULL, 3, NULL, NULL, NULL, 0, b'0', b'0', b'1', '2018-08-11 22:32:47', '2018-08-11 22:32:47', NULL),
	(8, 8, 1, 1, 'orueba341', NULL, '1212', 1223410, 1, NULL, 3, NULL, NULL, NULL, 0, b'0', b'1', b'1', '2018-08-11 22:39:36', '2018-08-11 22:39:36', '2018-08-11 22:39:36'),
	(9, 9, 1, 1, 'computador XBGS', NULL, 'XSVC', 124567, 1, NULL, 3, NULL, NULL, NULL, 0, b'0', b'0', b'1', '2018-08-11 22:40:09', '2018-08-11 22:40:09', NULL);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;

-- Volcando estructura para tabla krece.product_inventory_type
CREATE TABLE IF NOT EXISTS `product_inventory_type` (
  `id` int(11) NOT NULL,
  `measure_unit` varchar(50) NOT NULL,
  `measure_type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='just applies for products that are cataloged as inventory, like products.\r\nServices commonly does not have inventory.';

-- Volcando datos para la tabla krece.product_inventory_type: ~16 rows (aproximadamente)
DELETE FROM `product_inventory_type`;
/*!40000 ALTER TABLE `product_inventory_type` DISABLE KEYS */;
INSERT INTO `product_inventory_type` (`id`, `measure_unit`, `measure_type`) VALUES
	(1, 'Unidad', 'Unidad'),
	(2, 'Servicio', 'Unidad'),
	(3, 'Pieza', 'Unidad'),
	(4, 'Centimetro (cm)', 'Longitud'),
	(5, 'Metro (m)', 'Longitud'),
	(6, 'Pulgada', 'Longitud'),
	(7, 'Centímetro cuadrado (cm2)', 'Área'),
	(8, 'Metro cuadrado (m2)', 'Área'),
	(9, 'Pulgada cuadrada', 'Área'),
	(10, 'Mililitro (mL)', 'Volumen'),
	(11, 'Litro (L)', 'Volumen'),
	(12, 'Galón', 'Volumen'),
	(13, 'Gramo (g)', 'Peso'),
	(14, 'Kilogramo (kg)', 'Peso'),
	(15, 'Tonelada', 'Peso'),
	(16, 'Libra', 'Peso');
/*!40000 ALTER TABLE `product_inventory_type` ENABLE KEYS */;

-- Volcando estructura para tabla krece.purchase_order
CREATE TABLE IF NOT EXISTS `purchase_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL COMMENT 'related with client that will receive the invoice',
  `public_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `resolution_id` int(11) NOT NULL COMMENT 'resolution DIAN #',
  `customer_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `due_date` date NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `status_id` int(11) NOT NULL COMMENT 'Status of the invoice that could be open, closed, revoked',
  `notes` text DEFAULT NULL COMMENT 'vissible inf the supplier invoice',
  `observations` text DEFAULT NULL COMMENT 'for customer tracking , just internal',
  `terms` text DEFAULT NULL,
  `exchange_rate` float DEFAULT NULL,
  `sub_total` float DEFAULT NULL,
  `total_discounts` float DEFAULT NULL,
  `total_taxes` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `isDeleted` bit(1) DEFAULT b'0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_supp_company_id_document_number` (`account_id`,`resolution_id`),
  KEY `FK_purchase_order_currency` (`currency_code`),
  KEY `FK_purchase_order_customerID` (`customer_id`),
  KEY `FK_purchase_order_status` (`status_id`),
  KEY `FK_PO_user` (`user_id`),
  CONSTRAINT `FK_PO_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_purchase_order_caccount` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_purchase_order_currency` FOREIGN KEY (`currency_code`) REFERENCES `currency_code` (`code`),
  CONSTRAINT `FK_purchase_order_customerID` FOREIGN KEY (`customer_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `FK_purchase_order_status` FOREIGN KEY (`status_id`) REFERENCES `purchase_order_status` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='Header of supplier invoices';

-- Volcando datos para la tabla krece.purchase_order: ~3 rows (aproximadamente)
DELETE FROM `purchase_order`;
/*!40000 ALTER TABLE `purchase_order` DISABLE KEYS */;
INSERT INTO `purchase_order` (`id`, `account_id`, `public_id`, `user_id`, `resolution_id`, `customer_id`, `date`, `due_date`, `currency_code`, `status_id`, `notes`, `observations`, `terms`, `exchange_rate`, `sub_total`, `total_discounts`, `total_taxes`, `total`, `isDeleted`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, 1, 1, '2017-09-08', '2017-10-08', 'COP', 1, 'notas-...', 'observa', 'terminos y condiciones', NULL, 0, 0, 0, 0, b'1', '2017-09-08 13:39:58', '2017-09-08 15:19:51', '2017-09-08 15:19:51'),
	(2, 1, 2, 1, 2, 1, '2017-09-08', '2017-10-08', 'COP', 1, 'Notas orden compra 2', 'obsr po', 'terminos po2', NULL, 158955, 12445.5, 21281.8, 167791, b'0', '2017-09-08 15:12:33', '2017-09-08 15:16:40', NULL),
	(3, 1, 3, 1, 3, 1, '2017-09-08', '2017-10-08', 'COP', 1, 'Notas orden de compra 3', NULL, NULL, NULL, 1053860, 31917.6, 139590, 1161530, b'0', '2017-09-08 15:20:54', '2017-09-08 15:21:08', NULL);
/*!40000 ALTER TABLE `purchase_order` ENABLE KEYS */;

-- Volcando estructura para tabla krece.purchase_order_detail
CREATE TABLE IF NOT EXISTS `purchase_order_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'header invoice number',
  `purchase_order_id` bigint(20) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL,
  `unit_price` float NOT NULL,
  `discount` float DEFAULT NULL,
  `tax_amount` float DEFAULT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `total` float NOT NULL,
  `total_tax` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_purchase_order_detail_company` (`user_id`),
  KEY `FK_purchase_order_purchase_order_detail` (`purchase_order_id`),
  KEY `FK_purchase_order_detail_tax_id` (`tax_id`),
  KEY `FK_PO_detail_category` (`category_id`),
  KEY `FK_Po_detail_product` (`product_id`),
  CONSTRAINT `FK_PO_detail_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `FK_Po_detail_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FK_purchase_order_detail_po` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_order` (`id`),
  CONSTRAINT `FK_purchase_order_detail_tax_id` FOREIGN KEY (`tax_id`) REFERENCES `tax` (`id`),
  CONSTRAINT `FK_purchase_order_detail_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 COMMENT='detail of the invoice generated';

-- Volcando datos para la tabla krece.purchase_order_detail: ~6 rows (aproximadamente)
DELETE FROM `purchase_order_detail`;
/*!40000 ALTER TABLE `purchase_order_detail` DISABLE KEYS */;
INSERT INTO `purchase_order_detail` (`id`, `purchase_order_id`, `user_id`, `unit_price`, `discount`, `tax_amount`, `tax_id`, `category_id`, `product_id`, `name`, `description`, `quantity`, `total`, `total_tax`, `created_at`, `updated_at`) VALUES
	(2, 1, 1, 0, 0, 0, NULL, 9, NULL, 'Alquiler de equipos y licencias', NULL, 1, 0, 0, '2017-09-08 14:27:56', '2017-09-08 14:27:56'),
	(5, 2, 1, 124455, 10, 19, 1, 12, NULL, NULL, NULL, 1, 112010, 21281.8, '2017-09-08 15:16:40', '2017-09-08 15:16:40'),
	(6, 2, 1, 34500, 0, 0, NULL, 13, NULL, NULL, NULL, 1, 34500, 0, '2017-09-08 15:16:40', '2017-09-08 15:16:40'),
	(10, 3, 1, 1023, 10, NULL, NULL, 13, NULL, NULL, NULL, 312, 287258, 0, '2017-09-08 15:21:08', '2017-09-08 15:21:08'),
	(11, 3, 1, 13421, 0, 19, 2, 11, NULL, NULL, NULL, 23, 308683, 58649.8, '2017-09-08 15:21:08', '2017-09-08 15:21:08'),
	(12, 3, 1, 2000, 0, 19, 1, 5, NULL, NULL, NULL, 213, 426000, 80940, '2017-09-08 15:21:08', '2017-09-08 15:21:08');
/*!40000 ALTER TABLE `purchase_order_detail` ENABLE KEYS */;

-- Volcando estructura para tabla krece.purchase_order_status
CREATE TABLE IF NOT EXISTS `purchase_order_status` (
  `id` int(11) NOT NULL,
  `description` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.purchase_order_status: ~3 rows (aproximadamente)
DELETE FROM `purchase_order_status`;
/*!40000 ALTER TABLE `purchase_order_status` DISABLE KEYS */;
INSERT INTO `purchase_order_status` (`id`, `description`) VALUES
	(1, 'Borrador'),
	(2, 'Anulada'),
	(3, 'Facturada');
/*!40000 ALTER TABLE `purchase_order_status` ENABLE KEYS */;

-- Volcando estructura para tabla krece.remision
CREATE TABLE IF NOT EXISTS `remision` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `public_id` int(11) DEFAULT NULL,
  `resolution_id` int(11) DEFAULT NULL,
  `seller_id` int(11) DEFAULT NULL,
  `list_price_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `currency_code` varchar(3) DEFAULT NULL,
  `document_type_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `sub_total` float DEFAULT NULL,
  `total_discounts` float DEFAULT NULL,
  `total_taxes` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `observations` varchar(255) DEFAULT NULL,
  `exchange_rate` float DEFAULT NULL,
  `isDeleted` bit(1) DEFAULT b'0',
  `created_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_remision_account_id_public_id` (`account_id`,`public_id`),
  KEY `FK_remision_seller` (`seller_id`),
  KEY `FK_remision_list_price` (`list_price_id`),
  KEY `FK_remision_customer` (`customer_id`),
  KEY `FK_remision_document_type` (`document_type_id`),
  KEY `FK_remision_currency` (`currency_code`),
  KEY `FK_remision_user` (`user_id`),
  KEY `FK_remision_status` (`status_id`),
  CONSTRAINT `FK_remision_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_remision_currency` FOREIGN KEY (`currency_code`) REFERENCES `currency_code` (`code`),
  CONSTRAINT `FK_remision_customer` FOREIGN KEY (`customer_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `FK_remision_document_type` FOREIGN KEY (`document_type_id`) REFERENCES `remision_document_type` (`id`),
  CONSTRAINT `FK_remision_list_price` FOREIGN KEY (`list_price_id`) REFERENCES `list_price` (`id`),
  CONSTRAINT `FK_remision_seller` FOREIGN KEY (`seller_id`) REFERENCES `seller` (`id`),
  CONSTRAINT `FK_remision_status` FOREIGN KEY (`status_id`) REFERENCES `remision_status` (`id`),
  CONSTRAINT `FK_remision_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.remision: ~7 rows (aproximadamente)
DELETE FROM `remision`;
/*!40000 ALTER TABLE `remision` DISABLE KEYS */;
INSERT INTO `remision` (`id`, `account_id`, `user_id`, `public_id`, `resolution_id`, `seller_id`, `list_price_id`, `customer_id`, `currency_code`, `document_type_id`, `status_id`, `date`, `due_date`, `sub_total`, `total_discounts`, `total_taxes`, `total`, `notes`, `observations`, `exchange_rate`, `isDeleted`, `created_at`, `deleted_at`, `updated_at`) VALUES
	(1, 1, 1, 1, 1, 1, 1, 1, 'COP', 1, 1, '2017-08-23', '2017-09-23', 4000, 0, 0, 4000, 'test', 'ete', NULL, b'1', '2017-08-23 15:25:30', '2017-08-23 15:26:46', '2017-08-23 15:26:46'),
	(2, 1, 1, 2, 2, 1, 1, 1, 'COP', 1, 1, '2017-08-23', '2017-09-23', 2000, 0, 0, 2000, 'asas', 'as', NULL, b'1', '2017-08-23 15:27:01', '2017-08-23 16:41:56', '2017-08-23 16:41:56'),
	(3, 1, 1, 3, 3, 1, 1, 1, 'COP', 2, 1, '2017-08-23', '2017-09-23', 756010, 0, 2660.13, 758670, '<z<aa', '<z<z', NULL, b'1', '2017-08-23 18:20:28', '2017-09-11 22:20:31', '2017-09-11 22:20:31'),
	(4, 1, 1, 4, 4, 1, 1, 1, 'COP', 2, 2, '2017-08-29', '2017-09-28', 242000, 8640, 43958.4, 277318, 'remision prueba 1', NULL, NULL, b'0', '2017-08-29 09:30:23', NULL, '2017-09-04 22:01:01'),
	(5, 1, 1, 5, 5, 1, 1, 1, 'COP', 1, 1, '2017-09-11', '2017-10-11', 2000, 0, 0, 2000, 'asas', NULL, NULL, b'0', '2017-09-11 18:57:00', NULL, '2017-09-11 18:57:00'),
	(6, 1, 1, 6, 6, 1, 1, 1, 'COP', 1, 1, '2017-09-11', '2017-10-11', 2000, 0, 0, 2000, 'asas', NULL, NULL, b'0', '2017-09-11 18:57:33', NULL, '2017-09-11 18:57:45'),
	(7, 1, 1, 7, 7, 1, 1, 1, 'COP', 1, 1, '2017-09-12', '2017-10-12', 2000, 0, 0, 2000, 'remision 7', NULL, NULL, b'0', '2017-09-11 19:36:19', NULL, '2017-09-11 19:36:19');
/*!40000 ALTER TABLE `remision` ENABLE KEYS */;

-- Volcando estructura para tabla krece.remision_detail
CREATE TABLE IF NOT EXISTS `remision_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `remision_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `reference` varchar(50) DEFAULT NULL,
  `unit_price` float NOT NULL,
  `discount` float DEFAULT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `tax_amount` float DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `total` float DEFAULT NULL,
  `total_tax` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_remision_detail_remision_id` (`remision_id`),
  KEY `FK_remision_detail_item` (`product_id`),
  KEY `FK_remision_detail_tax` (`tax_id`),
  KEY `FK_remision_detail_user` (`user_id`),
  CONSTRAINT `FK_remision_detail_item` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FK_remision_detail_remision_id` FOREIGN KEY (`remision_id`) REFERENCES `remision` (`id`),
  CONSTRAINT `FK_remision_detail_tax` FOREIGN KEY (`tax_id`) REFERENCES `tax` (`id`),
  CONSTRAINT `FK_remision_detail_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.remision_detail: ~10 rows (aproximadamente)
DELETE FROM `remision_detail`;
/*!40000 ALTER TABLE `remision_detail` DISABLE KEYS */;
INSERT INTO `remision_detail` (`id`, `remision_id`, `user_id`, `product_id`, `reference`, `unit_price`, `discount`, `tax_id`, `tax_amount`, `name`, `description`, `quantity`, `total`, `total_tax`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 2000, 0, '2017-08-23 15:25:30', '2017-08-23 15:25:30', NULL),
	(2, 1, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 2000, 0, '2017-08-23 15:25:30', '2017-08-23 15:25:30', NULL),
	(3, 2, 1, 1, NULL, 2000, 0, NULL, 0, NULL, NULL, 1, 2000, 0, '2017-08-23 15:27:01', '2017-08-23 15:27:01', NULL),
	(29, 3, 1, 1, NULL, 8000.54, 0, 1, 19, NULL, NULL, 1, 9520.64, 1520.1, '2017-08-29 13:57:29', '2017-08-29 13:57:29', NULL),
	(30, 3, 1, 1, NULL, 2000.45, 0, NULL, 0, NULL, NULL, 20, 40009, 0, '2017-08-29 13:57:29', '2017-08-29 13:57:29', NULL),
	(31, 3, 1, 1, NULL, 6000.12, 0, 2, 19, NULL, NULL, 1, 7140.14, 1140.02, '2017-08-29 13:57:29', '2017-08-29 13:57:29', NULL),
	(32, 3, 1, 1, NULL, 3000, 0, NULL, 0, NULL, NULL, 234, 702000, 0, '2017-08-29 13:57:29', '2017-08-29 13:57:29', NULL),
	(35, 4, 1, 1, NULL, 80000, 3.6, 1, 19, NULL, 'producto 1', 3, 275318, 43958.4, '2017-08-29 14:07:44', '2017-08-29 14:07:44', NULL),
	(36, 4, 1, 1, NULL, 2000, 0, NULL, 0, NULL, 'producto 3', 1, 2000, 0, '2017-08-29 14:07:44', '2017-08-29 14:07:44', NULL),
	(37, 5, 1, 1, NULL, 2000, 0, NULL, NULL, NULL, NULL, 1, 2000, 0, '2017-09-11 18:57:00', '2017-09-11 18:57:00', NULL),
	(39, 6, 1, 1, NULL, 2000, 0, NULL, NULL, NULL, NULL, 1, 2000, 0, '2017-09-11 18:57:45', '2017-09-11 18:57:45', NULL),
	(40, 7, 1, 1, NULL, 2000, 0, NULL, NULL, NULL, NULL, 1, 2000, 0, '2017-09-11 19:36:19', '2017-09-11 19:36:19', NULL);
/*!40000 ALTER TABLE `remision_detail` ENABLE KEYS */;

-- Volcando estructura para tabla krece.remision_document_type
CREATE TABLE IF NOT EXISTS `remision_document_type` (
  `id` int(11) NOT NULL,
  `description` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.remision_document_type: ~2 rows (aproximadamente)
DELETE FROM `remision_document_type`;
/*!40000 ALTER TABLE `remision_document_type` DISABLE KEYS */;
INSERT INTO `remision_document_type` (`id`, `description`) VALUES
	(1, 'Remision'),
	(2, 'Orden de Servicio');
/*!40000 ALTER TABLE `remision_document_type` ENABLE KEYS */;

-- Volcando estructura para tabla krece.remision_status
CREATE TABLE IF NOT EXISTS `remision_status` (
  `id` int(11) NOT NULL,
  `description` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.remision_status: ~2 rows (aproximadamente)
DELETE FROM `remision_status`;
/*!40000 ALTER TABLE `remision_status` DISABLE KEYS */;
INSERT INTO `remision_status` (`id`, `description`) VALUES
	(1, 'Activo'),
	(2, 'Anulado');
/*!40000 ALTER TABLE `remision_status` ENABLE KEYS */;

-- Volcando estructura para tabla krece.resolution
CREATE TABLE IF NOT EXISTS `resolution` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `public_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `initial_number` varchar(50) DEFAULT NULL,
  `final_number` varchar(50) DEFAULT NULL,
  `next_invoice_number` varchar(50) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `prefix` varchar(10) DEFAULT NULL,
  `invoice_text` varchar(500) DEFAULT NULL,
  `isDefault` bit(1) NOT NULL,
  `isActive` bit(1) NOT NULL DEFAULT b'1',
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `auto_increment` bit(1) NOT NULL DEFAULT b'1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_resolution_account` (`account_id`),
  KEY `FK_resolution_user` (`user_id`),
  CONSTRAINT `FK_resolution_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_resolution_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COMMENT='contains resolution IDs for each sale order, according law policies (DIAN in colombia)';

-- Volcando datos para la tabla krece.resolution: ~7 rows (aproximadamente)
DELETE FROM `resolution`;
/*!40000 ALTER TABLE `resolution` DISABLE KEYS */;
INSERT INTO `resolution` (`id`, `account_id`, `public_id`, `user_id`, `initial_number`, `final_number`, `next_invoice_number`, `name`, `prefix`, `invoice_text`, `isDefault`, `isActive`, `isDeleted`, `auto_increment`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, '1', NULL, '39', 'Principal', NULL, 'Resolución Facturación por computador No 12345678 de 2017/01/01 Rango del 1 al 2000', b'1', b'1', b'0', b'1', '2017-04-12 09:26:15', '2018-06-04 19:11:12', NULL),
	(2, 2, 1, 2, '1', NULL, '1', 'Principal', NULL, NULL, b'1', b'1', b'0', b'1', '2017-08-06 23:23:31', '2017-08-06 23:23:31', NULL),
	(3, 1, 2, 1, '1', NULL, '1', 'numeración2', 'numb2', NULL, b'0', b'0', b'0', b'1', '2017-09-07 14:35:58', '2017-09-18 11:55:42', NULL),
	(4, 1, 3, 1, NULL, NULL, NULL, 'numeracion3', NULL, NULL, b'0', b'0', b'0', b'0', '2017-09-07 15:02:11', '2018-09-09 22:04:17', NULL),
	(5, 1, 4, 1, '1', NULL, '1', 'Prueba 1', NULL, NULL, b'0', b'1', b'1', b'1', '2017-09-14 16:41:25', '2017-09-14 17:36:35', '2017-09-14 17:36:35'),
	(6, 1, 5, 1, '2', NULL, '2', 'test2456', '12', 'esta es la resolución editada', b'0', b'1', b'1', b'1', '2017-09-14 16:44:17', '2017-09-14 17:36:30', '2017-09-14 17:36:30'),
	(7, 1, 6, 1, '1', NULL, '1', 'POS', 'teso', 'esta es la resolución de facturación', b'0', b'0', b'0', b'1', '2017-09-14 20:15:46', '2018-09-09 20:53:35', NULL);
/*!40000 ALTER TABLE `resolution` ENABLE KEYS */;

-- Volcando estructura para tabla krece.resolution_numbers
CREATE TABLE IF NOT EXISTS `resolution_numbers` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `prefix` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `number` int(11) NOT NULL,
  `text` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_resonumb_account_id` (`account_id`),
  CONSTRAINT `FK_resonumb_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla krece.resolution_numbers: ~16 rows (aproximadamente)
DELETE FROM `resolution_numbers`;
/*!40000 ALTER TABLE `resolution_numbers` DISABLE KEYS */;
INSERT INTO `resolution_numbers` (`id`, `account_id`, `key`, `prefix`, `number`, `text`, `created_at`, `updated_at`) VALUES
	(1, 1, 'estimate', NULL, 31, 'Siguiente número de cotizaciones', NULL, '2018-09-09 19:35:20'),
	(2, 1, 'purchase_order', NULL, 4, 'Siguiente número de órdenes de compra', NULL, '2017-09-08 15:20:55'),
	(3, 1, 'credit_note', NULL, 5, 'Siguiente número de nota credito', NULL, '2017-09-03 21:13:42'),
	(4, 1, 'remision', NULL, 8, 'Siguiente número de remisiones', NULL, '2018-09-09 19:35:21'),
	(5, 1, 'in-come', NULL, 12, 'Siguiente número de recibo de caja', NULL, '2017-09-20 09:48:21'),
	(6, 1, 'debit_note', NULL, 5, 'Siguiente número de nota debito', NULL, '2017-09-26 14:11:34'),
	(7, 1, 'bill', NULL, 7, 'Siguiente número de factura de proveedores', NULL, '2017-09-08 14:37:49'),
	(8, 1, 'out-come', NULL, 3, 'Siguiente número de comprobante de pago', NULL, '2017-09-08 16:13:57'),
	(9, 2, 'estimate', NULL, 29, 'Siguiente número de cotizaciones', NULL, '2017-11-13 19:59:14'),
	(10, 2, 'purchase_order', NULL, 4, 'Siguiente número de órdenes de compra', NULL, '2017-09-08 15:20:55'),
	(11, 2, 'credit_note', NULL, 5, 'Siguiente número de nota credito', NULL, '2017-09-03 21:13:42'),
	(12, 2, 'remision', NULL, 8, 'Siguiente número de remisiones', NULL, '2017-09-11 19:36:20'),
	(13, 2, 'in-come', NULL, 10, 'Siguiente número de recibo de caja', NULL, '2017-09-20 09:48:21'),
	(14, 2, 'debit_note', NULL, 4, 'Siguiente número de nota debito', NULL, '2017-09-26 14:11:34'),
	(15, 2, 'bill', NULL, 6, 'Siguiente número de factura de proveedores', NULL, '2017-09-08 14:37:49'),
	(16, 2, 'out-come', NULL, 2, 'Siguiente número de comprobante de pago', NULL, '2017-09-08 16:13:57');
/*!40000 ALTER TABLE `resolution_numbers` ENABLE KEYS */;

-- Volcando estructura para tabla krece.retention
CREATE TABLE IF NOT EXISTS `retention` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `public_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `value` float NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `type_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_wht_type` (`type_id`),
  KEY `FK_wht_company` (`account_id`),
  KEY `FK_wht_user` (`user_id`),
  CONSTRAINT `FK_wht_company` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_wht_type` FOREIGN KEY (`type_id`) REFERENCES `retention_type` (`id`),
  CONSTRAINT `FK_wht_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1 COMMENT='contains the taxes list that each user defines';

-- Volcando datos para la tabla krece.retention: ~26 rows (aproximadamente)
DELETE FROM `retention`;
/*!40000 ALTER TABLE `retention` DISABLE KEYS */;
INSERT INTO `retention` (`id`, `account_id`, `public_id`, `user_id`, `name`, `value`, `description`, `isDeleted`, `type_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, 'Arrendamiento de bienes inmuebles', 4, 'editado234', b'0', 2, NULL, '2018-09-09 21:11:11', NULL),
	(2, 1, 2, 1, 'Arrendamiento de bienes raices', 3.5, 'Retencion aplicada a pagos de arrendamiento de bienes raices', b'0', 2, NULL, '2017-04-12 09:26:15', NULL),
	(3, 1, 3, 1, 'Compras declarantes', 2.5, 'Retencion aplicada a compras declarantes', b'0', 2, NULL, '2017-04-12 09:26:15', NULL),
	(4, 1, 4, 1, 'Compras no declarantes', 3.5, 'Retencion aplicada a compras no declarantes', b'0', 2, NULL, '2017-04-12 09:26:15', NULL),
	(5, 1, 5, 1, 'Honorarios y comisiones (naturales)', 10, 'Retencion aplicada a personas naturales', b'0', 2, NULL, '2017-04-12 09:26:15', NULL),
	(6, 1, 6, 1, 'Honoraios y comisiones (jurídicas)', 11, 'Retencion aplicada a personas juridicas', b'0', 2, NULL, '2017-04-12 09:26:15', NULL),
	(7, 1, 7, 1, 'Servicios de aseo y vigilancia', 2, 'Retencion aplicada a pagos de servicios en aseo y/o vigilancia', b'0', 2, NULL, '2017-04-12 09:26:15', NULL),
	(8, 1, 8, 1, 'Servicios de hoteles y restaurantes', 3.5, 'Retencion aplicada por servicios de hoteles, restaurantes y hospedaje a declarantes y no declarantes', b'0', 2, NULL, '2017-04-12 09:26:15', NULL),
	(9, 1, 9, 1, 'Servicios generales (declarantes)', 4, 'Retencion aplicada a pagos de personas declarantes', b'0', 2, NULL, '2017-04-12 09:26:15', NULL),
	(10, 1, 10, 1, 'Servicios generales (no declarantes)', 6, 'Retencion aplicada a pagos de personas no declarantes', b'0', 2, NULL, '2017-04-12 09:26:15', NULL),
	(11, 1, 11, 1, 'ReteIca', 0, 'Retencion de industria y comercio', b'0', 3, NULL, '2017-04-12 09:26:15', NULL),
	(12, 1, 12, 1, 'ReteIva', 15, 'Retencion sobre el total del IVA asociado a una factura', b'0', 1, NULL, '2017-04-12 09:26:15', NULL),
	(13, 1, 13, 1, 'Transporte de carga', 15, '', b'1', 2, NULL, '2017-09-14 19:55:43', '2017-09-14 19:55:43'),
	(14, 2, 1, 2, 'Arrendamiento de bienes inmuebles', 4, '', b'0', 2, NULL, '2017-08-06 23:23:32', NULL),
	(15, 2, 2, 2, 'Arrendamiento de bienes raices', 3.5, 'Retencion aplicada a pagos de arrendamiento de bienes raices', b'0', 2, NULL, '2017-08-06 23:23:32', NULL),
	(16, 2, 3, 2, 'Compras declarantes', 2.5, 'Retencion aplicada a compras declarantes', b'0', 2, NULL, '2017-08-06 23:23:32', NULL),
	(17, 2, 4, 2, 'Compras no declarantes', 3.5, 'Retencion aplicada a compras no declarantes', b'0', 2, NULL, '2017-08-06 23:23:32', NULL),
	(18, 2, 5, 2, 'Honorarios y comisiones (naturales)', 10, 'Retencion aplicada a personas naturales', b'0', 2, NULL, '2017-08-06 23:23:32', NULL),
	(19, 2, 6, 2, 'Honoraios y comisiones (jurídicas)', 11, 'Retencion aplicada a personas juridicas', b'0', 2, NULL, '2017-08-06 23:23:32', NULL),
	(20, 2, 7, 2, 'Servicios de aseo y vigilancia', 2, 'Retencion aplicada a pagos de servicios en aseo y/o vigilancia', b'0', 2, NULL, '2017-08-06 23:23:32', NULL),
	(21, 2, 8, 2, 'Servicios de hoteles y restaurantes', 3.5, 'Retencion aplicada por servicios de hoteles, restaurantes y hospedaje a declarantes y no declarantes', b'0', 2, NULL, '2017-08-06 23:23:32', NULL),
	(22, 2, 9, 2, 'Servicios generales (declarantes)', 4, 'Retencion aplicada a pagos de personas declarantes', b'0', 2, NULL, '2017-08-06 23:23:32', NULL),
	(23, 2, 10, 2, 'Servicios generales (no declarantes)', 6, 'Retencion aplicada a pagos de personas no declarantes', b'0', 2, NULL, '2017-08-06 23:23:32', NULL),
	(24, 2, 11, 2, 'ReteIca', 0, 'Retencion de industria y comercio', b'0', 3, NULL, '2017-08-06 23:23:32', NULL),
	(25, 2, 12, 2, 'ReteIva', 15, 'Retencion sobre el total del IVA asociado a una factura', b'0', 1, NULL, '2017-08-06 23:23:32', NULL),
	(26, 2, 13, 2, 'Transporte de carga', 15, '', b'0', 2, NULL, '2017-08-06 23:23:32', NULL),
	(27, 1, NULL, 1, 'prueba', 15, 'descripcion test', b'1', 1, '2017-09-14 19:55:29', '2017-09-14 19:55:36', '2017-09-14 19:55:36');
/*!40000 ALTER TABLE `retention` ENABLE KEYS */;

-- Volcando estructura para tabla krece.retention_type
CREATE TABLE IF NOT EXISTS `retention_type` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='this contains the list of with holding tax used by the app';

-- Volcando datos para la tabla krece.retention_type: ~5 rows (aproximadamente)
DELETE FROM `retention_type`;
/*!40000 ALTER TABLE `retention_type` DISABLE KEYS */;
INSERT INTO `retention_type` (`id`, `name`) VALUES
	(1, 'Retención de IVA'),
	(2, 'Retención en la fuente'),
	(3, 'Retención de Industria y Comercio'),
	(4, 'Retención de CREE'),
	(5, 'Otro tipo de retención');
/*!40000 ALTER TABLE `retention_type` ENABLE KEYS */;

-- Volcando estructura para tabla krece.seller
CREATE TABLE IF NOT EXISTS `seller` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `public_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `dni` varchar(50) DEFAULT NULL,
  `work_phone` varchar(255) DEFAULT NULL,
  `private_phone` varchar(255) DEFAULT NULL,
  `observations` text DEFAULT NULL,
  `isEnabled` bit(1) NOT NULL DEFAULT b'1',
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `company_id_local_id` (`account_id`,`public_id`),
  KEY `FK_seller_user` (`user_id`),
  CONSTRAINT `FK_seller_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_seller_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='seller list customized by company';

-- Volcando datos para la tabla krece.seller: ~3 rows (aproximadamente)
DELETE FROM `seller`;
/*!40000 ALTER TABLE `seller` DISABLE KEYS */;
INSERT INTO `seller` (`id`, `account_id`, `user_id`, `public_id`, `name`, `dni`, `work_phone`, `private_phone`, `observations`, `isEnabled`, `isDeleted`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, 'vendedor 1', '80810419', '312454', NULL, 'mi vendedor', b'1', b'1', '2017-08-17 08:38:24', '2018-10-20 23:35:55', '2018-10-20 23:35:55'),
	(2, 1, 1, 2, 'vendedor2', '8122344', '12346', NULL, 'observaciones', b'1', b'0', '2017-09-12 18:12:12', '2017-09-12 18:15:17', NULL),
	(3, 1, 1, 3, 'juan carlos ardila', '12231', '432566', 'qwe', 'as', b'1', b'0', '2017-09-12 18:15:32', '2017-12-10 18:42:52', NULL);
/*!40000 ALTER TABLE `seller` ENABLE KEYS */;

-- Volcando estructura para tabla krece.tax
CREATE TABLE IF NOT EXISTS `tax` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `public_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(10) NOT NULL,
  `amount` float NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `type_id` int(11) NOT NULL,
  `isEditable` bit(1) NOT NULL DEFAULT b'1',
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_taxes_account_id_public_id` (`account_id`,`public_id`),
  KEY `FK_taxes_user` (`user_id`),
  KEY `FK_taxes_type` (`type_id`),
  CONSTRAINT `FK_taxes_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_taxes_type` FOREIGN KEY (`type_id`) REFERENCES `tax_type` (`id`),
  CONSTRAINT `FK_taxes_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COMMENT='contains the taxes list that each user defines';

-- Volcando datos para la tabla krece.tax: ~9 rows (aproximadamente)
DELETE FROM `tax`;
/*!40000 ALTER TABLE `tax` DISABLE KEYS */;
INSERT INTO `tax` (`id`, `account_id`, `public_id`, `user_id`, `name`, `amount`, `description`, `type_id`, `isEditable`, `isDeleted`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, 'IVA', 19, 'IVA', 1, b'1', b'0', NULL, '2017-04-12 09:26:15', NULL),
	(2, 1, 2, 1, 'ICO', 19, 'ICO', 2, b'1', b'0', NULL, '2017-04-12 09:26:15', NULL),
	(3, 1, 3, 1, 'Ninguno', 0, 'Ninguno', 3, b'1', b'0', NULL, '2017-04-12 09:26:15', NULL),
	(4, 2, 1, 2, 'IVA', 19, 'IVA', 1, b'1', b'0', NULL, '2017-08-06 23:23:31', NULL),
	(5, 2, 2, 2, 'ICO', 19, 'ICO', 2, b'1', b'0', NULL, '2017-08-06 23:23:31', NULL),
	(6, 2, 3, 2, 'Ninguno', 0, 'Ninguno', 3, b'1', b'0', NULL, '2017-08-06 23:23:31', NULL),
	(7, 1, 4, 1, 'Test', 12, NULL, 2, b'1', b'1', '2017-09-14 20:06:57', '2017-09-14 20:10:10', '2017-09-14 20:10:10'),
	(8, 1, 5, 1, 'prueba2', 12, 'descripcion', 1, b'1', b'1', '2017-09-14 20:10:27', '2017-09-14 20:13:16', '2017-09-14 20:13:16'),
	(9, 1, 6, 1, 'test4', 12, 'editado', 1, b'1', b'1', '2017-09-14 20:13:26', '2017-09-14 20:13:36', '2017-09-14 20:13:36'),
	(10, 1, 7, 1, 'TEST1', 22, NULL, 1, b'1', b'1', '2018-09-09 21:50:53', '2018-09-09 21:52:50', '2018-09-09 21:52:50'),
	(11, 1, 8, 1, 'test3', 12, NULL, 1, b'1', b'1', '2018-09-09 21:52:31', '2018-09-09 21:52:37', '2018-09-09 21:52:37');
/*!40000 ALTER TABLE `tax` ENABLE KEYS */;

-- Volcando estructura para tabla krece.tax_type
CREATE TABLE IF NOT EXISTS `tax_type` (
  `id` int(11) NOT NULL,
  `name` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='this contains the kind of taxes used inside the app';

-- Volcando datos para la tabla krece.tax_type: ~3 rows (aproximadamente)
DELETE FROM `tax_type`;
/*!40000 ALTER TABLE `tax_type` DISABLE KEYS */;
INSERT INTO `tax_type` (`id`, `name`) VALUES
	(1, 'IVA'),
	(2, 'ICO'),
	(3, 'Otro');
/*!40000 ALTER TABLE `tax_type` ENABLE KEYS */;

-- Volcando estructura para tabla krece.user
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT 1,
  `name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(255) DEFAULT NULL,
  `transaction_token` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `status_id` int(11) DEFAULT 1 COMMENT 'state of the user: active, inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `public_id` int(11) unsigned DEFAULT NULL,
  `oauth_user_id` varchar(255) DEFAULT NULL,
  `oauth_provider_id` int(11) unsigned DEFAULT NULL,
  `is_admin` bit(1) DEFAULT b'1',
  PRIMARY KEY (`id`),
  KEY `FK_user_status` (`status_id`),
  KEY `FK_user_role` (`role_id`),
  KEY `FK_user_accountid` (`account_id`),
  CONSTRAINT `FK_user_accountid` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_user_role` FOREIGN KEY (`role_id`) REFERENCES `user_role` (`id`),
  CONSTRAINT `FK_user_status` FOREIGN KEY (`status_id`) REFERENCES `user_status` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.user: ~2 rows (aproximadamente)
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `account_id`, `role_id`, `name`, `last_name`, `email`, `password`, `remember_token`, `transaction_token`, `phone`, `status_id`, `created_at`, `deleted_at`, `updated_at`, `last_login`, `modified_by`, `created_by`, `public_id`, `oauth_user_id`, `oauth_provider_id`, `is_admin`) VALUES
	(1, 1, 1, 'Fernando2', 'Ardila3345', 'fernando2684@gmail.com', '$2y$10$Q0VM/uttIBoa.C5S5Smvl...xy8XIAe3VDpCvNu/UU8ekKmAk3oHW', '7ywPsRbqKLvgULD8U42eb5Buoy9YqTtMTmmIbtYyQUrX2bCm4DXiayJPJU3b', NULL, NULL, 1, '2017-04-11 18:36:23', NULL, '2019-05-20 19:49:01', '2019-05-20 19:49:01', NULL, NULL, NULL, NULL, NULL, b'1'),
	(2, 2, 1, 'pruebax', NULL, 'fer2@gmail.com', '$2y$10$Q0VM/uttIBoa.C5S5Smvl...xy8XIAe3VDpCvNu/UU8ekKmAk3oHW', NULL, NULL, NULL, 1, '2017-08-06 23:23:19', NULL, '2017-08-06 23:23:19', NULL, NULL, NULL, NULL, NULL, NULL, b'1');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

-- Volcando estructura para tabla krece.user_password_resets
CREATE TABLE IF NOT EXISTS `user_password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`),
  KEY `password_resets_token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla krece.user_password_resets: ~0 rows (aproximadamente)
DELETE FROM `user_password_resets`;
/*!40000 ALTER TABLE `user_password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_password_resets` ENABLE KEYS */;

-- Volcando estructura para tabla krece.user_rights
CREATE TABLE IF NOT EXISTS `user_rights` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `module_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_user_rights_module_id` (`user_id`,`module_id`),
  KEY `FK_user_rights_module` (`module_id`),
  CONSTRAINT `FK_user_rights_module` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`),
  CONSTRAINT `FK_user_rights_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='list of modules that an user has access';

-- Volcando datos para la tabla krece.user_rights: ~0 rows (aproximadamente)
DELETE FROM `user_rights`;
/*!40000 ALTER TABLE `user_rights` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_rights` ENABLE KEYS */;

-- Volcando estructura para tabla krece.user_role
CREATE TABLE IF NOT EXISTS `user_role` (
  `id` int(11) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.user_role: ~2 rows (aproximadamente)
DELETE FROM `user_role`;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` (`id`, `description`) VALUES
	(1, 'Administrator'),
	(2, 'Restricted');
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;

-- Volcando estructura para tabla krece.user_status
CREATE TABLE IF NOT EXISTS `user_status` (
  `id` int(11) NOT NULL,
  `description` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.user_status: ~3 rows (aproximadamente)
DELETE FROM `user_status`;
/*!40000 ALTER TABLE `user_status` DISABLE KEYS */;
INSERT INTO `user_status` (`id`, `description`) VALUES
	(1, 'Activo'),
	(2, 'Inactivo'),
	(3, 'Eliminado');
/*!40000 ALTER TABLE `user_status` ENABLE KEYS */;

-- Volcando estructura para procedimiento krece.delete_all_data
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_all_data`()
    COMMENT 'Elmina todos los datos de la base de datos y restaura los ids autonumerícos'
BEGIN

delete from remision_detail;
ALTER TABLE remision_detail AUTO_INCREMENT = 1;

delete from remision;
ALTER TABLE remision AUTO_INCREMENT = 1;

delete from resolution;
ALTER TABLE resolution AUTO_INCREMENT = 1;

delete from resolution_numbers;
ALTER TABLE resolution_numbers AUTO_INCREMENT = 1;

delete from retention;
ALTER TABLE retention AUTO_INCREMENT = 1;

delete from category_payment;
ALTER TABLE category_payment AUTO_INCREMENT = 1;

delete from bill_detail;
ALTER TABLE bill_detail AUTO_INCREMENT = 1;

delete from bill;
ALTER TABLE bill AUTO_INCREMENT = 1;

delete from invoice_sale_order_detail;
ALTER TABLE invoice_sale_order_detail AUTO_INCREMENT = 1;

delete from invoice_sale_order;
ALTER TABLE invoice_sale_order AUTO_INCREMENT = 1;

delete from estimate_detail;
ALTER TABLE estimate_detail AUTO_INCREMENT = 1;

delete from estimate;
ALTER TABLE estimate AUTO_INCREMENT = 1;

delete from purchase_order_detail;
ALTER TABLE purchase_order_detail AUTO_INCREMENT = 1;

delete from purchase_order;
ALTER TABLE purchase_order AUTO_INCREMENT = 1;

delete from debit_note_detail;
ALTER TABLE debit_note_detail AUTO_INCREMENT = 1;

delete from debit_note;
ALTER TABLE debit_note AUTO_INCREMENT = 1;

delete from credit_note_detail;
ALTER TABLE credit_note_detail AUTO_INCREMENT = 1;

delete from credit_note;
ALTER TABLE credit_note AUTO_INCREMENT = 1;

delete from payment_history;
ALTER TABLE payment_history AUTO_INCREMENT = 1;

delete from payment;
ALTER TABLE payment AUTO_INCREMENT = 1;

delete from failed_jobs;
ALTER TABLE failed_jobs AUTO_INCREMENT = 1;

delete from retention;
ALTER TABLE retention AUTO_INCREMENT = 1;

delete from list_price;
ALTER TABLE list_price AUTO_INCREMENT = 1;

delete from currency;
ALTER TABLE currency AUTO_INCREMENT = 1;

delete from product;
ALTER TABLE product AUTO_INCREMENT = 1;

delete from category;
ALTER TABLE category AUTO_INCREMENT = 1;

delete from seller;
ALTER TABLE seller AUTO_INCREMENT = 1;

delete from bank_account;
ALTER TABLE bank_account AUTO_INCREMENT = 1;

delete from payment_terms;
ALTER TABLE payment_terms AUTO_INCREMENT = 1;

delete from tax;
ALTER TABLE tax AUTO_INCREMENT = 1;

delete from contact;
ALTER TABLE contact AUTO_INCREMENT = 1;

delete from activity_log;
ALTER TABLE activity_log AUTO_INCREMENT = 1;

delete from user;
ALTER TABLE user AUTO_INCREMENT = 1;

delete from account;
ALTER TABLE account AUTO_INCREMENT = 1;



END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
