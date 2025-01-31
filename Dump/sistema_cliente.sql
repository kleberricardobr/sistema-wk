-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: sistema
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(500) NOT NULL,
  `cidade` varchar(100) NOT NULL,
  `uf` set('AC','AL','AM','AP','BA','CE','DF','ES','GO','MA','MG','MS','MT','PA','PB','PE','PI','PR','RJ','RN','RO','RR','RS','SC','SE','SP','TO') NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `cliente_idx_01` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'Kleber','Mococa','SP'),(2,'José','Mococa','SP'),(3,'Arthur','Mococa','SP'),(4,'Ana','Belo Horizonte','MG'),(5,'Carlos','São Paulo','SP'),(6,'Julia','Campinas','SP'),(7,'Roberto','Uberlândia','MG'),(8,'Mariana','Fortaleza','CE'),(9,'Felipe','Rio de Janeiro','RJ'),(10,'Larissa','Salvador','BA'),(11,'Tiago','Curitiba','PR'),(12,'Gabriela','Recife','PE'),(13,'Fernando','Porto Alegre','RS'),(14,'Marcos','Vitória','ES'),(15,'Carla','Goiânia','GO'),(16,'Lucas','Manaus','AM'),(17,'Fernanda','Cuiabá','MT'),(18,'Ricardo','Belém','PA'),(19,'Simone','Campo Grande','MS'),(20,'Patrícia','João Pessoa','PB'),(21,'Vinícius','Aracaju','SE'),(22,'André','Teresina','PI'),(23,'Isabela','Acrelândia','AC'),(24,'José','Macapá','AP'),(25,'Eduarda','Boa Vista','RR'),(26,'Rafael','Porto Velho','RO');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-31 15:12:25
