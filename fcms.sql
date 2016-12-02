-- MySQL dump 10.16  Distrib 10.1.17-MariaDB, for osx10.10 (x86_64)
--
-- Host: localhost    Database: fcms
-- ------------------------------------------------------
-- Server version	10.1.17-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address_relations`
--

DROP TABLE IF EXISTS `address_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address_relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) DEFAULT NULL,
  `owner_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_id` int(11) DEFAULT NULL,
  `primary` tinyint(1) DEFAULT NULL,
  `started_at` date DEFAULT NULL,
  `ended_at` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_address_relations_on_address_id` (`address_id`),
  KEY `index_address_relations_on_owner_id_and_owner_type` (`owner_id`,`owner_type`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address_relations`
--

LOCK TABLES `address_relations` WRITE;
/*!40000 ALTER TABLE `address_relations` DISABLE KEYS */;
INSERT INTO `address_relations` VALUES (1,1,'Office',1,1,'2016-10-01',NULL),(2,1,'Facility',2,1,'2016-10-01',NULL),(3,1,'Staff',3,1,'2016-10-01',NULL),(4,6,'Family',4,1,'2016-10-01',NULL),(5,7,'Family',4,1,'2016-10-01',NULL);
/*!40000 ALTER TABLE `address_relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `addresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `street1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `street2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postal_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
INSERT INTO `addresses` VALUES (1,'456 N Main St',NULL,'Placervil','94560','ca','2016-10-02 01:12:47','2016-10-02 01:12:47'),(2,'555 Facility Dr',NULL,'Cameron Park','95682','ca','2016-10-02 01:12:47','2016-10-02 01:12:47'),(3,'5584 Washington Dr',NULL,'Cameron Park','95682','ca','2016-10-02 01:12:47','2016-10-02 01:12:47'),(4,'666 1st ST',NULL,'Cameron Park','95682','ca','2016-10-02 01:12:48','2016-10-02 01:12:48');
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assignments`
--

DROP TABLE IF EXISTS `assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assignments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `owner_id` int(11) NOT NULL,
  `owner_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `resource_id` int(11) NOT NULL,
  `resource_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `organization_id` int(11) DEFAULT NULL,
  `started_at` date DEFAULT NULL,
  `ended_at` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_assignments_on_type` (`type`),
  KEY `index_assignments_on_organization_id` (`organization_id`),
  KEY `owner_resource_idx` (`owner_id`,`owner_type`,`resource_id`,`resource_type`),
  KEY `resource_owner_idx` (`resource_id`,`resource_type`,`owner_id`,`owner_type`),
  KEY `index_assignments_on_started_at_and_ended_at` (`started_at`,`ended_at`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignments`
--

LOCK TABLES `assignments` WRITE;
/*!40000 ALTER TABLE `assignments` DISABLE KEYS */;
INSERT INTO `assignments` VALUES (1,'Assignments::Employee',1,'Staff',1,'Office',1,'2016-10-01',NULL),(2,'Assignments::Provider',2,'CareProvider',1,'Facility',1,'2016-10-01',NULL),(3,'Assignments::Provider',3,'CareProvider',1,'Facility',1,'2016-10-01',NULL),(4,'Assignments::Placement',4,'Child',1,'Facility',1,'2016-10-01','2016-11-13'),(5,'Assignments::Placement',5,'Child',1,'Facility',1,'2016-10-01',NULL),(6,'Assignments::CaseWorker',4,'Child',1,'Staff',1,'2016-10-01',NULL),(7,'Assignments::Relation',4,'Child',6,'Family',1,'2016-10-01',NULL),(8,'Assignments::CaseWorker',5,'Child',1,'Staff',1,'2016-10-01',NULL),(9,'Assignments::Relation',5,'Child',6,'Family',1,'2016-10-01',NULL),(10,'Assignments::Relation',5,'Child',7,'Family',1,'2016-10-01',NULL),(11,'Assignments::Placement',4,'Child',1,'Facility',1,'2016-11-08','2016-11-13'),(12,'Assignments::Ward',4,'Child',1,'Office',1,'2016-11-13',NULL),(13,'Assignments::Placement',4,'Child',1,'Facility',1,'2016-11-13','2016-11-13'),(14,'Assignments::Placement',4,'Child',1,'Facility',1,'2016-11-13','2016-11-13');
/*!40000 ALTER TABLE `assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facilities`
--

DROP TABLE IF EXISTS `facilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facilities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `office_id` int(11) DEFAULT NULL,
  `organization_id` int(11) DEFAULT NULL,
  `bed_count` int(11) DEFAULT '0',
  `active` tinyint(1) DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_facilities_on_office_id` (`office_id`),
  KEY `index_facilities_on_organization_id` (`organization_id`),
  KEY `office_org_act_idx` (`office_id`,`active`,`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facilities`
--

LOCK TABLES `facilities` WRITE;
/*!40000 ALTER TABLE `facilities` DISABLE KEYS */;
INSERT INTO `facilities` VALUES (1,'Pro Care',1,1,2,1,'2016-10-02 01:12:47','2016-10-02 01:12:47');
/*!40000 ALTER TABLE `facilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_members`
--

DROP TABLE IF EXISTS `group_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) DEFAULT NULL,
  `person_type` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_group_members_on_group_id` (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_members`
--

LOCK TABLES `group_members` WRITE;
/*!40000 ALTER TABLE `group_members` DISABLE KEYS */;
INSERT INTO `group_members` VALUES (1,1,0,2,NULL,'2016-11-06 01:47:27','2016-11-06 01:47:27');
/*!40000 ALTER TABLE `group_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_permissions`
--

DROP TABLE IF EXISTS `group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permission_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `level_string` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_group_permissions_on_permission_id` (`permission_id`),
  KEY `index_group_permissions_on_group_id` (`group_id`),
  KEY `index_group_permissions_on_active` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_permissions`
--

LOCK TABLES `group_permissions` WRITE;
/*!40000 ALTER TABLE `group_permissions` DISABLE KEYS */;
INSERT INTO `group_permissions` VALUES (3,1,2,'write',1,'2016-11-06 01:50:25','2016-11-06 01:50:25'),(4,2,2,'write',1,'2016-11-06 01:50:25','2016-11-06 01:50:25');
/*!40000 ALTER TABLE `group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `organization_id` int(11) DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_groups_on_organization_id` (`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (2,'Administrator',1,1,'2016-11-06 01:38:34','2016-11-06 01:38:34');
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `note_targets`
--

DROP TABLE IF EXISTS `note_targets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `note_targets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `noteable_id` int(11) DEFAULT NULL,
  `noteable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_note_targets_on_noteable_type_and_noteable_id` (`noteable_type`,`noteable_id`),
  KEY `index_note_targets_on_note_id` (`note_id`),
  CONSTRAINT `fk_rails_1939f10359` FOREIGN KEY (`note_id`) REFERENCES `notes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `note_targets`
--

LOCK TABLES `note_targets` WRITE;
/*!40000 ALTER TABLE `note_targets` DISABLE KEYS */;
INSERT INTO `note_targets` VALUES (2,4,'Child',2,'2016-11-14 01:18:14','2016-11-14 01:18:14'),(3,4,'Child',3,'2016-11-14 01:48:09','2016-11-14 01:48:09'),(4,4,'Child',4,'2016-11-14 01:48:28','2016-11-14 01:48:28'),(5,4,'Child',5,'2016-11-14 02:09:45','2016-11-14 02:09:45'),(6,4,'Child',6,'2016-11-14 02:12:25','2016-11-14 02:12:25'),(7,4,'Child',7,'2016-11-14 02:12:53','2016-11-14 02:12:53'),(8,4,'Child',8,'2016-11-14 02:13:13','2016-11-14 02:13:13'),(9,4,'Child',9,'2016-11-14 02:13:44','2016-11-14 02:13:44'),(10,4,'Child',10,'2016-11-14 02:13:53','2016-11-14 02:13:53');
/*!40000 ALTER TABLE `note_targets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `creator_id` int(11) DEFAULT NULL,
  `creator_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci,
  `privacy` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_notes_on_creator_type_and_creator_id` (`creator_type`,`creator_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes`
--

LOCK TABLES `notes` WRITE;
/*!40000 ALTER TABLE `notes` DISABLE KEYS */;
INSERT INTO `notes` VALUES (2,1,'Staff','Notes::General','This is a test note','public',0,'2016-11-14 01:18:14','2016-11-14 01:50:53'),(3,1,'Staff','Notes::General','{\"note\"=>\"He this is a note\"}','public',0,'2016-11-14 01:48:09','2016-11-14 01:54:22'),(4,1,'Staff','Notes::General','He this is a note','public',1,'2016-11-14 01:48:28','2016-11-14 01:48:28'),(5,1,'Staff','Notes::General','Test note','public',1,'2016-11-14 02:09:45','2016-11-14 02:09:45'),(6,1,'Staff','Notes::General','Test note','public',1,'2016-11-14 02:12:25','2016-11-14 02:12:25'),(7,1,'Staff','Notes::General','Test note','public',1,'2016-11-14 02:12:53','2016-11-14 02:12:53'),(8,1,'Staff','Notes::General','Test note','public',1,'2016-11-14 02:13:13','2016-11-14 02:13:13'),(9,1,'Staff','Notes::General','Test note','public',1,'2016-11-14 02:13:44','2016-11-14 02:13:44'),(10,1,'Staff','Notes::General','BOOM','public',1,'2016-11-14 02:13:53','2016-11-14 02:13:58');
/*!40000 ALTER TABLE `notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offices`
--

DROP TABLE IF EXISTS `offices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `organization_id` int(11) DEFAULT NULL,
  `primary` tinyint(1) DEFAULT '0',
  `active` tinyint(1) DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_offices_on_organization_id` (`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offices`
--

LOCK TABLES `offices` WRITE;
/*!40000 ALTER TABLE `offices` DISABLE KEYS */;
INSERT INTO `offices` VALUES (1,'Head Quaters',1,0,1,'2016-10-02 01:12:47','2016-10-02 01:12:47');
/*!40000 ALTER TABLE `offices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organizations`
--

DROP TABLE IF EXISTS `organizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organizations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organizations`
--

LOCK TABLES `organizations` WRITE;
/*!40000 ALTER TABLE `organizations` DISABLE KEYS */;
INSERT INTO `organizations` VALUES (1,'Test Organization',1,'2016-10-02 01:12:47','2016-10-02 01:12:47');
/*!40000 ALTER TABLE `organizations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `people`
--

DROP TABLE IF EXISTS `people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `people` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `middle_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `social` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `organization_id` int(11) DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `salt` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `staff` tinyint(1) DEFAULT '0',
  `active` tinyint(1) DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_people_on_type` (`type`),
  KEY `index_people_on_organization_id` (`organization_id`),
  KEY `index_people_on_email_and_password` (`email`,`password`),
  KEY `index_people_on_type_and_organization_id` (`type`,`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `people`
--

LOCK TABLES `people` WRITE;
/*!40000 ALTER TABLE `people` DISABLE KEYS */;
INSERT INTO `people` VALUES (1,'Staff','Admin',NULL,'Account',NULL,NULL,1,'admin@example.com','530bc8baf84ca7ea673eab694ca76323392759b23bd75e0a445dd9e6d7c97071','5977943b6b98',1,1,'2016-10-02 01:12:47','2016-10-02 01:12:47'),(2,'CareProvider','George',NULL,'Castanza',NULL,NULL,1,'something@example.com',NULL,NULL,0,1,'2016-10-02 01:12:47','2016-10-02 01:12:47'),(3,'CareProvider','Emily',NULL,'Castanza',NULL,NULL,1,'emily@example.com',NULL,NULL,0,1,'2016-10-02 01:12:47','2016-10-02 01:12:47'),(4,'Child','Georgety','Cartlitok','Hammock','2006-10-02','118675309',1,NULL,NULL,NULL,0,1,'2016-10-02 01:12:48','2016-11-06 07:51:41'),(5,'Child','Ethan','Rabit','Hawken','2009-10-02','0000000111',1,NULL,NULL,NULL,0,1,'2016-10-02 01:12:48','2016-10-02 01:12:48'),(6,'Family','Carly',NULL,'Doe','1956-10-02','00000002',1,NULL,NULL,NULL,0,1,'2016-10-02 01:12:48','2016-10-02 01:12:48'),(7,'Family','Greg',NULL,'Pinole','1959-10-02','00000003',1,NULL,NULL,NULL,0,1,'2016-10-02 01:12:48','2016-10-02 01:12:48'),(8,'Child','George','Cartline','Hammock',NULL,'118675309',1,NULL,NULL,NULL,0,1,'2016-10-03 18:53:33','2016-10-03 18:53:33'),(9,'Child','Elaine','George','Hammock',NULL,'118675309',1,NULL,NULL,NULL,0,1,'2016-10-03 20:52:09','2016-10-03 20:52:09'),(14,'Child','Caitline','Mc','Tester',NULL,NULL,1,NULL,NULL,NULL,0,1,'2016-10-03 21:13:44','2016-10-03 21:13:44'),(15,'Child','Sean','Leo','Thadius',NULL,NULL,1,NULL,NULL,NULL,0,1,'2016-10-03 21:15:52','2016-10-03 21:15:52'),(16,'Child','Mikey','He','Likes-It',NULL,NULL,1,NULL,NULL,NULL,0,1,'2016-10-03 21:17:39','2016-10-03 21:17:39'),(17,'Child','Jean','Luke','Picard',NULL,NULL,1,NULL,NULL,NULL,0,1,'2016-10-03 21:18:21','2016-10-03 21:18:21'),(18,'Child','Brent','D','Spiner',NULL,NULL,1,NULL,NULL,NULL,0,1,'2016-10-03 21:18:42','2016-10-03 21:18:42');
/*!40000 ALTER TABLE `people` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'child-person-data','Child Personal Data','2016-11-06 01:32:06','2016-11-06 01:32:06'),(2,'child-data','View Basic Child Data','2016-11-06 01:32:06','2016-11-06 01:32:06');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20160729023113'),('20160729023318'),('20160729023718'),('20160729033054'),('20160802010622'),('20160807030801'),('20160807030905'),('20161106000846'),('20161106001131'),('20161106001252'),('20161106001339'),('20161106073948'),('20161114010510'),('20161114010606');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `versions`
--

DROP TABLE IF EXISTS `versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `versions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_type` varchar(191) NOT NULL,
  `item_id` int(11) NOT NULL,
  `event` varchar(255) NOT NULL,
  `whodunnit` varchar(255) DEFAULT NULL,
  `object` longtext,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_versions_on_item_type_and_item_id` (`item_type`,`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `versions`
--

LOCK TABLES `versions` WRITE;
/*!40000 ALTER TABLE `versions` DISABLE KEYS */;
INSERT INTO `versions` VALUES (3,'Child',4,'update','Admin Account','---\nid: 4\ntype: Child\nfirst_name: Georgety\nmiddle_name: Cartliney\nlast_name: Hammock\ndob: 2006-10-02\nsocial: \'118675309\'\norganization_id: 1\nemail:\npassword:\nsalt:\nstaff: false\nactive: true\ncreated_at: \'2016-10-02 01:12:48\'\nupdated_at: \'2016-11-06 07:48:10\'\n','2016-11-06 07:51:41'),(4,'Note',5,'create','Admin Account',NULL,'2016-11-14 02:09:45'),(5,'Note',6,'create','Admin Account',NULL,'2016-11-14 02:12:25'),(6,'Note',7,'create','Admin Account',NULL,'2016-11-14 02:12:53'),(7,'Note',8,'create','Admin Account',NULL,'2016-11-14 02:13:13'),(8,'Note',9,'create','Admin Account',NULL,'2016-11-14 02:13:44'),(9,'Note',10,'create','Admin Account',NULL,'2016-11-14 02:13:53'),(10,'Note',10,'update','Admin Account','---\nid: 10\ncreator_id: 1\ncreator_type: Staff\ntype: Notes::General\nnote: He this is a note\nprivacy: public\nactive: true\ncreated_at: \'2016-11-14 02:13:53\'\nupdated_at: \'2016-11-14 02:13:53\'\n','2016-11-14 02:13:58');
/*!40000 ALTER TABLE `versions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-11-13 19:05:34
