-- MySQL dump 10.16  Distrib 10.2.14-MariaDB, for osx10.13 (x86_64)
--
-- Host: localhost    Database: drissy_dev
-- ------------------------------------------------------
-- Server version	10.2.14-MariaDB

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
-- Table structure for table `assetindexdata`
--

DROP TABLE IF EXISTS `assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT 0,
  `completed` tinyint(1) DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_filename_folderId_unq_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assettransformindex`
--

DROP TABLE IF EXISTS `assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT 0,
  `inProgress` tinyint(1) NOT NULL DEFAULT 0,
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assettransforms`
--

DROP TABLE IF EXISTS `assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorygroups`
--

DROP TABLE IF EXISTS `categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_name_unq_idx` (`name`),
  UNIQUE KEY `categorygroups_handle_unq_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorygroups_sites`
--

DROP TABLE IF EXISTS `categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `uriFormat` text DEFAULT NULL,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_protagonist` text DEFAULT NULL,
  `field_speaker` text DEFAULT NULL,
  `field_director` text DEFAULT NULL,
  `field_dop` text DEFAULT NULL,
  `field_production` text DEFAULT NULL,
  `field_music` text DEFAULT NULL,
  `field_soundMixing` text DEFAULT NULL,
  `field_editing` text DEFAULT NULL,
  `field_googleAnalytics` text DEFAULT NULL,
  `field_globalSocialNetworks` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craftidtokens`
--

DROP TABLE IF EXISTS `craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deprecationerrors`
--

DROP TABLE IF EXISTS `deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `traces` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB AUTO_INCREMENT=3337 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elementindexsettings`
--

DROP TABLE IF EXISTS `elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements`
--

DROP TABLE IF EXISTS `elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `archived` tinyint(1) NOT NULL DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements_sites`
--

DROP TABLE IF EXISTS `elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  UNIQUE KEY `elements_sites_uri_siteId_unq_idx` (`uri`,`siteId`),
  KEY `elements_sites_siteId_idx` (`siteId`),
  KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `elements_sites_enabled_idx` (`enabled`),
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entries`
--

DROP TABLE IF EXISTS `entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entrydrafts`
--

DROP TABLE IF EXISTS `entrydrafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entrydrafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text DEFAULT NULL,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrydrafts_sectionId_idx` (`sectionId`),
  KEY `entrydrafts_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entrydrafts_siteId_idx` (`siteId`),
  KEY `entrydrafts_creatorId_idx` (`creatorId`),
  CONSTRAINT `entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entrytypes`
--

DROP TABLE IF EXISTS `entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT 1,
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `entrytypes_name_sectionId_unq_idx` (`name`,`sectionId`),
  UNIQUE KEY `entrytypes_handle_sectionId_unq_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entryversions`
--

DROP TABLE IF EXISTS `entryversions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entryversions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `siteId` int(11) NOT NULL,
  `num` smallint(6) unsigned NOT NULL,
  `notes` text DEFAULT NULL,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entryversions_sectionId_idx` (`sectionId`),
  KEY `entryversions_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entryversions_siteId_idx` (`siteId`),
  KEY `entryversions_creatorId_idx` (`creatorId`),
  CONSTRAINT `entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldgroups`
--

DROP TABLE IF EXISTS `fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayoutfields`
--

DROP TABLE IF EXISTS `fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayouts`
--

DROP TABLE IF EXISTS `fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayouttabs`
--

DROP TABLE IF EXISTS `fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fields`
--

DROP TABLE IF EXISTS `fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text DEFAULT NULL,
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `globalsets`
--

DROP TABLE IF EXISTS `globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `globalsets_name_unq_idx` (`name`),
  UNIQUE KEY `globalsets_handle_unq_idx` (`handle`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `info`
--

DROP TABLE IF EXISTS `info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `edition` tinyint(3) unsigned NOT NULL,
  `timezone` varchar(30) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `on` tinyint(1) NOT NULL DEFAULT 0,
  `maintenance` tinyint(1) NOT NULL DEFAULT 0,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocks`
--

DROP TABLE IF EXISTS `matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `ownerSiteId` int(11) DEFAULT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  KEY `matrixblocks_ownerSiteId_idx` (`ownerSiteId`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerSiteId_fk` FOREIGN KEY (`ownerSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocktypes`
--

DROP TABLE IF EXISTS `matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixcontent_body`
--

DROP TABLE IF EXISTS `matrixcontent_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixcontent_body` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_text_textContent` text DEFAULT NULL,
  `field_blockquote_quote` text DEFAULT NULL,
  `field_blockquote_citation` text DEFAULT NULL,
  `field_image_caption` text DEFAULT NULL,
  `field_image_layout` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixcontent_body_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `matrixcontent_body_siteId_fk` (`siteId`),
  CONSTRAINT `matrixcontent_body_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixcontent_body_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixcontent_globalcontact`
--

DROP TABLE IF EXISTS `matrixcontent_globalcontact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixcontent_globalcontact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_contact_company` text DEFAULT NULL,
  `field_contact_street` text DEFAULT NULL,
  `field_contact_postalCode` text DEFAULT NULL,
  `field_contact_city` text DEFAULT NULL,
  `field_contact_country` text DEFAULT NULL,
  `field_contact_mail` varchar(255) DEFAULT NULL,
  `field_contact_phone` text DEFAULT NULL,
  `field_contact_mobilePhone` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixcontent_globalcontact_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `matrixcontent_globalcontact_siteId_fk` (`siteId`),
  CONSTRAINT `matrixcontent_globalcontact_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixcontent_globalcontact_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixcontent_globalnavigationmain`
--

DROP TABLE IF EXISTS `matrixcontent_globalnavigationmain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixcontent_globalnavigationmain` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_menuItem_menuItem` text DEFAULT NULL,
  `field_menuItem_isActive` tinyint(1) DEFAULT NULL,
  `field_menuItem_highlightTriggers` text DEFAULT NULL,
  `field_menuItem_segmentPosition` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixcontent_globalnavigationmain_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `matrixcontent_globalnavigationmain_siteId_fk` (`siteId`),
  CONSTRAINT `matrixcontent_globalnavigationmain_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixcontent_globalnavigationmain_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixcontent_globalwatermark`
--

DROP TABLE IF EXISTS `matrixcontent_globalwatermark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixcontent_globalwatermark` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_watermark_useWatermark` tinyint(1) DEFAULT NULL,
  `field_watermark_width` int(10) DEFAULT NULL,
  `field_watermark_height` int(10) DEFAULT NULL,
  `field_watermark_opacity` decimal(11,1) DEFAULT NULL,
  `field_watermark_offsetXAxis` int(10) DEFAULT NULL,
  `field_watermark_offsetYAxis` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixcontent_globalwatermark_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `matrixcontent_globalwatermark_siteId_fk` (`siteId`),
  CONSTRAINT `matrixcontent_globalwatermark_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixcontent_globalwatermark_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `migrations_pluginId_idx` (`pluginId`),
  KEY `migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugins`
--

DROP TABLE IF EXISTS `plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKey` char(24) DEFAULT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  `settings` text DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`),
  KEY `plugins_enabled_idx` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` longblob NOT NULL,
  `description` text DEFAULT NULL,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT 0,
  `priority` int(11) unsigned NOT NULL DEFAULT 1024,
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT 0,
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT 0,
  `dateFailed` datetime DEFAULT NULL,
  `error` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `queue_fail_timeUpdated_timePushed_idx` (`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_fail_timeUpdated_delay_idx` (`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `relations`
--

DROP TABLE IF EXISTS `relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `relations_sourceId_idx` (`sourceId`),
  KEY `relations_targetId_idx` (`targetId`),
  KEY `relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=289 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resourcepaths`
--

DROP TABLE IF EXISTS `resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `routes`
--

DROP TABLE IF EXISTS `routes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `routes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) DEFAULT NULL,
  `uriParts` varchar(255) NOT NULL,
  `uriPattern` varchar(255) NOT NULL,
  `template` varchar(500) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `routes_uriPattern_idx` (`uriPattern`),
  KEY `routes_siteId_idx` (`siteId`),
  CONSTRAINT `routes_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `searchindex`
--

DROP TABLE IF EXISTS `searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT 0,
  `propagateEntries` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_handle_unq_idx` (`handle`),
  UNIQUE KEY `sections_name_unq_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections_sites`
--

DROP TABLE IF EXISTS `sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `uriFormat` text DEFAULT NULL,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sessions_uid_idx` (`uid`),
  KEY `sessions_token_idx` (`token`),
  KEY `sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `sessions_userId_idx` (`userId`),
  CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shunnedmessages`
--

DROP TABLE IF EXISTS `shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sitegroups`
--

DROP TABLE IF EXISTS `sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sitegroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 0,
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sites_handle_unq_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structureelements`
--

DROP TABLE IF EXISTS `structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `structureelements_root_idx` (`root`),
  KEY `structureelements_lft_idx` (`lft`),
  KEY `structureelements_rgt_idx` (`rgt`),
  KEY `structureelements_level_idx` (`level`),
  KEY `structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structures`
--

DROP TABLE IF EXISTS `structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `systemmessages`
--

DROP TABLE IF EXISTS `systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `systemsettings`
--

DROP TABLE IF EXISTS `systemsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `systemsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(15) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemsettings_category_unq_idx` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taggroups`
--

DROP TABLE IF EXISTS `taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `taggroups_name_unq_idx` (`name`),
  UNIQUE KEY `taggroups_handle_unq_idx` (`handle`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tags_groupId_idx` (`groupId`),
  CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecacheelements`
--

DROP TABLE IF EXISTS `templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecachequeries`
--

DROP TABLE IF EXISTS `templatecachequeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `templatecachequeries_type_idx` (`type`),
  CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecaches`
--

DROP TABLE IF EXISTS `templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text DEFAULT NULL,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_token_unq_idx` (`token`),
  KEY `tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usergroups`
--

DROP TABLE IF EXISTS `usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usergroups_users`
--

DROP TABLE IF EXISTS `usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions`
--

DROP TABLE IF EXISTS `userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions_usergroups`
--

DROP TABLE IF EXISTS `userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions_users`
--

DROP TABLE IF EXISTS `userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpreferences`
--

DROP TABLE IF EXISTS `userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text DEFAULT NULL,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT 0,
  `locked` tinyint(1) NOT NULL DEFAULT 0,
  `suspended` tinyint(1) NOT NULL DEFAULT 0,
  `pending` tinyint(1) NOT NULL DEFAULT 0,
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT 0,
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT 0,
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unq_idx` (`username`),
  UNIQUE KEY `users_email_unq_idx` (`email`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_photoId_fk` (`photoId`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volumefolders`
--

DROP TABLE IF EXISTS `volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `volumefolders_parentId_idx` (`parentId`),
  KEY `volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volumes`
--

DROP TABLE IF EXISTS `volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `url` varchar(255) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumes_name_unq_idx` (`name`),
  UNIQUE KEY `volumes_handle_unq_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `widgets`
--

DROP TABLE IF EXISTS `widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(1) NOT NULL DEFAULT 0,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'drissy_dev'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-17 15:33:17
-- MySQL dump 10.16  Distrib 10.2.14-MariaDB, for osx10.13 (x86_64)
--
-- Host: localhost    Database: drissy_dev
-- ------------------------------------------------------
-- Server version	10.2.14-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `assets` VALUES (75,4,6,'RAAD-Tranquillo-Official-Video-LEONELRUBEN.json','json',NULL,NULL,2829,NULL,'2018-05-09 13:36:53','2018-05-09 13:36:53','2018-05-17 13:03:15','75cb7848-bd00-45e8-ac86-867bac586928'),(78,4,6,'EUNOIA-2015-they-disappeared-like-two-mystical-ang.json','json',NULL,NULL,2399,NULL,'2018-05-09 13:39:32','2018-05-09 13:39:32','2018-05-17 13:03:15','3bacd5b2-638e-43a0-91b9-dc1b9a9fb765'),(80,4,6,'ATTAK-2017-official-trailer-LEONELRUBEN.json','json',NULL,NULL,2334,NULL,'2018-05-09 13:40:30','2018-05-09 13:40:30','2018-05-17 13:03:15','ada6da4a-ae71-47dd-a640-887d458636fd'),(84,4,6,'AKOG_SS18.json','json',NULL,NULL,2414,NULL,'2018-05-09 13:41:36','2018-05-09 13:41:36','2018-05-17 13:03:15','6d84717c-32cc-41ad-8f5e-1825e74e274a'),(86,1,1,'1IF9ReWYY0.jpg','image',4512,3000,1564898,NULL,'2018-05-09 14:32:57','2018-05-09 14:32:58','2018-05-17 13:03:13','dda1f2e2-a942-4457-812b-e4d43a83ad19'),(87,1,1,'IIZStycdXxs.jpg','image',2385,2981,1568787,NULL,'2018-05-09 14:33:06','2018-05-09 14:33:07','2018-05-17 13:03:14','83e94184-45a7-4640-b7c9-86e06e3fbdd1'),(88,1,1,'nRHKcdmLIzY.jpg','image',4480,6720,2930686,NULL,'2018-05-09 14:33:17','2018-05-09 14:33:18','2018-05-17 13:03:14','cbf97ff1-24db-48b6-a941-6abc0f42a899'),(89,1,1,'aNw7Lm-CHFs.jpg','image',4000,6000,2079731,NULL,'2018-05-09 14:33:24','2018-05-09 14:33:25','2018-05-17 13:03:14','f55e9105-2a00-4694-836f-c3da36802c13');
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `assettransforms`
--

LOCK TABLES `assettransforms` WRITE;
/*!40000 ALTER TABLE `assettransforms` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `assettransforms` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups`
--

LOCK TABLES `categorygroups` WRITE;
/*!40000 ALTER TABLE `categorygroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups_sites`
--

LOCK TABLES `categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `categorygroups_sites` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `content` VALUES (1,1,1,NULL,'2018-04-30 15:34:51','2018-05-09 09:17:21','675e89c3-9781-4d88-b20b-4c1a824af24a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,2,1,'Homepage','2018-05-02 13:44:02','2018-05-17 13:01:45','69a0351d-e731-4a72-b887-cc6b23372109',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,10,1,'Alban','2018-05-03 11:01:36','2018-05-03 11:01:36','fee09d73-6b51-44cd-9833-9f02744b4c70',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(16,24,1,'Wes Hicks','2018-05-03 18:28:29','2018-05-03 18:28:29','b58b905b-20f0-4292-86fd-b666d406dc6d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(37,55,1,'Commercial','2018-05-05 10:11:13','2018-05-05 10:11:13','4e238683-71d6-4ba2-9605-4896ea5d852b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(38,56,1,'Crack','2018-05-05 11:46:06','2018-05-05 11:46:06','448e81a4-795e-4f9c-8ff5-a698541318d6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(40,58,1,NULL,'2018-05-05 14:54:42','2018-05-17 13:02:28','f4779bbd-1410-4fb3-8457-7c18d447e53d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(41,59,1,NULL,'2018-05-05 14:55:05','2018-05-05 14:55:05','07cb7188-b7e0-44a2-b8ff-55701e7006ca',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(42,60,1,NULL,'2018-05-05 14:55:25','2018-05-05 14:55:25','eeb2636f-1319-4ca5-8332-ea667ebd0b6c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(43,61,1,NULL,'2018-05-05 14:55:43','2018-05-17 13:03:01','8c67312e-5f43-4e97-a236-4a7d25375c6e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(44,62,1,NULL,'2018-05-05 14:56:01','2018-05-17 13:03:05','fc46befb-77f6-4bc7-8ddc-52547f34d407',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(45,63,1,NULL,'2018-05-05 14:56:15','2018-05-05 14:56:15','032eb5c9-60ee-49f7-9dd8-0ea31780edc7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(51,74,1,'Crime','2018-05-09 13:35:06','2018-05-09 13:35:06','3cfe8694-60fe-49cf-9573-ae109d7c9d00',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(52,75,1,'RAAD - Tranquillo (Official Video) - LEONELRUBEN','2018-05-09 13:36:53','2018-05-17 13:03:15','00e387ca-73d1-47ca-8bbd-d390ab7858bc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(54,77,1,'Drama','2018-05-09 13:39:06','2018-05-09 13:39:06','75760501-afce-4729-9201-4ac10a0eb03e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(55,78,1,'EUNOIA (2015) - they disappeared like two mystical','2018-05-09 13:39:32','2018-05-17 13:03:15','e030afc7-9df3-4e7a-a309-c167531d8c72',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(57,80,1,'ATTAK (2017) - official trailer - LEONELRUBEN','2018-05-09 13:40:30','2018-05-17 13:03:15','329fcb94-e13e-45c1-8525-e4e61af0b011',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(59,82,1,'Trash','2018-05-09 13:41:14','2018-05-09 13:41:14','230fa0a5-01ea-4611-a7b2-8f41c07c24fd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(60,83,1,'Gamble','2018-05-09 13:41:21','2018-05-09 13:41:21','8c46b7fc-66b4-4abc-9eda-7f5a00d741e9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(61,84,1,'AKOG_SS18','2018-05-09 13:41:36','2018-05-17 13:03:15','aca27d76-73c8-4584-9a6c-0c56eaf76edf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(63,86,1,' _1If9Rewyy0','2018-05-09 14:32:51','2018-05-17 13:03:13','fd33fc7c-a6d1-482b-b1cc-58f092ec4ca5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(64,87,1,' Iizstycdxxs','2018-05-09 14:33:03','2018-05-17 13:03:14','c4dc8812-b580-4d0e-abc4-33a0b16160c2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(65,88,1,' Nrhkcdmlizy','2018-05-09 14:33:08','2018-05-17 13:03:14','0eeb2ed3-9dca-4c5e-9acb-b022b7176cfb',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(66,89,1,' Anw7Lm-Chfs','2018-05-09 14:33:18','2018-05-17 13:03:14','c985503d-80fd-476d-99bb-2e756d58a75c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(67,90,1,'Impressum','2018-05-14 14:28:42','2018-05-17 13:01:31','58504bef-f1b2-4123-855c-1b5f15f28902',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(68,91,1,'Datenschutz','2018-05-14 14:29:53','2018-05-17 13:01:58','853de880-2c2b-4af0-bd9c-02965ff17f9a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craftidtokens`
--

LOCK TABLES `craftidtokens` WRITE;
/*!40000 ALTER TABLE `craftidtokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `deprecationerrors`
--

LOCK TABLES `deprecationerrors` WRITE;
/*!40000 ALTER TABLE `deprecationerrors` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `deprecationerrors` VALUES (3319,'ElementQuery::getIterator()','/Users/hendrik/Documents/Github/Projects/drissy/templates/_matrix.twig:7','2018-05-17 13:07:29','/Users/hendrik/Documents/Github/Projects/drissy/templates/_matrix.twig',7,'Looping through element queries directly has been deprecated. Use the all() function to fetch the query results before looping over them.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/elements/db/ElementQuery.php\",\"line\":403,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"ElementQuery::getIterator()\\\", \\\"Looping through element queries directly has been deprecated. Us...\\\"\"},{\"objectClass\":\"craft\\\\elements\\\\db\\\\MatrixBlockQuery\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/storage/runtime/compiled_templates/55/55e711669fd7307f62e52fae3c5db96af6ada6c10ca1b66d44bc13ea681ff7e1.php\",\"line\":44,\"class\":\"craft\\\\elements\\\\db\\\\ElementQuery\",\"method\":\"getIterator\",\"args\":null},{\"objectClass\":\"__TwigTemplate_16877d09e36fa4cc40bf0625e67904b2b70b56d2c68736399bc7b45421f6855c\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/twig/twig/lib/Twig/Template.php\",\"line\":390,\"class\":\"__TwigTemplate_16877d09e36fa4cc40bf0625e67904b2b70b56d2c68736399bc7b45421f6855c\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_16877d09e36fa4cc40bf0625e67904b2b70b56d2c68736399bc7b45421f6855c\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":49,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_16877d09e36fa4cc40bf0625e67904b2b70b56d2c68736399bc7b45421f6855c\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/twig/twig/lib/Twig/Template.php\",\"line\":367,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_16877d09e36fa4cc40bf0625e67904b2b70b56d2c68736399bc7b45421f6855c\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":31,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_16877d09e36fa4cc40bf0625e67904b2b70b56d2c68736399bc7b45421f6855c\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/storage/runtime/compiled_templates/e5/e5e15eff547d3557a2f4a7f8906011da4e68060c4b32a2a24dd023705b507596.php\",\"line\":75,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...]\"},{\"objectClass\":\"__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/twig/twig/lib/Twig/Template.php\",\"line\":189,\"class\":\"__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279\",\"method\":\"block_itemContent\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/storage/runtime/compiled_templates/e5/e5e15eff547d3557a2f4a7f8906011da4e68060c4b32a2a24dd023705b507596.php\",\"line\":53,\"class\":\"Twig_Template\",\"method\":\"displayBlock\",\"args\":\"\\\"itemContent\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/twig/twig/lib/Twig/Template.php\",\"line\":189,\"class\":\"__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279\",\"method\":\"block_content\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/storage/runtime/compiled_templates/d5/d5e134785c122aec123de9836b85a905a00c68057346d22b8c728e5f14e56a3e.php\",\"line\":323,\"class\":\"Twig_Template\",\"method\":\"displayBlock\",\"args\":\"\\\"content\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/twig/twig/lib/Twig/Template.php\",\"line\":189,\"class\":\"__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa\",\"method\":\"block_body\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/storage/runtime/compiled_templates/d5/d5e134785c122aec123de9836b85a905a00c68057346d22b8c728e5f14e56a3e.php\",\"line\":278,\"class\":\"Twig_Template\",\"method\":\"displayBlock\",\"args\":\"\\\"body\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/twig/twig/lib/Twig/Template.php\",\"line\":390,\"class\":\"__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":49,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/twig/twig/lib/Twig/Template.php\",\"line\":367,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":31,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"_inline_css\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block__inline_css\\\"], \\\"content\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block_content\\\"], \\\"itemContent\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/storage/runtime/compiled_templates/e5/e5e15eff547d3557a2f4a7f8906011da4e68060c4b32a2a24dd023705b507596.php\",\"line\":30,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"_inline_css\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block__inline_css\\\"], \\\"content\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block_content\\\"], \\\"itemContent\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/twig/twig/lib/Twig/Template.php\",\"line\":390,\"class\":\"__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"_inline_css\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block__inline_css\\\"], \\\"content\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block_content\\\"], \\\"itemContent\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":49,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"_inline_css\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block__inline_css\\\"], \\\"content\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block_content\\\"], \\\"itemContent\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/twig/twig/lib/Twig/Template.php\",\"line\":367,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"_inline_css\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block__inline_css\\\"], \\\"content\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block_content\\\"], \\\"itemContent\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":31,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/storage/runtime/compiled_templates/e0/e0c270ab72d283a8b52692d818b505e3909fd389e9c3d73c308129b79a623341.php\",\"line\":32,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...]\"},{\"objectClass\":\"__TwigTemplate_37a46ea4d9b62bbc387970fb078c64144acaaa98fe957acd82e197c7aa3eaf36\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/twig/twig/lib/Twig/Template.php\",\"line\":390,\"class\":\"__TwigTemplate_37a46ea4d9b62bbc387970fb078c64144acaaa98fe957acd82e197c7aa3eaf36\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_37a46ea4d9b62bbc387970fb078c64144acaaa98fe957acd82e197c7aa3eaf36\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":49,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_37a46ea4d9b62bbc387970fb078c64144acaaa98fe957acd82e197c7aa3eaf36\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/twig/twig/lib/Twig/Template.php\",\"line\":367,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_37a46ea4d9b62bbc387970fb078c64144acaaa98fe957acd82e197c7aa3eaf36\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":31,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"__TwigTemplate_37a46ea4d9b62bbc387970fb078c64144acaaa98fe957acd82e197c7aa3eaf36\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/twig/twig/lib/Twig/Template.php\",\"line\":375,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"__TwigTemplate_37a46ea4d9b62bbc387970fb078c64144acaaa98fe957acd82e197c7aa3eaf36\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/twig/twig/lib/Twig/Environment.php\",\"line\":289,\"class\":\"Twig_Template\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/web/View.php\",\"line\":305,\"class\":\"Twig_Environment\",\"method\":\"render\",\"args\":\"\\\"_entry\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/web/View.php\",\"line\":352,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderTemplate\",\"args\":\"\\\"_entry\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/web/Controller.php\",\"line\":128,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderPageTemplate\",\"args\":\"\\\"_entry\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/controllers/TemplatesController.php\",\"line\":78,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"renderTemplate\",\"args\":\"\\\"_entry\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":null,\"line\":null,\"class\":\"craft\\\\controllers\\\\TemplatesController\",\"method\":\"actionRender\",\"args\":\"\\\"_entry\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":null,\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/yiisoft/yii2/base/InlineAction.php\",\"line\":57,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"[craft\\\\controllers\\\\TemplatesController, \\\"actionRender\\\"], [\\\"_entry\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"yii\\\\base\\\\InlineAction\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/yiisoft/yii2/base/Controller.php\",\"line\":157,\"class\":\"yii\\\\base\\\\InlineAction\",\"method\":\"runWithParams\",\"args\":\"[\\\"template\\\" => \\\"_entry\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/web/Controller.php\",\"line\":76,\"class\":\"yii\\\\base\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"_entry\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/yiisoft/yii2/base/Module.php\",\"line\":528,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"_entry\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/web/Application.php\",\"line\":274,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"_entry\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/yiisoft/yii2/web/Application.php\",\"line\":103,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"_entry\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/web/Application.php\",\"line\":263,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/yiisoft/yii2/base/Application.php\",\"line\":386,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/web/index.php\",\"line\":42,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"run\",\"args\":null},{\"objectClass\":null,\"file\":\"/Users/hendrik/.composer/vendor/laravel/valet/server.php\",\"line\":147,\"class\":null,\"method\":\"require\",\"args\":\"\\\"/Users/hendrik/Documents/Github/Projects/drissy/web/index.php\\\"\"}]','2018-05-17 13:07:29','2018-05-17 13:07:29','01617ae9-94bd-4226-98e6-ef5e9e2ccb99');
/*!40000 ALTER TABLE `deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elementindexsettings`
--

LOCK TABLES `elementindexsettings` WRITE;
/*!40000 ALTER TABLE `elementindexsettings` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elementindexsettings` VALUES (1,'craft\\elements\\Entry','{\"sources\":{\"section:1\":{\"tableAttributes\":{\"1\":\"postDate\",\"2\":\"expiryDate\",\"3\":\"field:8\",\"4\":\"field:49\",\"5\":\"link\"}}}}','2018-05-09 12:49:55','2018-05-09 12:49:55','d4461272-de2b-4893-b5e6-f70aef9a2ea4');
/*!40000 ALTER TABLE `elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements`
--

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements` VALUES (1,NULL,'craft\\elements\\User',1,0,'2018-04-30 15:34:51','2018-05-09 09:17:21','c2c327d7-1d14-444c-9feb-223f6b479232'),(2,2,'craft\\elements\\Entry',1,0,'2018-05-02 13:44:02','2018-05-17 13:01:45','3e82961a-c8a1-442d-a0af-30eaed2d3309'),(4,7,'craft\\elements\\MatrixBlock',1,0,'2018-05-03 10:56:50','2018-05-17 13:01:45','4bfb973b-20f4-4065-8e95-02208cfe72ed'),(10,10,'craft\\elements\\Tag',1,0,'2018-05-03 11:01:36','2018-05-03 11:01:36','4af14f8a-63c3-4d27-9cc1-bb2f48b064c0'),(24,10,'craft\\elements\\Tag',1,0,'2018-05-03 18:28:29','2018-05-03 18:28:29','680ae242-0fcb-4bff-8c4f-c02c9f83f0be'),(49,7,'craft\\elements\\MatrixBlock',1,0,'2018-05-04 18:38:52','2018-05-04 18:38:52','aa472de6-0cef-49b0-bb54-b75e52231a85'),(50,7,'craft\\elements\\MatrixBlock',1,0,'2018-05-04 18:39:00','2018-05-04 18:39:00','a5cba8f2-8047-46fd-82e4-a588183fcc91'),(51,7,'craft\\elements\\MatrixBlock',1,0,'2018-05-04 18:39:08','2018-05-04 18:39:08','d072e691-c762-437c-ae63-8bf6bc809729'),(52,7,'craft\\elements\\MatrixBlock',1,0,'2018-05-04 18:39:16','2018-05-04 18:39:16','c29fc490-381c-4567-b277-65fa4946de1a'),(53,7,'craft\\elements\\MatrixBlock',1,0,'2018-05-04 18:39:23','2018-05-04 18:39:23','f0092775-3365-4534-a86a-0076b9c18dec'),(54,7,'craft\\elements\\MatrixBlock',1,0,'2018-05-04 18:39:30','2018-05-04 18:39:30','8868e861-1090-462a-aade-94629d5f91d6'),(55,10,'craft\\elements\\Tag',1,0,'2018-05-05 10:11:13','2018-05-05 10:11:13','f36b849b-7630-4a4f-a021-95eda31ef3a5'),(56,10,'craft\\elements\\Tag',1,0,'2018-05-05 11:46:06','2018-05-05 11:46:06','1a1bed3f-2613-43a1-b086-8fd60ec744fb'),(58,19,'craft\\elements\\GlobalSet',1,0,'2018-05-05 14:54:42','2018-05-17 13:02:28','7e7ab4b6-3b63-4cd1-af4b-b11389d75e7d'),(59,20,'craft\\elements\\GlobalSet',1,0,'2018-05-05 14:55:05','2018-05-05 14:55:05','c79e9a6a-d2ef-4463-b596-10f04fda5cfb'),(60,21,'craft\\elements\\GlobalSet',1,0,'2018-05-05 14:55:25','2018-05-05 14:55:25','27306160-d4ac-4f57-bbac-4c7301674a7e'),(61,22,'craft\\elements\\GlobalSet',1,0,'2018-05-05 14:55:43','2018-05-17 13:03:01','fc300dc0-d283-4410-9478-b416cf88714b'),(62,23,'craft\\elements\\GlobalSet',1,0,'2018-05-05 14:56:01','2018-05-17 13:03:05','67c1db8f-bfbf-4fd1-a8ad-0050a55716e3'),(63,24,'craft\\elements\\GlobalSet',1,0,'2018-05-05 14:56:15','2018-05-05 14:56:15','0dd50a36-eed5-4674-93ea-1c6e6e0431aa'),(64,17,'craft\\elements\\MatrixBlock',1,0,'2018-05-05 14:59:34','2018-05-17 13:03:01','ef2338f0-c325-49f2-a6b1-0cddcc6b2999'),(67,17,'craft\\elements\\MatrixBlock',1,0,'2018-05-05 14:59:34','2018-05-17 13:03:01','4cdb18cc-d780-4ab3-8b7c-47d902eccfa1'),(68,13,'craft\\elements\\MatrixBlock',1,0,'2018-05-05 15:14:21','2018-05-17 13:02:28','6b8028eb-c870-4766-bbe3-1db671d6573a'),(74,10,'craft\\elements\\Tag',1,0,'2018-05-09 13:35:06','2018-05-09 13:35:06','8896ba8f-1ca9-4d1e-9e38-6fcada0cfa57'),(75,15,'craft\\elements\\Asset',1,0,'2018-05-09 13:36:53','2018-05-17 13:03:15','378eb6bf-76e6-4f7a-89e3-8b50cf7c11e2'),(77,10,'craft\\elements\\Tag',1,0,'2018-05-09 13:39:06','2018-05-09 13:39:06','ab3bb779-276f-4209-96be-27453a752075'),(78,15,'craft\\elements\\Asset',1,0,'2018-05-09 13:39:32','2018-05-17 13:03:15','03a118c5-ffce-490e-abc9-4949662f1950'),(80,15,'craft\\elements\\Asset',1,0,'2018-05-09 13:40:30','2018-05-17 13:03:15','7d043687-3abb-4d54-99e4-4450dc25638a'),(82,10,'craft\\elements\\Tag',1,0,'2018-05-09 13:41:14','2018-05-09 13:41:14','5b71c97b-c4d6-49a6-89ae-d02422b80a8b'),(83,10,'craft\\elements\\Tag',1,0,'2018-05-09 13:41:21','2018-05-09 13:41:21','06161023-06f1-451f-9cdb-53f128db9c3b'),(84,15,'craft\\elements\\Asset',1,0,'2018-05-09 13:41:36','2018-05-17 13:03:15','6075ce2f-f42b-4373-b9b8-ecd090115792'),(86,5,'craft\\elements\\Asset',1,0,'2018-05-09 14:32:51','2018-05-17 13:03:13','d0eb0c24-081c-4531-9b48-3806b81319b1'),(87,5,'craft\\elements\\Asset',1,0,'2018-05-09 14:33:03','2018-05-17 13:03:14','1f261526-d8b3-4368-a589-0d7236482eb5'),(88,5,'craft\\elements\\Asset',1,0,'2018-05-09 14:33:08','2018-05-17 13:03:14','97ee2526-8873-4aea-b7bb-e78ec0dc1557'),(89,5,'craft\\elements\\Asset',1,0,'2018-05-09 14:33:18','2018-05-17 13:03:14','ba224bb6-16f2-4775-9d9e-49938b414388'),(90,25,'craft\\elements\\Entry',1,0,'2018-05-14 14:28:42','2018-05-17 13:01:31','a0fe34f6-3f8c-459b-b7a4-8587c89d0c7b'),(91,26,'craft\\elements\\Entry',1,0,'2018-05-14 14:29:53','2018-05-17 13:01:58','adb0f1a6-ec69-49af-bcb8-148e7fd4c7d0'),(92,7,'craft\\elements\\MatrixBlock',1,0,'2018-05-14 14:31:07','2018-05-17 13:01:58','af0a4941-a6f4-445b-831b-25d44a243883'),(93,7,'craft\\elements\\MatrixBlock',1,0,'2018-05-14 14:31:38','2018-05-17 13:01:31','ecef848d-e9cb-46bf-aefd-6d67ce37f3ec');
/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements_sites`
--

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements_sites` VALUES (1,1,1,NULL,NULL,1,'2018-04-30 15:34:51','2018-05-09 09:17:21','e6dc4c34-570f-4aeb-be99-b86c0852551b'),(2,2,1,'homepage','__home__',1,'2018-05-02 13:44:02','2018-05-17 13:01:45','0750e19d-7597-4738-9e4a-953e4c50ed8e'),(4,4,1,NULL,NULL,1,'2018-05-03 10:56:50','2018-05-17 13:01:45','e1ed64e9-3329-41a7-a897-88df242b5366'),(10,10,1,'alban',NULL,1,'2018-05-03 11:01:36','2018-05-03 11:01:36','3c7c20fa-9a39-4af4-b66d-2b1be482c809'),(24,24,1,'wes-hicks',NULL,1,'2018-05-03 18:28:29','2018-05-03 18:28:29','4112137e-89e9-4b0d-8986-472beea85a25'),(49,49,1,NULL,NULL,1,'2018-05-04 18:38:52','2018-05-04 18:38:52','03b59824-9100-476e-9942-b13d12e31d5b'),(50,50,1,NULL,NULL,1,'2018-05-04 18:39:00','2018-05-04 18:39:00','38887ee6-130c-4d0f-87d7-7f5fc31adaa5'),(51,51,1,NULL,NULL,1,'2018-05-04 18:39:08','2018-05-04 18:39:08','aaa65250-7a3e-4c5c-9e7e-74c3b0defd26'),(52,52,1,NULL,NULL,1,'2018-05-04 18:39:16','2018-05-04 18:39:16','c099d09f-b125-4c65-8b2a-4f713acd3285'),(53,53,1,NULL,NULL,1,'2018-05-04 18:39:23','2018-05-04 18:39:23','7f37f38b-119b-47e2-aadd-98ac8c0467f1'),(54,54,1,NULL,NULL,1,'2018-05-04 18:39:30','2018-05-04 18:39:30','a7af1af2-748d-481e-a9de-af444dc048a8'),(55,55,1,'commercial',NULL,1,'2018-05-05 10:11:13','2018-05-05 10:11:13','e9ed38a4-29c3-4d2c-9512-8b32eb8b2380'),(56,56,1,'crack',NULL,1,'2018-05-05 11:46:06','2018-05-05 11:46:06','5fff93bd-c553-4a0a-958d-03177f223aae'),(58,58,1,NULL,NULL,1,'2018-05-05 14:54:42','2018-05-17 13:02:28','6a26f0f7-b839-4239-9dc4-4253d0c26c0d'),(59,59,1,NULL,NULL,1,'2018-05-05 14:55:05','2018-05-05 14:55:05','684a3312-1fe4-460d-ab07-4a05f3462682'),(60,60,1,NULL,NULL,1,'2018-05-05 14:55:25','2018-05-05 14:55:25','bb163444-617d-4cc9-8308-8b810ccbd2cd'),(61,61,1,NULL,NULL,1,'2018-05-05 14:55:43','2018-05-17 13:03:01','4e46a723-36fe-4bb1-bbcf-57f54c6f0ae4'),(62,62,1,NULL,NULL,1,'2018-05-05 14:56:01','2018-05-17 13:03:05','150a0643-f8ec-4311-b299-8a5a0c94c762'),(63,63,1,NULL,NULL,1,'2018-05-05 14:56:15','2018-05-05 14:56:15','c1ccb4ef-24ee-48ed-a7b0-00c85758c097'),(64,64,1,NULL,NULL,1,'2018-05-05 14:59:34','2018-05-17 13:03:01','790f5213-9fcd-46f2-af2f-77cdccf145ea'),(67,67,1,NULL,NULL,1,'2018-05-05 14:59:34','2018-05-17 13:03:01','7675707f-b75f-4ca6-bc99-4e445810a77b'),(68,68,1,NULL,NULL,1,'2018-05-05 15:14:21','2018-05-17 13:02:28','b1e2aa15-557c-4b14-936f-374589283d9e'),(74,74,1,'crime',NULL,1,'2018-05-09 13:35:06','2018-05-09 13:35:06','9d6336dc-34bb-4cf4-b44d-3ca74d9b5c79'),(75,75,1,NULL,NULL,1,'2018-05-09 13:36:53','2018-05-17 13:03:15','a7687b74-b3ca-4d55-a9ef-a227f04ea5ad'),(77,77,1,'drama',NULL,1,'2018-05-09 13:39:06','2018-05-09 13:39:06','00c6d930-2df2-460f-a478-78ba64b06e23'),(78,78,1,NULL,NULL,1,'2018-05-09 13:39:32','2018-05-17 13:03:15','b9df0fa7-404b-4337-8518-f18b644086d8'),(80,80,1,NULL,NULL,1,'2018-05-09 13:40:30','2018-05-17 13:03:15','b558f9a0-055f-4741-842d-9cb02ab2c1e5'),(82,82,1,'trash',NULL,1,'2018-05-09 13:41:14','2018-05-09 13:41:14','00c6c99e-c38b-4758-b9da-831342e51a41'),(83,83,1,'gamble',NULL,1,'2018-05-09 13:41:21','2018-05-09 13:41:21','bb4a3b53-5cd1-4627-bade-a56db007f178'),(84,84,1,NULL,NULL,1,'2018-05-09 13:41:36','2018-05-17 13:03:15','e4ae6802-4640-4724-887b-84dd2dd75ca9'),(86,86,1,NULL,NULL,1,'2018-05-09 14:32:51','2018-05-17 13:03:13','eebf821d-da65-40a5-9421-65afc967e6a5'),(87,87,1,NULL,NULL,1,'2018-05-09 14:33:03','2018-05-17 13:03:14','f7848072-0ca7-4061-b8ad-0a2f639956c7'),(88,88,1,NULL,NULL,1,'2018-05-09 14:33:08','2018-05-17 13:03:14','528fe799-f616-4d36-a2cf-6e09737682dd'),(89,89,1,NULL,NULL,1,'2018-05-09 14:33:18','2018-05-17 13:03:14','e062d671-6a9b-4e01-bc98-89f83f562498'),(90,90,1,'article','imprint',1,'2018-05-14 14:28:42','2018-05-17 13:01:31','4c792f03-c556-4ddb-96bf-f19604a4bdd5'),(91,91,1,'data-protection','data-protection',1,'2018-05-14 14:29:53','2018-05-17 13:01:58','86690442-d911-4fff-963b-1ca6673dd006'),(92,92,1,NULL,NULL,1,'2018-05-14 14:31:07','2018-05-17 13:01:58','96f7c313-8e1c-4ee5-9622-5298ca84a0c9'),(93,93,1,NULL,NULL,1,'2018-05-14 14:31:38','2018-05-17 13:01:31','e3a2a900-646d-4598-8ee5-907712691679');
/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entries`
--

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entries` VALUES (2,2,2,NULL,'2018-05-02 13:44:02',NULL,'2018-05-02 13:44:02','2018-05-17 13:01:45','22f3a55e-321d-460c-91ec-d7880db97383'),(90,5,7,NULL,'2018-05-14 14:28:42',NULL,'2018-05-14 14:28:42','2018-05-17 13:01:31','a5b9bc33-e4a1-4567-96ed-804f12a628e0'),(91,6,8,NULL,'2018-05-14 14:29:53',NULL,'2018-05-14 14:29:53','2018-05-17 13:01:58','8e7cf912-3f70-4432-99d8-f052daa333c9');
/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entrydrafts`
--

LOCK TABLES `entrydrafts` WRITE;
/*!40000 ALTER TABLE `entrydrafts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `entrydrafts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entrytypes`
--

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entrytypes` VALUES (1,1,1,'Default','default',1,'Title',NULL,1,'2018-05-02 13:43:24','2018-05-09 12:50:16','67797e8a-96a4-44e1-ae74-2ff7b279c59c'),(2,2,2,'Homepage','homepage',1,'Title',NULL,1,'2018-05-02 13:44:01','2018-05-14 14:29:04','a3f178d7-ee1d-4173-bf3a-3d230419eaf9'),(7,5,25,'Imprint','imprint',1,'Title',NULL,1,'2018-05-14 14:21:09','2018-05-14 14:28:58','33dbe04e-6c30-4287-a98d-e3302f0e7274'),(8,6,26,'Data Protection','dataProtection',1,'Title',NULL,1,'2018-05-14 14:29:53','2018-05-14 14:32:14','71d9f841-ae8f-431f-955c-667c0728ded7');
/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entryversions`
--

LOCK TABLES `entryversions` WRITE;
/*!40000 ALTER TABLE `entryversions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entryversions` VALUES (1,2,2,1,1,1,'Revision from May 3, 2018, 3:22:10 AM','{\"typeId\":\"2\",\"authorId\":null,\"title\":\"Homepage\",\"slug\":\"homepage\",\"postDate\":1525268642,\"expiryDate\":null,\"enabled\":\"1\",\"newParentId\":null,\"fields\":{\"3\":[]}}','2018-05-03 10:23:42','2018-05-03 10:23:42','183af983-4002-4cd6-9e54-b37a934543c6'),(2,2,2,1,1,2,'','{\"typeId\":\"2\",\"authorId\":null,\"title\":\"Homepage\",\"slug\":\"homepage\",\"postDate\":1525268642,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"3\":{\"4\":{\"type\":\"text\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"textContent\":\"<p>Lorem ipsum dolor amet stumptown vape blue bottle leggings. Tousled celiac sriracha, godard photo booth banh mi meh four loko pop-up drinking vinegar butcher art party before they sold out hell of. Ramps church-key schlitz, kombucha prism tumblr health goth intelligentsia readymade chillwave affogato butcher. Pork belly 90\'s vice tote bag truffaut helvetica PBR&amp;B direct trade readymade green juice pitchfork prism. Cloud bread poke irony neutra pop-up yuccie YOLO disrupt.</p><p>Crucifix taiyaki squid heirloom, prism farm-to-table meditation occupy everyday carry mustache aesthetic master cleanse. Kitsch craft beer 3 wolf moon tofu shoreditch. Literally wolf taiyaki selfies, freegan keffiyeh tumeric portland pickled vexillologist fam bicycle rights austin snackwave. Intelligentsia man bun food truck, knausgaard blue bottle messenger bag williamsburg tacos hexagon disrupt. Williamsburg subway tile roof party waistcoat.</p>\"}},\"5\":{\"type\":\"image\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"image\":[\"3\"],\"caption\":\"Braden Collum\",\"layout\":\"full\"}}}}}','2018-05-03 10:56:50','2018-05-03 10:56:50','103325f4-4bd0-4ce7-b832-3fd72ff09367'),(17,2,2,1,1,3,'','{\"typeId\":\"2\",\"authorId\":null,\"title\":\"Homepage\",\"slug\":\"homepage\",\"postDate\":1525268642,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"3\":{\"4\":{\"type\":\"text\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"textContent\":\"<p>Lorem ipsum dolor amet stumptown vape blue bottle leggings. Tousled celiac sriracha, godard photo booth banh mi meh four loko pop-up drinking vinegar butcher art party before they sold out hell of. Ramps church-key schlitz, kombucha prism tumblr health goth intelligentsia readymade chillwave affogato butcher. Pork belly 90\'s vice tote bag truffaut helvetica PBR&amp;B direct trade readymade green juice pitchfork prism. Cloud bread poke irony neutra pop-up yuccie YOLO disrupt.</p>\\n<p>Crucifix taiyaki squid heirloom, prism farm-to-table meditation occupy everyday carry mustache aesthetic master cleanse. Kitsch craft beer 3 wolf moon tofu shoreditch. Literally wolf taiyaki selfies, freegan keffiyeh tumeric portland pickled vexillologist fam bicycle rights austin snackwave. Intelligentsia man bun food truck, knausgaard blue bottle messenger bag williamsburg tacos hexagon disrupt. Williamsburg subway tile roof party waistcoat.</p>\\n\"}},\"5\":{\"type\":\"image\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"image\":[\"16\"],\"caption\":\"Image Caption\",\"layout\":\"full\"}}}}}','2018-05-03 18:31:45','2018-05-03 18:31:45','11c2af9f-544b-4710-a826-a836aded1c3f'),(88,91,6,1,1,1,'Revision from May 14, 2018, 7:30:17 AM','{\"typeId\":\"8\",\"authorId\":null,\"title\":\"Data Protection\",\"slug\":\"data-protection\",\"postDate\":1526308193,\"expiryDate\":null,\"enabled\":\"1\",\"newParentId\":null,\"fields\":{\"3\":[]}}','2018-05-14 14:31:07','2018-05-14 14:31:07','542dd164-38c6-4d10-9df8-aba0a15a50f3'),(89,91,6,1,1,2,'','{\"typeId\":\"8\",\"authorId\":null,\"title\":\"Data Protection\",\"slug\":\"data-protection\",\"postDate\":1526308193,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"3\":{\"92\":{\"type\":\"text\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"textContent\":\"<p>Hello this is Datenschutz</p>\\n\"}}}}}','2018-05-14 14:31:07','2018-05-14 14:31:07','5742480d-aeed-4b3a-b987-77948a1a7718'),(90,90,5,1,1,1,'Revision from May 14, 2018, 7:28:59 AM','{\"typeId\":\"7\",\"authorId\":null,\"title\":\"Article\",\"slug\":\"article\",\"postDate\":1526308122,\"expiryDate\":null,\"enabled\":\"1\",\"newParentId\":null,\"fields\":{\"3\":[]}}','2018-05-14 14:31:38','2018-05-14 14:31:38','750082e5-20d3-4904-8992-db5c2ac3958c'),(91,90,5,1,1,2,'','{\"typeId\":\"7\",\"authorId\":null,\"title\":\"Impressum\",\"slug\":\"article\",\"postDate\":1526308122,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"3\":{\"93\":{\"type\":\"text\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"textContent\":\"<p>Hello this is Impressum</p>\\n\"}}}}}','2018-05-14 14:31:38','2018-05-14 14:31:38','0ef0da19-1801-4682-8e75-3391a847a3f7'),(92,91,6,1,1,3,'','{\"typeId\":\"8\",\"authorId\":null,\"title\":\"Datenschutz\",\"slug\":\"data-protection\",\"postDate\":1526308193,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"3\":{\"92\":{\"type\":\"text\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"textContent\":\"<p>Hello this is Datenschutz</p>\\n\"}}}}}','2018-05-14 14:32:24','2018-05-14 14:32:24','3dfc8d6c-1315-4c03-837d-2a6d3783495f'),(93,90,5,1,1,3,'','{\"typeId\":\"7\",\"authorId\":null,\"title\":\"Impressum\",\"slug\":\"article\",\"postDate\":1526308122,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"3\":{\"93\":{\"type\":\"text\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"textContent\":\"<p><br /></p><p>Angaben gemäß § 5 TMG:</p>\\n<p>Werner, Jung &amp; Kluth GbR<br />Pinnasberg  29-33<br />20359 Hamburg</p>\\n<p>Vertreten durch:<br />Hendrik Werner<br />Julian Jung<br />Pawel Kluth</p>\\n<p>Kontakt:<br />Telefon: +49 40 226 33 7 55<br />E-Mail: hi@wewereyoung.de</p>\\n<p>Umsatzsteuer:<br />Umsatzsteuer-Identifikationsnummer gemäß §27 a Umsatzsteuergesetz:<br />DE 304 113 177</p>\\n<p>Haftung für Inhalte<br />Als Diensteanbieter sind wir gemäß § 7 Abs.1 TMG für eigene Inhalte auf diesen Seiten nach den allgemeinen Gesetzen verantwortlich. Nach §§ 8 bis 10 TMG sind wir als Diensteanbieter jedoch nicht verpflichtet, übermittelte oder gespeicherte fremde Informationen zu überwachen oder nach Umständen zu forschen, die auf eine rechtswidrige Tätigkeit hinweisen.<br />Verpflichtungen zur Entfernung oder Sperrung der Nutzung von Informationen nach den allgemeinen Gesetzen bleiben hiervon unberührt. Eine diesbezügliche Haftung ist jedoch erst ab dem Zeitpunkt der Kenntnis einer konkreten Rechtsverletzung möglich. Bei Bekanntwerden von entsprechenden Rechtsverletzungen werden wir diese Inhalte umgehend entfernen.</p>\\n<p>Haftung für Links</p>\\n<p>Unser Angebot enthält Links zu externen Webseiten Dritter, auf deren Inhalte wir keinen Einfluss haben. Deshalb können wir für diese fremden Inhalte auch keine Gewähr übernehmen. Für die Inhalte der verlinkten Seiten ist stets der jeweilige Anbieter oder Betreiber der Seiten verantwortlich. Die verlinkten Seiten wurden zum Zeitpunkt der Verlinkung auf mögliche Rechtsverstöße überprüft. Rechtswidrige Inhalte waren zum Zeitpunkt der Verlinkung nicht erkennbar.<br />Eine permanente inhaltliche Kontrolle der verlinkten Seiten ist jedoch ohne konkrete Anhaltspunkte einer Rechtsverletzung nicht zumutbar. Bei Bekanntwerden von Rechtsverletzungen werden wir derartige Links umgehend entfernen.</p>\\n<p>Urheberrecht<br />Die durch die Seitenbetreiber erstellten Inhalte und Werke auf diesen Seiten unterliegen dem deutschen Urheberrecht. Die Vervielfältigung, Bearbeitung, Verbreitung und jede Art der Verwertung außerhalb der Grenzen des Urheberrechtes bedürfen der schriftlichen Zustimmung des jeweiligen Autors bzw. Erstellers. Downloads und Kopien dieser Seite sind nur für den privaten, nicht kommerziellen Gebrauch gestattet.</p>\\n<p>Soweit die Inhalte auf dieser Seite nicht vom Betreiber erstellt wurden, werden die Urheberrechte Dritter beachtet. Insbesondere werden Inhalte Dritter als solche gekennzeichnet. Sollten Sie trotzdem auf eine Urheberrechtsverletzung aufmerksam werden, bitten wir um einen entsprechenden Hinweis. Bei Bekanntwerden von Rechtsverletzungen werden wir derartige Inhalte umgehend entfernen.</p>\\n<p><br /></p>\\n\"}}}}}','2018-05-14 14:45:22','2018-05-14 14:45:22','ca047a20-b519-4cae-9a81-713a272fc0ff'),(94,91,6,1,1,4,'','{\"typeId\":\"8\",\"authorId\":null,\"title\":\"Datenschutz\",\"slug\":\"data-protection\",\"postDate\":1526308193,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"3\":{\"92\":{\"type\":\"text\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"textContent\":\"<p><strong>Datenschutz</strong></p>\\n<p>Die Betreiber dieser Seiten nehmen den Schutz Ihrer persönlichen Daten sehr ernst. Wir behandeln Ihre personenbezogenen Daten vertraulich und entsprechend der gesetzlichen Datenschutzvorschriften sowie dieser Datenschutzerklärung. Die Nutzung unserer Webseite ist in der Regel ohne Angabe personenbezogener Daten möglich. Soweit auf unseren Seiten personenbezogene Daten (beispielsweise Name, Anschrift oder E-Mail-Adressen) erhoben werden, erfolgt dies, soweit möglich, stets auf freiwilliger Basis. Diese Daten werden ohne Ihre ausdrückliche Zustimmung nicht an Dritte weitergegeben. Wir weisen darauf hin, dass die Datenübertragung im Internet (z.B. bei der Kommunikation per E-Mail) Sicherheitslücken aufweisen kann. Ein lückenloser Schutz der Daten vor dem Zugriff durch Dritte ist nicht möglich.</p>\\n<p><strong>Cookies</strong></p>\\n<p>Die Internetseiten verwenden teilweise so genannte Cookies. Cookies richten auf Ihrem Rechner keinen Schaden an und enthalten keine Viren. Cookies dienen dazu, unser Angebot nutzerfreundlicher, effektiver und sicherer zu machen. Cookies sind kleine Textdateien, die auf Ihrem Rechner abgelegt werden und die Ihr Browser speichert. Die meisten der von uns verwendeten Cookies sind so genannte „Session-Cookies“. Sie werden nach Ende Ihres Besuchs automatisch gelöscht. Andere Cookies bleiben auf Ihrem Endgerät gespeichert, bis Sie diese löschen. Diese Cookies ermöglichen es uns, Ihren Browser beim nächsten Besuch wiederzuerkennen. Sie können Ihren Browser so einstellen, dass Sie über das Setzen von Cookies informiert werden und Cookies nur im Einzelfall erlauben, die Annahme von Cookies für bestimmte Fälle oder generell ausschließen sowie das automatische Löschen der Cookies beim Schließen des Browser aktivieren. Bei der Deaktivierung von Cookies kann die Funktionalität dieser Website eingeschränkt sein.</p>\\n<p><strong>Server-Log-Files</strong></p>\\n<p>Der Provider der Seiten erhebt und speichert automatisch Informationen in so genannten Server-Log Files, die Ihr Browser automatisch an uns übermittelt. Dies sind:</p>\\n<ul><li>Browsertyp und Browserversion</li><li>verwendetes Betriebssystem</li><li>Referrer URL</li><li>Hostname des zugreifenden Rechners</li><li>Uhrzeit der Serveranfrage</li></ul>\\n<p>Diese Daten sind nicht bestimmten Personen zuordenbar. Eine Zusammenführung dieser Daten mit anderen Datenquellen wird nicht vorgenommen. Wir behalten uns vor, diese Daten nachträglich zu prüfen, wenn uns konkrete Anhaltspunkte für eine rechtswidrige Nutzung bekannt werden.</p>\\n<p><strong>Kontaktformular</strong></p>\\n<p>Wenn Sie uns per Kontaktformular Anfragen zukommen lassen, werden Ihre Angaben aus dem Anfrageformular inklusive der von Ihnen dort angegebenen Kontaktdaten zwecks Bearbeitung der Anfrage und für den Fall von Anschlussfragen bei uns gespeichert. Diese Daten geben wir nicht ohne Ihre Einwilligung weiter.</p>\\n<p><strong>Google Analytics</strong></p>\\n<p>Diese Website nutzt Funktionen des Webanalysedienstes Google Analytics. Anbieter ist die Google Inc.,1600 Amphitheatre Parkway Mountain View, CA 94043, USA. Google Analytics verwendet so genannte \\\"Cookies\\\". Das sind Textdateien, die auf Ihrem Computer gespeichert werden und die eine Analyse der Benutzung der Website durch Sie ermöglichen. Die durch den Cookie erzeugten Informationen über Ihre Benutzung dieser Website werden in der Regel an einen Server von Google in den USA übertragen und dort gespeichert.</p>\\n<p><strong>IP-Anonymisierung</strong></p>\\n<p>Wir haben auf dieser Webseite die Funktion IP-Anonymisierung aktiviert. Dadurch wird Ihre IP-Adresse von Google innerhalb von Mitgliedstaaten der Europäischen Union oder in anderen Vertragsstaaten des Abkommens über den Europäischen Wirtschaftsraum vor der Übermittlung in die USA gekürzt. Nur in Ausnahmefällen wird die volle IP-Adresse an einen Server von Google in den USA übertragen und dort gekürzt. Im Auftrag des Betreibers dieser Website wird Google diese Informationen benutzen, um Ihre Nutzung der Website auszuwerten, um Reports über die Websiteaktivitäten zusammenzustellen und um weitere mit der Websitenutzung und der Internetnutzung verbundene Dienstleistungen gegenüber dem Websitebetreiber zu erbringen. Die im Rahmen von Google Analytics von Ihrem Browser übermittelte IPAdresse wird nicht mit anderen Daten von Google zusammengeführt.</p>\\n<p><strong>Browser Plugin</strong></p>\\n<p>Sie können die Speicherung der Cookies durch eine entsprechende Einstellung Ihrer Browser-Software verhindern; wir weisen Sie jedoch darauf hin, dass Sie in diesem Fall gegebenenfalls nicht sämtliche Funktionen dieser Website vollumfänglich werden nutzen können. Sie können darüber hinaus die Erfassung der durch den Cookie erzeugten und auf Ihre Nutzung der Website bezogenen Daten (inkl. Ihrer IP-Adresse) an Google sowie die Verarbeitung dieser Daten durch Google verhindern, indem Sie das unter dem folgenden Link verfügbare Browser-Plugin herunterladen und installieren: <a href=\\\"https://tools.google.com/dlpage/gaoptout?hl=de\\\">https://tools.google.com/dlpage/gaoptout?hl=de</a></p>\\n<p><strong>Widerspruch gegen Datenerfassung</strong></p>\\n<p>Sie können die Erfassung Ihrer Daten durch Google Analytics verhindern, indem Sie auf folgenden Link klicken. Es wird ein Opt-Out-Cookie gesetzt, der die Erfassung Ihrer Daten bei zukünftigen Besuchen dieser Website verhindert: Google Analytics deaktivieren Mehr Informationen zum Umgang mit Nutzerdaten bei Google Analytics finden Sie in der Datenschutzerklärung von Google: <a href=\\\"https://support.google.com/analytics/answer/6004245?hl=de\\\">https://support.google.com/analytics/answer/6004245?hl=de</a></p>\\n<p><strong>Auftragsdatenverarbeitung</strong></p>\\n<p>Wir haben mit Google einen Vertrag zur Auftragsdatenverarbeitung abgeschlossen und setzen die strengen Vorgaben der deutschen Datenschutzbehörden bei der Nutzung von Google Analytics vollständig um.</p>\\n<p><strong>Demografische Merkmale bei Google Analytics</strong></p>\\n<p>Diese Website nutzt die Funktion “demografische Merkmale” von Google Analytics. Dadurch können Berichte erstellt werden, die Aussagen zu Alter, Geschlecht und Interessen der Seitenbesucher enthalten. Diese Daten stammen aus interessenbezogener Werbung von Google sowie aus Besucherdaten von Drittanbietern. Diese Daten können keiner bestimmten Person zugeordnet werden. Sie können diese Funktion jederzeit über die Anzeigeneinstellungen in Ihrem Google-Konto deaktivieren oder die Erfassung Ihrer Daten durch Google Analytics wie im Punkt “Widerspruch gegen Datenerfassung” dargestellt generell untersagen.</p>\\n<p><strong>SSL-Verschlüsselung</strong></p>\\n<p>Diese Seite nutzt aus Gründen der Sicherheit und zum Schutz der Übertragung vertraulicher Inhalte, wie zum Beispiel der Anfragen, die Sie an uns als Seitenbetreiber senden, eine SSL-Verschlüsselung. Eine verschlüsselte Verbindung erkennen Sie daran, dass die Adresszeile des Browsers von \\\"http://\\\" auf \\\"https://\\\" wechselt und an dem Schloss-Symbol in Ihrer Browserzeile.Wenn die SSL Verschlüsselung aktiviert ist, können die Daten, die Sie an uns übermitteln, nicht von Dritten mitgelesen werden.</p>\\n\"}}}}}','2018-05-14 14:46:09','2018-05-14 14:46:09','eb65237e-386e-4fd3-a2c1-b73de091d901'),(95,90,5,1,1,4,'','{\"typeId\":\"7\",\"authorId\":null,\"title\":\"Impressum\",\"slug\":\"article\",\"postDate\":1526308122,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"3\":{\"93\":{\"type\":\"text\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"textContent\":\"<p><br />Angaben gemäß § 5 TMG:</p>\\n<p>Werner, Jung &amp; Kluth GbR<br />Pinnasberg  29-33<br />20359 Hamburg</p>\\n<p>Vertreten durch:<br />Hendrik Werner<br />Julian Jung<br />Pawel Kluth</p>\\n<p>Kontakt:<br />Telefon: +49 40 226 33 7 55<br />E-Mail: hi@wewereyoung.de</p>\\n<p>Umsatzsteuer:<br />Umsatzsteuer-Identifikationsnummer gemäß §27 a Umsatzsteuergesetz:<br />DE 304 113 177</p>\\n<p>Haftung für Inhalte<br />Als Diensteanbieter sind wir gemäß § 7 Abs.1 TMG für eigene Inhalte auf diesen Seiten nach den allgemeinen Gesetzen verantwortlich. Nach §§ 8 bis 10 TMG sind wir als Diensteanbieter jedoch nicht verpflichtet, übermittelte oder gespeicherte fremde Informationen zu überwachen oder nach Umständen zu forschen, die auf eine rechtswidrige Tätigkeit hinweisen.<br />Verpflichtungen zur Entfernung oder Sperrung der Nutzung von Informationen nach den allgemeinen Gesetzen bleiben hiervon unberührt. Eine diesbezügliche Haftung ist jedoch erst ab dem Zeitpunkt der Kenntnis einer konkreten Rechtsverletzung möglich. Bei Bekanntwerden von entsprechenden Rechtsverletzungen werden wir diese Inhalte umgehend entfernen.</p>\\n<p>Haftung für Links</p>\\n<p>Unser Angebot enthält Links zu externen Webseiten Dritter, auf deren Inhalte wir keinen Einfluss haben. Deshalb können wir für diese fremden Inhalte auch keine Gewähr übernehmen. Für die Inhalte der verlinkten Seiten ist stets der jeweilige Anbieter oder Betreiber der Seiten verantwortlich. Die verlinkten Seiten wurden zum Zeitpunkt der Verlinkung auf mögliche Rechtsverstöße überprüft. Rechtswidrige Inhalte waren zum Zeitpunkt der Verlinkung nicht erkennbar.<br />Eine permanente inhaltliche Kontrolle der verlinkten Seiten ist jedoch ohne konkrete Anhaltspunkte einer Rechtsverletzung nicht zumutbar. Bei Bekanntwerden von Rechtsverletzungen werden wir derartige Links umgehend entfernen.</p>\\n<p>Urheberrecht<br />Die durch die Seitenbetreiber erstellten Inhalte und Werke auf diesen Seiten unterliegen dem deutschen Urheberrecht. Die Vervielfältigung, Bearbeitung, Verbreitung und jede Art der Verwertung außerhalb der Grenzen des Urheberrechtes bedürfen der schriftlichen Zustimmung des jeweiligen Autors bzw. Erstellers. Downloads und Kopien dieser Seite sind nur für den privaten, nicht kommerziellen Gebrauch gestattet.</p>\\n<p>Soweit die Inhalte auf dieser Seite nicht vom Betreiber erstellt wurden, werden die Urheberrechte Dritter beachtet. Insbesondere werden Inhalte Dritter als solche gekennzeichnet. Sollten Sie trotzdem auf eine Urheberrechtsverletzung aufmerksam werden, bitten wir um einen entsprechenden Hinweis. Bei Bekanntwerden von Rechtsverletzungen werden wir derartige Inhalte umgehend entfernen.</p>\\n\"}}}}}','2018-05-14 14:47:00','2018-05-14 14:47:00','b0aac8e9-589b-4c04-8ab6-d44704a74f0f'),(96,90,5,1,1,5,'','{\"typeId\":\"7\",\"authorId\":null,\"title\":\"Impressum\",\"slug\":\"article\",\"postDate\":1526308122,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"3\":{\"93\":{\"type\":\"text\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"textContent\":\"<p><br /></p><br />\\n\"}}}}}','2018-05-17 13:01:31','2018-05-17 13:01:31','af0524e1-9a79-4f08-ad00-66f6edab24c6'),(97,2,2,1,1,4,'','{\"typeId\":\"2\",\"authorId\":null,\"title\":\"Homepage\",\"slug\":\"homepage\",\"postDate\":1525268642,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"3\":{\"4\":{\"type\":\"text\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"textContent\":\"<p><br /></p>\\n\"}}}}}','2018-05-17 13:01:45','2018-05-17 13:01:45','69409e72-1593-4160-8bc3-49d2a85591f8'),(98,91,6,1,1,5,'','{\"typeId\":\"8\",\"authorId\":null,\"title\":\"Datenschutz\",\"slug\":\"data-protection\",\"postDate\":1526308193,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"3\":{\"92\":{\"type\":\"text\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"textContent\":\"<p><br /></p>\\n\"}}}}}','2018-05-17 13:01:58','2018-05-17 13:01:58','ccf55052-28d0-49e2-ad9b-87a95082c964');
/*!40000 ALTER TABLE `entryversions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldgroups`
--

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldgroups` VALUES (1,'Default','2018-04-30 15:34:51','2018-05-02 13:47:05','e1ec6658-e650-41d6-a8b2-4892e452865b'),(3,'Globals','2018-05-05 14:13:31','2018-05-05 14:13:31','5a27fb7b-bf48-4ac9-afdc-02d559faa2fc');
/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayoutfields`
--

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayoutfields` VALUES (143,13,53,25,0,1,'2018-05-05 14:15:55','2018-05-05 14:15:55','bccf0aad-c0a9-49b2-a135-668e1e0848b9'),(144,13,53,26,0,2,'2018-05-05 14:15:55','2018-05-05 14:15:55','6db7753d-675b-4f6c-addc-c64e206c77a2'),(145,13,53,27,0,3,'2018-05-05 14:15:55','2018-05-05 14:15:55','be230a88-056a-42b3-8208-eaa3356fff79'),(146,13,53,28,0,4,'2018-05-05 14:15:55','2018-05-05 14:15:55','6637b7a7-3270-4e91-a119-292172eef413'),(147,13,53,29,0,5,'2018-05-05 14:15:55','2018-05-05 14:15:55','fa260d36-b438-4eb9-b0c6-103a1d570d21'),(148,13,53,30,0,6,'2018-05-05 14:15:55','2018-05-05 14:15:55','8453e341-55ae-4f59-b471-2ba3f3f7019f'),(149,13,53,31,0,7,'2018-05-05 14:15:55','2018-05-05 14:15:55','dee0d8e4-fcd2-410d-b3ba-edd04d4c5781'),(150,13,53,32,0,8,'2018-05-05 14:15:55','2018-05-05 14:15:55','706c0ad0-8b9c-441a-b086-17c652e66479'),(158,18,58,41,0,1,'2018-05-05 14:52:41','2018-05-05 14:52:41','4e5cc467-afe1-4679-9d28-76df04a2eb95'),(159,18,58,42,0,2,'2018-05-05 14:52:41','2018-05-05 14:52:41','730c855b-fb3e-4909-9cba-51d79e27fb2b'),(160,18,58,43,0,3,'2018-05-05 14:52:41','2018-05-05 14:52:41','fca93dbf-d098-49b7-9325-43f12b279678'),(161,18,58,44,0,4,'2018-05-05 14:52:41','2018-05-05 14:52:41','760b06b8-e532-4b57-a933-24c7e707b900'),(162,18,58,45,0,5,'2018-05-05 14:52:41','2018-05-05 14:52:41','2b25971c-0a77-4e3f-b026-555167f12246'),(163,18,58,46,0,6,'2018-05-05 14:52:41','2018-05-05 14:52:41','bc1f41cf-8aa7-47f7-bd0c-aa0abd90143d'),(164,18,58,47,0,7,'2018-05-05 14:52:41','2018-05-05 14:52:41','3e8847af-b8af-495c-b815-1e51bc7470c6'),(165,7,59,9,0,1,'2018-05-05 14:53:08','2018-05-05 14:53:08','4d2b9613-b8b3-4dc2-9444-22bad2c7d6ee'),(166,8,60,10,0,1,'2018-05-05 14:53:08','2018-05-05 14:53:08','d0e9b622-43b4-43f8-a040-53f5843e0dc9'),(167,8,60,11,0,2,'2018-05-05 14:53:08','2018-05-05 14:53:08','42bffcd1-b6fe-4cec-80b8-cdac81a4d318'),(168,9,61,12,1,1,'2018-05-05 14:53:08','2018-05-05 14:53:08','784075c5-cb7a-4222-83d1-3b10a4e2fa14'),(169,9,61,13,0,2,'2018-05-05 14:53:08','2018-05-05 14:53:08','8241f39e-5b9f-431f-ac37-8b5efc88676c'),(170,9,61,14,0,3,'2018-05-05 14:53:08','2018-05-05 14:53:08','a8c2f94c-758c-43ac-9b06-cc121bef3286'),(171,19,62,24,0,1,'2018-05-05 14:54:42','2018-05-05 14:54:42','3b85a0f4-f2fa-4455-908a-d7ffa6edf531'),(172,20,63,33,0,1,'2018-05-05 14:55:05','2018-05-05 14:55:05','cccd835b-9808-4f62-8957-178ccf51efcf'),(173,21,64,34,0,1,'2018-05-05 14:55:25','2018-05-05 14:55:25','1d8aa828-ebf2-4301-b0ac-e5c322181005'),(174,22,65,35,0,1,'2018-05-05 14:55:43','2018-05-05 14:55:43','0f7e90b6-d279-424a-92a2-29cc390f11e6'),(175,23,66,39,0,1,'2018-05-05 14:56:01','2018-05-05 14:56:01','86805ed2-65a6-4875-9959-90bf3659a7dc'),(176,24,67,40,0,1,'2018-05-05 14:56:15','2018-05-05 14:56:15','464c839a-7665-4273-b9f7-5dab96e3d17b'),(196,17,73,36,0,1,'2018-05-09 10:36:46','2018-05-09 10:36:46','c8418a21-4d06-48b5-9829-809d162f9014'),(197,17,73,37,0,2,'2018-05-09 10:36:46','2018-05-09 10:36:46','f58a715c-7d60-4898-9b17-f592e2adcd2a'),(198,17,73,38,0,3,'2018-05-09 10:36:46','2018-05-09 10:36:46','3baabd12-4904-4390-969a-137b6703d87a'),(199,17,73,48,0,4,'2018-05-09 10:36:46','2018-05-09 10:36:46','6fc1f7ec-282c-4e41-90b0-ceb4b43c61ab'),(223,1,78,8,0,1,'2018-05-09 12:50:16','2018-05-09 12:50:16','fe5ac28a-5f4d-429e-b1bb-6c419e3003e3'),(224,1,78,6,0,2,'2018-05-09 12:50:16','2018-05-09 12:50:16','a06d0c56-56aa-4fce-b121-c9c66d11eb96'),(225,1,79,49,1,1,'2018-05-09 12:50:16','2018-05-09 12:50:16','3f9956fe-6e65-407b-8fe8-30b3c1d9cb61'),(226,1,79,15,0,2,'2018-05-09 12:50:16','2018-05-09 12:50:16','f8cd9864-3298-438e-84f2-6d30ac1bf3fe'),(227,1,79,16,0,3,'2018-05-09 12:50:16','2018-05-09 12:50:16','f8565ed4-f2a7-4457-b18b-1a4e81070320'),(228,1,79,17,0,4,'2018-05-09 12:50:16','2018-05-09 12:50:16','f2e750fc-63f8-4ca0-af04-e1f76aadbd24'),(229,1,79,18,0,5,'2018-05-09 12:50:16','2018-05-09 12:50:16','3c4195e5-04e3-48ca-a678-281ec1b94d3e'),(230,1,79,19,0,6,'2018-05-09 12:50:16','2018-05-09 12:50:16','028da4fa-28d0-4079-a59f-2597274faa46'),(231,1,79,20,0,7,'2018-05-09 12:50:16','2018-05-09 12:50:16','51d449a6-0819-4930-b54f-00ec3979abee'),(232,1,79,21,0,8,'2018-05-09 12:50:16','2018-05-09 12:50:16','bfcbf08e-9076-410c-836a-c5bea60b5e45'),(233,1,79,22,0,9,'2018-05-09 12:50:16','2018-05-09 12:50:16','c08e17d6-5d3d-4986-a884-c5e87b304f68'),(237,25,83,3,0,1,'2018-05-14 14:28:58','2018-05-14 14:28:58','84e6bae7-cfd0-4072-8ab6-61ab51ee0d07'),(238,2,84,3,1,1,'2018-05-14 14:29:04','2018-05-14 14:29:04','5de54a2f-6657-4133-80c3-00ebcf56b603'),(240,26,86,3,0,1,'2018-05-14 14:32:14','2018-05-14 14:32:14','cb41404b-ee30-46f7-8092-77428b6dc889');
/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouts`
--

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayouts` VALUES (1,'craft\\elements\\Entry','2018-05-02 13:43:24','2018-05-09 12:50:16','05d96a5e-1221-47da-802e-94cda60e2879'),(2,'craft\\elements\\Entry','2018-05-02 13:44:01','2018-05-14 14:29:04','3ff7feb7-9483-4284-9ee1-a88e94eb0d73'),(5,'craft\\elements\\Asset','2018-05-02 14:08:06','2018-05-05 14:21:09','20ca6733-f934-4cdf-bbfe-4c695639d2cd'),(6,'craft\\elements\\Asset','2018-05-02 14:08:20','2018-05-05 10:02:36','a1b0b660-a144-4776-ae6a-d7b431caccba'),(7,'craft\\elements\\MatrixBlock','2018-05-03 10:26:23','2018-05-05 14:53:08','6bd39c9d-e32a-421a-a19d-a4b2220176e4'),(8,'craft\\elements\\MatrixBlock','2018-05-03 10:26:23','2018-05-05 14:53:08','0acbaec7-d348-43d6-b3ef-4b4a8a5ae5f3'),(9,'craft\\elements\\MatrixBlock','2018-05-03 10:26:23','2018-05-05 14:53:08','0263a468-3bfa-42aa-bbf9-9506e07441f5'),(10,'craft\\elements\\Tag','2018-05-03 11:01:12','2018-05-03 11:01:12','fed836f5-1e45-43fc-b7a9-ea52237c9522'),(13,'craft\\elements\\MatrixBlock','2018-05-05 14:15:55','2018-05-05 14:15:55','515d060c-f927-41a8-a079-34e3c78db28a'),(14,'craft\\elements\\Asset','2018-05-05 14:19:33','2018-05-05 14:20:25','2c14f4ce-84b3-4c65-b92b-90fcc10e8e56'),(15,'craft\\elements\\Asset','2018-05-05 14:19:49','2018-05-05 14:19:49','7b3f9391-27fa-4515-9a53-9c87eee777fd'),(16,'craft\\elements\\Asset','2018-05-05 14:21:31','2018-05-05 14:21:34','3a67ac72-aaad-46a9-96ff-21a951883763'),(17,'craft\\elements\\MatrixBlock','2018-05-05 14:33:17','2018-05-09 10:36:46','54cedc0a-554b-4c8f-9177-741b531907fd'),(18,'craft\\elements\\MatrixBlock','2018-05-05 14:51:26','2018-05-05 14:52:41','1bd030a3-2187-4d19-b08f-319c714ce3ae'),(19,'craft\\elements\\GlobalSet','2018-05-05 14:54:42','2018-05-05 14:54:42','71659b6f-ad96-4ea7-adc9-48852560bd6c'),(20,'craft\\elements\\GlobalSet','2018-05-05 14:55:05','2018-05-05 14:55:05','7b4d5025-b806-477c-96ed-857f67f2a93c'),(21,'craft\\elements\\GlobalSet','2018-05-05 14:55:25','2018-05-05 14:55:25','c81d12f1-0d46-4d28-a8a8-f0148b8f9578'),(22,'craft\\elements\\GlobalSet','2018-05-05 14:55:43','2018-05-05 14:55:43','0d120dcf-4215-49e0-b590-5492cb4e6304'),(23,'craft\\elements\\GlobalSet','2018-05-05 14:56:01','2018-05-05 14:56:01','85cac511-5027-4bc0-a0da-18c18c2c1002'),(24,'craft\\elements\\GlobalSet','2018-05-05 14:56:15','2018-05-05 14:56:15','5c6ec872-4eb0-4126-a7a1-e1c435503a6d'),(25,'craft\\elements\\Entry','2018-05-14 14:21:09','2018-05-14 14:28:58','8a5b91fa-2fd9-45bc-9bbc-3852fd3501a1'),(26,'craft\\elements\\Entry','2018-05-14 14:29:53','2018-05-14 14:32:14','cd371e6a-f92a-4923-ab87-a9dd1146d014');
/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouttabs`
--

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayouttabs` VALUES (53,13,'Content',1,'2018-05-05 14:15:55','2018-05-05 14:15:55','3b7d0611-5410-48a4-a3bd-994503e9e2a8'),(58,18,'Content',1,'2018-05-05 14:52:41','2018-05-05 14:52:41','712edfd4-226f-4ae8-97d5-451d9e95fbf5'),(59,7,'Content',1,'2018-05-05 14:53:08','2018-05-05 14:53:08','9fac0ee6-cce7-4868-bc01-23dbb0d4cafe'),(60,8,'Content',1,'2018-05-05 14:53:08','2018-05-05 14:53:08','629d2ff5-3995-4a46-bd08-8dfcc13788b6'),(61,9,'Content',1,'2018-05-05 14:53:08','2018-05-05 14:53:08','4f788610-5185-4f38-a804-f6bbb1e4d1bd'),(62,19,'Content',1,'2018-05-05 14:54:42','2018-05-05 14:54:42','e3242352-5bb4-4e02-a2b1-80faff2f9961'),(63,20,'Content',1,'2018-05-05 14:55:05','2018-05-05 14:55:05','34bc915e-8ebd-4cd8-9458-735204141cdf'),(64,21,'Content',1,'2018-05-05 14:55:25','2018-05-05 14:55:25','86147f2f-e0da-4989-a37f-0683e5b8f401'),(65,22,'Content',1,'2018-05-05 14:55:43','2018-05-05 14:55:43','e0a554c6-ab3b-4104-a0a3-9df41e3fe907'),(66,23,'Content',1,'2018-05-05 14:56:01','2018-05-05 14:56:01','6a587ae0-ae06-45c8-ba21-e0ecdac66d18'),(67,24,'Content',1,'2018-05-05 14:56:15','2018-05-05 14:56:15','8c58f46c-7974-4e1e-bfe3-75ac6084e7f3'),(73,17,'Content',1,'2018-05-09 10:36:46','2018-05-09 10:36:46','3d7b6b64-e9cf-46a4-b663-43f44895b1f3'),(78,1,'Teaser',1,'2018-05-09 12:50:16','2018-05-09 12:50:16','4accbdd3-0057-40bd-90b6-d08e12fd77f4'),(79,1,'Detail',2,'2018-05-09 12:50:16','2018-05-09 12:50:16','f3616b89-38fe-4149-a7c1-78516f5f799a'),(83,25,'Content',1,'2018-05-14 14:28:58','2018-05-14 14:28:58','0a20319b-d28e-424c-b702-cf0b2d6cb63a'),(84,2,'Content',1,'2018-05-14 14:29:04','2018-05-14 14:29:04','e3b108b2-9845-4b67-b803-a251b3c15db5'),(86,26,'Content',1,'2018-05-14 14:32:14','2018-05-14 14:32:14','797ed3b7-2e8a-459d-b4c4-f60e73c3112b');
/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fields` VALUES (3,1,'Body','body','global','','site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"localizeBlocks\":false}','2018-05-02 13:48:37','2018-05-05 14:53:08','e4ec1947-a525-447d-92c2-6d1587524139'),(6,1,'Tags','tags','global','Nur der erste Tag wird im Vorschaubild angezeigt.','site',NULL,'craft\\fields\\Tags','{\"sources\":\"*\",\"source\":\"taggroup:1\",\"targetSiteId\":null,\"viewMode\":null,\"limit\":null,\"selectionLabel\":\"Type\",\"localizeRelations\":false}','2018-05-02 13:55:11','2018-05-05 10:12:21','40a85f37-50a3-46b8-8352-f7ea391d4157'),(8,1,'Image','image','global','','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"1\",\"defaultUploadLocationSource\":\"folder:1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":[\"folder:1\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"\",\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-05-02 13:55:38','2018-05-09 12:14:34','bb8bb8ce-b2af-4cf8-a4f8-6b944b6540ef'),(9,NULL,'Content','textContent','matrixBlockType:1','','none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Standard.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"\",\"availableTransforms\":\"*\"}','2018-05-03 10:26:23','2018-05-05 14:53:08','c740189c-90ba-4f84-8d44-5daf6a05bcae'),(10,NULL,'Quote','quote','matrixBlockType:2','','none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Standard.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"\",\"availableTransforms\":\"*\"}','2018-05-03 10:26:23','2018-05-05 14:53:08','a688cd72-04c9-4c59-8638-8f7c45728464'),(11,NULL,'Citation','citation','matrixBlockType:2','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-05-03 10:26:23','2018-05-05 14:53:08','5e39a4b7-4748-4845-a6e2-513c5e3758d2'),(12,NULL,'Image','image','matrixBlockType:3','','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"1\",\"defaultUploadLocationSource\":\"folder:1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":[\"folder:1\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"1\",\"selectionLabel\":\"Add an image\",\"localizeRelations\":false}','2018-05-03 10:26:23','2018-05-05 14:53:08','14b141d2-3a68-44b7-a7e5-f454bd5994a7'),(13,NULL,'Caption','caption','matrixBlockType:3','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-05-03 10:41:31','2018-05-05 14:53:08','245ba766-4398-4405-909a-f1dd9e29f25e'),(14,NULL,'Layout','layout','matrixBlockType:3','','none',NULL,'rias\\positionfieldtype\\fields\\Position','{\"options\":{\"left\":\"1\",\"center\":\"\",\"right\":\"1\",\"full\":\"1\",\"drop-left\":\"\",\"drop-right\":\"\"},\"default\":\"left\"}','2018-05-03 10:42:07','2018-05-05 14:53:08','ddef10d5-173e-4a6b-9ab3-3335525f59db'),(15,1,'Protagonist','protagonist','global','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-05-05 10:07:09','2018-05-05 10:07:09','1b266131-2d52-4077-8d63-4d876921afaa'),(16,1,'Speaker','speaker','global','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-05-05 10:07:26','2018-05-05 10:07:26','cb26f639-786e-40c0-aae6-7163325c5943'),(17,1,'Director','director','global','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-05-05 10:07:35','2018-05-05 10:07:35','aa18b2a5-dbb0-4fe0-93aa-dd43f2f69948'),(18,1,'Dop','dop','global','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-05-05 10:07:45','2018-05-05 10:07:45','3cb86da1-9010-4e95-8dea-2f1213ea3a4c'),(19,1,'Production','production','global','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-05-05 10:07:53','2018-05-05 10:07:53','1b2dad59-145b-47c0-89bf-21f4b1615754'),(20,1,'Music','music','global','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-05-05 10:08:22','2018-05-05 10:08:22','98d152de-5334-4303-8261-44e374affcca'),(21,1,'Sound Mixing','soundMixing','global','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-05-05 10:08:37','2018-05-05 10:08:37','81e0dcbc-024e-4f60-be90-c30db5728dbd'),(22,1,'Editing','editing','global','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-05-05 10:08:42','2018-05-05 10:08:42','5aa19c20-5a80-4afe-b075-618152f9a9fc'),(24,3,'Contact','globalContact','global','','site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"1\",\"maxBlocks\":\"1\",\"localizeBlocks\":false}','2018-05-05 14:15:55','2018-05-05 14:15:55','0407801d-6589-406a-b952-404e0d45afb3'),(25,NULL,'Company','company','matrixBlockType:4','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-05-05 14:15:55','2018-05-05 14:15:55','e8cde0cd-5e24-4c6a-8150-745056d35e89'),(26,NULL,'Street','street','matrixBlockType:4','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-05-05 14:15:55','2018-05-05 14:15:55','79ffe0ec-b511-4270-b837-43368e4de1bf'),(27,NULL,'Postal Code','postalCode','matrixBlockType:4','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-05-05 14:15:55','2018-05-05 14:15:55','e35af801-4d4d-45c2-af9c-3e246bb445a2'),(28,NULL,'City','city','matrixBlockType:4','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-05-05 14:15:55','2018-05-05 14:15:55','bfab8623-b51b-4322-84ed-97ba3dfc88d5'),(29,NULL,'Country','country','matrixBlockType:4','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-05-05 14:15:55','2018-05-05 14:15:55','82aa3124-663a-4397-8788-a7838f125761'),(30,NULL,'Mail','mail','matrixBlockType:4','','none',NULL,'craft\\fields\\Email','[]','2018-05-05 14:15:55','2018-05-05 14:15:55','ea5b3e03-505b-469c-b4f6-8d54b2e50228'),(31,NULL,'Phone','phone','matrixBlockType:4','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-05-05 14:15:55','2018-05-05 14:15:55','5b94af38-0bab-4f10-8781-868e51cfc5aa'),(32,NULL,'Mobile Phone','mobilePhone','matrixBlockType:4','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-05-05 14:15:55','2018-05-05 14:15:55','a3e15648-5d5b-4a08-87e9-4b1d458c0469'),(33,3,'Google Analytics','googleAnalytics','global','globalGoogleAnalytics','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-05-05 14:16:27','2018-05-05 14:16:27','659b4cf8-9aa7-4de6-9cb7-f6de744d5e6c'),(34,3,'Logo','logo','global','','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"1\",\"defaultUploadLocationSource\":\"folder:1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":[\"folder:1\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"1\",\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-05-05 14:22:51','2018-05-09 08:52:44','2518a794-91b3-46ca-9e7f-30145b383d06'),(35,3,'NavigationMain','globalNavigationMain','global','','site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"localizeBlocks\":false}','2018-05-05 14:33:17','2018-05-09 10:36:46','9f60c63a-d41d-464d-b017-7fd160522e19'),(36,NULL,'Menu Item','menuItem','matrixBlockType:5','','none',NULL,'typedlinkfield\\fields\\LinkField','{\"allowCustomText\":\"1\",\"allowedLinkNames\":[\"url\",\"category\",\"entry\"],\"allowTarget\":\"1\",\"defaultLinkName\":\"url\",\"defaultText\":\"\",\"typeSettings\":{\"url\":{\"disableValidation\":\"1\"},\"email\":{\"disableValidation\":\"\"},\"tel\":{\"disableValidation\":\"\"},\"asset\":{\"sources\":\"*\"},\"category\":{\"sources\":\"*\"},\"entry\":{\"sources\":\"*\"},\"globalset\":{\"sources\":\"*\"}}}','2018-05-05 14:33:17','2018-05-09 10:36:46','05024d07-504c-4c29-9697-4e9b461b9067'),(37,NULL,'Is Active','isActive','matrixBlockType:5','','none',NULL,'craft\\fields\\Lightswitch','{\"default\":\"\"}','2018-05-05 14:47:46','2018-05-09 10:36:46','504cbccf-3005-4cc3-8d88-315c041490f3'),(38,NULL,'Highlight Triggers','highlightTriggers','matrixBlockType:5','Do not edit!','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-05-05 14:47:46','2018-05-09 10:36:46','d1958f93-1586-444e-8190-1b864041baa4'),(39,3,'Social Networks','globalSocialNetworks','global','','none',NULL,'craft\\fields\\Table','{\"addRowLabel\":\"Add a row\",\"maxRows\":\"\",\"minRows\":\"\",\"columns\":{\"col1\":{\"heading\":\"Network\",\"handle\":\"network\",\"width\":\"\",\"type\":\"singleline\"},\"col2\":{\"heading\":\"Alias\",\"handle\":\"alias\",\"width\":\"\",\"type\":\"singleline\"},\"col3\":{\"heading\":\"Url\",\"handle\":\"url\",\"width\":\"\",\"type\":\"singleline\"}},\"defaults\":{\"row1\":{\"col1\":\"\",\"col2\":\"\",\"col3\":\"\"}},\"columnType\":\"text\"}','2018-05-05 14:48:57','2018-05-05 14:48:57','8592a4e0-b651-4080-b81a-f5e10b7f5ff1'),(40,3,'Watermark','globalWatermark','global','','site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"localizeBlocks\":false}','2018-05-05 14:51:26','2018-05-05 14:52:41','f9b5b11d-0a27-420e-81a2-0d2252de9a8d'),(41,NULL,'Use Watermark','useWatermark','matrixBlockType:6','','none',NULL,'craft\\fields\\Lightswitch','{\"default\":\"\"}','2018-05-05 14:51:26','2018-05-05 14:52:41','10eab488-dcb8-4bac-bc6b-99d863e07600'),(42,NULL,'Image','image','matrixBlockType:6','','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"1\",\"defaultUploadLocationSource\":\"folder:1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":[\"folder:1\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-05-05 14:51:26','2018-05-05 14:52:41','5487b7ce-fd50-4c91-b65c-23a1b9717eaa'),(43,NULL,'Width','width','matrixBlockType:6','','none',NULL,'craft\\fields\\Number','{\"min\":null,\"max\":null,\"decimals\":\"0\",\"size\":null}','2018-05-05 14:52:41','2018-05-05 14:52:41','f5718b58-0e01-407f-b44f-7095c1d14c72'),(44,NULL,'Height','height','matrixBlockType:6','','none',NULL,'craft\\fields\\Number','{\"min\":null,\"max\":null,\"decimals\":\"0\",\"size\":null}','2018-05-05 14:52:41','2018-05-05 14:52:41','7c04d331-4f18-4a05-8f48-fb0a66e7585e'),(45,NULL,'Opacity','opacity','matrixBlockType:6','','none',NULL,'craft\\fields\\Number','{\"min\":null,\"max\":\"1\",\"decimals\":\"1\",\"size\":null}','2018-05-05 14:52:41','2018-05-05 14:52:41','b7b3a420-5cf4-4673-b90b-4c76c593ad1f'),(46,NULL,'Offset X-Axis','offsetXAxis','matrixBlockType:6','','none',NULL,'craft\\fields\\Number','{\"min\":null,\"max\":null,\"decimals\":\"0\",\"size\":null}','2018-05-05 14:52:41','2018-05-05 14:52:41','b062a085-36d1-403c-81e7-5a8b25a1fc0e'),(47,NULL,'Offset Y-Axis','offsetYAxis','matrixBlockType:6','','none',NULL,'craft\\fields\\Number','{\"min\":null,\"max\":null,\"decimals\":\"0\",\"size\":null}','2018-05-05 14:52:41','2018-05-05 14:52:41','a954759e-94e6-435a-8140-321cbe7d2b10'),(48,NULL,'Segment Position','segmentPosition','matrixBlockType:5','','none',NULL,'craft\\fields\\Number','{\"min\":null,\"max\":null,\"decimals\":\"0\",\"size\":null}','2018-05-09 09:39:51','2018-05-09 10:36:46','3003f6f2-4f5f-4e0c-9a38-09f81fc5b227'),(49,1,'Media','media','global','','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"1\",\"defaultUploadLocationSource\":\"folder:1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:6\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"audio\",\"json\",\"video\"],\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"\",\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-05-09 12:17:02','2018-05-09 12:17:02','c5ea66cf-e95a-40f6-b4ad-45644c47a362');
/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `globalsets`
--

LOCK TABLES `globalsets` WRITE;
/*!40000 ALTER TABLE `globalsets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `globalsets` VALUES (58,'Contact	','contact',19,'2018-05-05 14:54:42','2018-05-05 14:54:42','b5c05145-ac72-4fab-99ec-05786397b780'),(59,'Google Analytics','googleAnalytics',20,'2018-05-05 14:55:05','2018-05-05 14:55:05','60971176-4b0a-4dc9-ae3d-889859cf1b0b'),(60,'Logo','logo',21,'2018-05-05 14:55:25','2018-05-05 14:55:25','337999c3-8251-40e3-9fbe-bf9f81d38710'),(61,'Navigation Main','navigationMain',22,'2018-05-05 14:55:43','2018-05-05 14:55:43','b554ae24-db87-49cd-b611-1563723ea517'),(62,'Social Networks','socialNetworks',23,'2018-05-05 14:56:01','2018-05-05 14:56:01','b85ce42b-6c9d-4784-ae35-a59f46e55bb9'),(63,'Watermark','watermark',24,'2018-05-05 14:56:15','2018-05-05 14:56:15','b8547895-e225-45dc-9d42-2649ee9f7d78');
/*!40000 ALTER TABLE `globalsets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `info`
--

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `info` VALUES (1,'3.0.5','3.0.91',0,'America/Los_Angeles','drissy',1,0,'aZMc9dvsgPtb','2018-04-30 15:34:51','2018-05-09 14:29:26','6baa0fb6-048b-4a5d-b7d4-53f05075bcb2');
/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocks`
--

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixblocks` VALUES (4,2,NULL,3,1,1,'2018-05-03 10:56:50','2018-05-17 13:01:45','109e6c67-bb45-4f15-8e2a-aeca571f4a4d'),(64,61,NULL,35,5,1,'2018-05-05 14:59:34','2018-05-17 13:03:01','4f749242-824d-4101-8c43-eb92c7a731a4'),(67,61,NULL,35,5,2,'2018-05-05 14:59:34','2018-05-17 13:03:01','c16a53f8-2509-486e-a2a2-bc61a12fae10'),(68,58,NULL,24,4,1,'2018-05-05 15:14:21','2018-05-17 13:02:28','b958d256-6898-4f8f-b9c2-490bdc8c3ba0'),(92,91,NULL,3,1,1,'2018-05-14 14:31:07','2018-05-17 13:01:58','a749ff1f-c18c-470b-a706-c9e6a52a04be'),(93,90,NULL,3,1,1,'2018-05-14 14:31:38','2018-05-17 13:01:31','5ef6a7d2-ccc1-4479-9f53-b458dfe93bdc');
/*!40000 ALTER TABLE `matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocktypes`
--

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixblocktypes` VALUES (1,3,7,'Text','text',1,'2018-05-03 10:26:23','2018-05-05 14:53:08','77493733-522d-4955-8337-67030cb1b2a2'),(2,3,8,'Blockquote','blockquote',2,'2018-05-03 10:26:23','2018-05-05 14:53:08','62694c48-74bc-4014-bb76-0a474284859a'),(3,3,9,'Image','image',3,'2018-05-03 10:26:23','2018-05-05 14:53:08','130a8fc7-6a24-4b6e-a772-c97760ce20b8'),(4,24,13,'Contact','contact',1,'2018-05-05 14:15:55','2018-05-05 14:15:55','b1236d9c-9004-48dd-a586-d69c689727d7'),(5,35,17,'Menu Item','menuItem',1,'2018-05-05 14:33:17','2018-05-09 10:36:46','7e11aa39-136f-459e-9072-d214c0f8db04'),(6,40,18,'Watermark','watermark',1,'2018-05-05 14:51:26','2018-05-05 14:52:41','def6bad5-adc7-4a26-be2d-06d718a72fbf');
/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixcontent_body`
--

LOCK TABLES `matrixcontent_body` WRITE;
/*!40000 ALTER TABLE `matrixcontent_body` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixcontent_body` VALUES (1,4,1,'2018-05-03 10:56:50','2018-05-17 13:01:45','62bc4d0e-359d-4155-8be7-d4ba1f9ac97c','<p><br /></p>\n',NULL,NULL,NULL,NULL),(13,49,1,'2018-05-04 18:38:52','2018-05-04 18:38:52','139a62f5-711a-47a9-a699-ebd8aa5c1818','<p>Hi</p>\n',NULL,NULL,NULL,NULL),(14,50,1,'2018-05-04 18:39:00','2018-05-04 18:39:00','00459a5f-6cde-42da-958f-64ff97a44eba','<p>Hi</p>\n',NULL,NULL,NULL,NULL),(15,51,1,'2018-05-04 18:39:08','2018-05-04 18:39:08','5197e6e1-fa25-4152-9115-a04e161fa61c','<p>Hi</p>\n',NULL,NULL,NULL,NULL),(16,52,1,'2018-05-04 18:39:16','2018-05-04 18:39:16','e6cd0a32-047e-407c-9de4-a96bc734d682','<p>Hi</p>\n',NULL,NULL,NULL,NULL),(17,53,1,'2018-05-04 18:39:23','2018-05-04 18:39:23','b9a385ed-d9e4-4490-b859-ff78bc302e94','<p>Hi</p>\n',NULL,NULL,NULL,NULL),(18,54,1,'2018-05-04 18:39:30','2018-05-04 18:39:30','18c96ff8-32ef-40e2-90f3-2ed921e3a4a2','<p>Hi</p>\n',NULL,NULL,NULL,NULL),(19,92,1,'2018-05-14 14:31:07','2018-05-17 13:01:58','f066ed78-2719-48f3-a8f9-2284e02cb5f1','<p><br /></p>\n',NULL,NULL,NULL,NULL),(20,93,1,'2018-05-14 14:31:38','2018-05-17 13:01:31','37129a53-3d21-40c2-a9aa-fdc2d8de0585','<p><br /></p><br />\n',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `matrixcontent_body` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixcontent_globalcontact`
--

LOCK TABLES `matrixcontent_globalcontact` WRITE;
/*!40000 ALTER TABLE `matrixcontent_globalcontact` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixcontent_globalcontact` VALUES (1,68,1,'2018-05-05 15:14:21','2018-05-17 13:02:28','ff03fb2d-4716-4405-b98b-4ad524ffe916','WeWereYoung','Pinnasberg','20359','Hamburg','Germany','hi@wewereyoung.com',NULL,NULL);
/*!40000 ALTER TABLE `matrixcontent_globalcontact` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixcontent_globalnavigationmain`
--

LOCK TABLES `matrixcontent_globalnavigationmain` WRITE;
/*!40000 ALTER TABLE `matrixcontent_globalnavigationmain` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixcontent_globalnavigationmain` VALUES (1,64,1,'2018-05-05 14:59:34','2018-05-17 13:03:01','b387d3e9-42d0-4ba4-ad93-e02e130e04e9','{\"allowCustomText\":\"1\",\"allowTarget\":\"1\",\"customText\":\"Home\",\"defaultText\":\"\",\"target\":\"\",\"type\":\"entry\",\"value\":\"2\"}',1,'home',1),(4,67,1,'2018-05-05 14:59:34','2018-05-17 13:03:01','c40f2f73-6d18-4abb-baa9-b305ab818fab','{\"allowCustomText\":\"1\",\"allowTarget\":\"1\",\"customText\":\"Contact\",\"defaultText\":\"\",\"target\":\"\",\"type\":\"url\",\"value\":\"mailto:hi@wewereyoung.de\"}',1,NULL,NULL);
/*!40000 ALTER TABLE `matrixcontent_globalnavigationmain` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixcontent_globalwatermark`
--

LOCK TABLES `matrixcontent_globalwatermark` WRITE;
/*!40000 ALTER TABLE `matrixcontent_globalwatermark` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixcontent_globalwatermark` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `migrations` VALUES (1,NULL,'app','Install','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','88c73732-c5aa-431a-807e-31390401587f'),(2,NULL,'app','m150403_183908_migrations_table_changes','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','b312441d-959e-4d37-a3e7-73b79df75466'),(3,NULL,'app','m150403_184247_plugins_table_changes','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','7a975de1-5288-42f5-a951-c7c477a7904d'),(4,NULL,'app','m150403_184533_field_version','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','67caa19d-5922-4c61-931f-f5502f75aa42'),(5,NULL,'app','m150403_184729_type_columns','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','9b96a79f-d1e3-42f1-9851-09c9bda1df60'),(6,NULL,'app','m150403_185142_volumes','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','1193541f-88e9-4c92-998a-c0c8dbf77821'),(7,NULL,'app','m150428_231346_userpreferences','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','c9e0ccdd-e952-4359-a611-138b1b9f4e93'),(8,NULL,'app','m150519_150900_fieldversion_conversion','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','143a9edd-fbf7-4364-89d6-c2718226a28b'),(9,NULL,'app','m150617_213829_update_email_settings','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','1f6660bb-ce96-4a22-9b05-dd0863a76745'),(10,NULL,'app','m150721_124739_templatecachequeries','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','8bfd0652-9f5c-4ddf-85f6-c4867a92b18b'),(11,NULL,'app','m150724_140822_adjust_quality_settings','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','e17fd6de-b48a-4913-bfbe-260a262925b3'),(12,NULL,'app','m150815_133521_last_login_attempt_ip','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','5f4eb9c8-4d10-464a-a12b-32ecc3037fd8'),(13,NULL,'app','m151002_095935_volume_cache_settings','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','031bb1df-e845-42a2-a8db-c1e43c70b68b'),(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','6a2c1045-6b85-4b4c-ad5a-5da4c741e338'),(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','af68fb82-cc22-49a4-b280-e977fa76a26f'),(16,NULL,'app','m151209_000000_move_logo','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','0cddcc0b-7ee6-4e09-b539-388905844bbf'),(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','fdbb37f7-4ace-45b8-8115-d1b7c4799f51'),(18,NULL,'app','m151215_000000_rename_asset_permissions','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','6d6ec9f8-a910-451d-ae62-2abdaddc3c3c'),(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','655027ce-4ab7-4d13-9e5e-5093ac8921e8'),(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','eedbc268-cade-4232-b7a7-e0e72e7a19b6'),(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','4e837f13-91e5-4e32-bbf5-f0783c3773ef'),(22,NULL,'app','m160727_194637_column_cleanup','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','66e6f5dc-c5d7-45de-b335-c89da305dc8a'),(23,NULL,'app','m160804_110002_userphotos_to_assets','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','ac25ffec-3a38-4ab4-a2fe-87575d5c1719'),(24,NULL,'app','m160807_144858_sites','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','baac82f5-227f-48f0-a5b2-a1d8e30247ce'),(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','10ac47c0-2600-4357-97c7-2ad8be43153f'),(26,NULL,'app','m160830_000000_asset_index_uri_increase','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','b431f182-d481-40f9-a149-2463d4c6ea1c'),(27,NULL,'app','m160912_230520_require_entry_type_id','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','73c042b5-dff2-488e-b6cd-6c66790d7d60'),(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','bd91c737-c429-4bd1-82a1-5386067a0788'),(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','93844ec8-fd7a-4b21-b2ad-41f92a8152a8'),(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','f5099940-2c28-4f0b-8d11-1fadb205dbfc'),(31,NULL,'app','m160925_113941_route_uri_parts','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','267475b9-9b25-4810-8e27-55e29728dece'),(32,NULL,'app','m161006_205918_schemaVersion_not_null','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','dcc4006d-129a-496e-b7b5-f6adc9d28534'),(33,NULL,'app','m161007_130653_update_email_settings','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','f38d0d31-1f33-437d-a04b-82766cc7be61'),(34,NULL,'app','m161013_175052_newParentId','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','73c1dd65-6060-400f-aa46-2ed91ef99e8e'),(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','aab73c9e-3fbb-4ead-ba1d-56395a71cc3d'),(36,NULL,'app','m161021_182140_rename_get_help_widget','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','289b59af-23a2-4a49-9d5d-e1ba9ac6205f'),(37,NULL,'app','m161025_000000_fix_char_columns','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','25042498-6a98-4b1b-944c-5ad5079119f7'),(38,NULL,'app','m161029_124145_email_message_languages','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','9b423f83-24ec-48aa-a5d6-327b9f63a393'),(39,NULL,'app','m161108_000000_new_version_format','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','8d00132e-1834-4e1e-9fce-eb29d7bd56be'),(40,NULL,'app','m161109_000000_index_shuffle','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','035c5884-035e-43d4-98df-eec2438513c3'),(41,NULL,'app','m161122_185500_no_craft_app','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','a86fc0ab-c50b-42d9-a572-eefa8c2b347c'),(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','acc3bbf8-f3c6-4c6b-a33e-61b4f8dae938'),(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','f6ed4032-b5a8-4844-8e33-14a54546f4dc'),(44,NULL,'app','m170114_161144_udates_permission','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','a5094bfc-645e-47d2-9838-9bdef45efae8'),(45,NULL,'app','m170120_000000_schema_cleanup','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','b4eafdba-b03d-43d0-966a-0dc9db830b9b'),(46,NULL,'app','m170126_000000_assets_focal_point','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','7321567b-085a-4a73-a890-fc4be735e517'),(47,NULL,'app','m170206_142126_system_name','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','d0ea6f99-5870-44ea-a374-2530c33eccb5'),(48,NULL,'app','m170217_044740_category_branch_limits','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','44117d86-97c6-4a69-9428-5c1357cfed36'),(49,NULL,'app','m170217_120224_asset_indexing_columns','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','5b50fbb3-4a92-428d-aa48-185600bd7e0b'),(50,NULL,'app','m170223_224012_plain_text_settings','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','d4ef892a-f95a-4bf8-a162-69e84f465c17'),(51,NULL,'app','m170227_120814_focal_point_percentage','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','ead3a5ca-910b-410e-8244-8cf0566c816f'),(52,NULL,'app','m170228_171113_system_messages','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','2beda057-947a-4cee-aa52-eab3eac95ab0'),(53,NULL,'app','m170303_140500_asset_field_source_settings','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','3059c0f2-d59b-4008-ae11-de00496fcf5b'),(54,NULL,'app','m170306_150500_asset_temporary_uploads','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','33e2cc50-da61-4c1d-8c72-39cb8f2d22a3'),(55,NULL,'app','m170414_162429_rich_text_config_setting','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','65f17743-5dab-47db-8aa3-36fcf78674e6'),(56,NULL,'app','m170523_190652_element_field_layout_ids','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','d8d92c66-2253-4540-ba75-60fc3127b323'),(57,NULL,'app','m170612_000000_route_index_shuffle','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','5af16ac0-ea07-44fb-a2e9-98d978ea1f67'),(58,NULL,'app','m170621_195237_format_plugin_handles','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','ed98b867-de0f-481a-9694-bdaab6524f4e'),(59,NULL,'app','m170630_161028_deprecation_changes','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','421adedc-01c1-4a8a-b3f5-8f19fffcff1d'),(60,NULL,'app','m170703_181539_plugins_table_tweaks','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','8981947a-4bbe-44ed-9778-87759af5778e'),(61,NULL,'app','m170704_134916_sites_tables','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','3dcbe145-4291-46f6-a538-f8c727bd7fd3'),(62,NULL,'app','m170706_183216_rename_sequences','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','f61ace8d-ef82-4f1e-a3d0-fa4a347068df'),(63,NULL,'app','m170707_094758_delete_compiled_traits','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','745de11a-e0d7-4bee-a5b2-0c39e282f94f'),(64,NULL,'app','m170731_190138_drop_asset_packagist','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','6fa95c55-173c-45bb-92c6-e7e10064be72'),(65,NULL,'app','m170810_201318_create_queue_table','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','5298a03b-b4b4-45f0-b6a6-0f7cc90be93a'),(66,NULL,'app','m170816_133741_delete_compiled_behaviors','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','8d02bda8-b64b-40fb-856d-c85ac85bca9a'),(67,NULL,'app','m170821_180624_deprecation_line_nullable','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','67404e85-0a4e-451f-a1ca-faff29bc8baf'),(68,NULL,'app','m170903_192801_longblob_for_queue_jobs','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','e2e4e4fe-91de-4608-8bb8-d23d34e8d172'),(69,NULL,'app','m170914_204621_asset_cache_shuffle','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','ada59ad3-a8c1-4ece-9a38-61176e5db8d2'),(70,NULL,'app','m171011_214115_site_groups','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','83d1ef32-f59b-44fa-a920-961e66ffca8c'),(71,NULL,'app','m171012_151440_primary_site','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','b10672a9-18ca-4d55-bfe1-2d1e8ae96bbb'),(72,NULL,'app','m171013_142500_transform_interlace','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','b9196724-eacd-4aeb-ac55-3a7ae765e52e'),(73,NULL,'app','m171016_092553_drop_position_select','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','f99e6777-a5e9-49e1-b068-d98bed3c18c8'),(74,NULL,'app','m171016_221244_less_strict_translation_method','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','13f00557-25ed-40c1-b955-8c2c2b698bcf'),(75,NULL,'app','m171107_000000_assign_group_permissions','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','b1b1b85a-104a-4349-9381-c5219ac936db'),(76,NULL,'app','m171117_000001_templatecache_index_tune','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','30bc5e2b-c99a-45d8-b006-8d7bc78be178'),(77,NULL,'app','m171126_105927_disabled_plugins','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','226b2988-359d-4554-9c35-a6e4b8adf342'),(78,NULL,'app','m171130_214407_craftidtokens_table','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','8f566d3f-8a88-4617-86e9-3dad89bee2be'),(79,NULL,'app','m171202_004225_update_email_settings','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','fb0fa1de-d149-4f43-8a07-20b25b6a5dff'),(80,NULL,'app','m171204_000001_templatecache_index_tune_deux','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','25bbfdd8-7bca-4d01-8d2f-849d7602e438'),(81,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','69cff4f6-b5f3-4d5a-bbf4-d0a19e5597bd'),(82,NULL,'app','m171218_143135_longtext_query_column','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','f6555cb4-28c1-47bf-8e70-b13ac906c4f0'),(83,NULL,'app','m171231_055546_environment_variables_to_aliases','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','278bc06a-34e5-495a-89e3-f9a132c4b940'),(84,NULL,'app','m180113_153740_drop_users_archived_column','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','8d47db4a-a4bb-483d-82d3-f5213d12438b'),(85,NULL,'app','m180122_213433_propagate_entries_setting','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','b74881da-0345-41ba-92b8-1a67fc439ca4'),(86,NULL,'app','m180124_230459_fix_propagate_entries_values','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','12960f32-9d07-487d-90b3-3d8722326178'),(87,NULL,'app','m180128_235202_set_tag_slugs','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','635f6a79-f693-47f1-9189-0f68415ea6a4'),(88,NULL,'app','m180202_185551_fix_focal_points','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','bbbe179b-7cba-4250-8e0d-4e8e04ac4d53'),(89,NULL,'app','m180217_172123_tiny_ints','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','2a3f26e5-cc61-4d47-a901-b99d94482482'),(90,NULL,'app','m180321_233505_small_ints','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','a16b177c-716e-4df4-a94a-8ac2d372f599'),(91,NULL,'app','m180328_115523_new_license_key_statuses','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','ee91e766-c80c-421a-9e99-151725efbd31'),(92,NULL,'app','m180404_182320_edition_changes','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','592c09ac-f199-40f4-9775-de2e8154fe3c'),(93,NULL,'app','m180411_102218_fix_db_routes','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','2470b266-e1b3-4470-a2f6-c77cc798e512'),(94,NULL,'app','m180416_205628_resourcepaths_table','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','b2e64934-a8f5-49e0-805d-394da1863393'),(95,NULL,'app','m180418_205713_widget_cleanup','2018-05-01 14:49:08','2018-05-01 14:49:08','2018-05-01 14:49:08','10389c11-50a4-4c9a-b889-361c0d5f1b6c'),(98,10,'plugin','Install','2018-05-03 10:42:46','2018-05-03 10:42:46','2018-05-03 10:42:46','503353a9-0ec1-4e76-9aaa-267b56df2deb'),(99,10,'plugin','m180430_204710_remove_old_plugins','2018-05-03 10:42:46','2018-05-03 10:42:46','2018-05-03 10:42:46','ab646041-26bc-4b4e-be2b-db5e43655e9b');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `plugins` VALUES (1,'async-queue','1.3.2','1.0.0',NULL,'unknown',1,NULL,'2018-04-30 15:35:06','2018-04-30 15:35:06','2018-05-17 13:03:13','e30c6c07-3147-495e-9367-3de8c92b3002'),(2,'eager-beaver','1.0.3','1.0.0',NULL,'unknown',1,NULL,'2018-04-30 15:35:06','2018-04-30 15:35:06','2018-05-17 13:03:13','8028d773-e11f-4e94-8656-be82a3df5bfc'),(3,'minify','1.2.8','1.0.0',NULL,'unknown',1,NULL,'2018-04-30 15:35:06','2018-04-30 15:35:06','2018-05-17 13:03:13','f9e6538a-edb7-4a85-b5cf-a081b087f4ca'),(4,'typogrify','1.1.10','1.0.0',NULL,'unknown',1,NULL,'2018-04-30 15:35:07','2018-04-30 15:35:07','2018-05-17 13:03:13','70084d24-0b8f-46dd-b101-307200d8da1e'),(5,'cookies','1.1.9','1.0.0',NULL,'unknown',1,NULL,'2018-04-30 15:35:07','2018-04-30 15:35:07','2018-05-17 13:03:13','2bb193ef-648e-4563-bdb0-8ee54aaf4c85'),(7,'fractal','1.0.8','1.0.0',NULL,'unknown',0,NULL,'2018-04-30 15:36:27','2018-04-30 15:36:27','2018-04-30 16:06:21','4a949450-2eec-4a63-bcac-607aa26d26b1'),(9,'position-fieldtype','1.0.11','1.0.0',NULL,'unknown',1,NULL,'2018-05-03 10:40:28','2018-05-03 10:40:28','2018-05-17 13:03:13','67a91e2d-bbdd-49cf-a522-395f86078be7'),(10,'redactor','2.0.0.1','2.0.0',NULL,'unknown',1,NULL,'2018-05-03 10:42:46','2018-05-03 10:42:46','2018-05-17 13:03:13','d0e2be1d-d73b-4454-8c38-4fa0158a2f61'),(12,'environment-label','3.1.3','1.0.0',NULL,'unknown',1,NULL,'2018-05-05 14:37:51','2018-05-05 14:37:51','2018-05-17 13:03:13','0122a55f-3d22-4a1f-a9a6-cb4dca1c44df'),(13,'cp-field-inspect','1.0.4','1.0.0',NULL,'unknown',1,NULL,'2018-05-05 14:38:02','2018-05-05 14:38:02','2018-05-17 13:03:13','34fd1804-bcf3-4df7-9da1-b652cedb296d'),(14,'expanded-singles','1.0.3','1.0.0',NULL,'unknown',1,NULL,'2018-05-05 14:38:09','2018-05-05 14:38:09','2018-05-17 13:03:13','5850206e-230a-479f-8dc1-10df72266713'),(15,'logs','3.0.0','3.0.0',NULL,'unknown',1,NULL,'2018-05-05 14:42:14','2018-05-05 14:42:14','2018-05-17 13:03:13','f12f05fe-0d23-4836-a6b4-f97c554702d7'),(16,'typedlinkfield','1.0.8','1.0.0',NULL,'unknown',1,NULL,'2018-05-05 14:45:04','2018-05-05 14:45:04','2018-05-17 13:03:13','1dccbaf7-96d5-4e19-96b7-e9186b85bcc5'),(18,'cp-css','2.1.0','2.0.0',NULL,'unknown',1,'{\"cssFile\":\"\",\"additionalCss\":\"/* [id$=fields-highlightTriggers-field] {\\r\\n    display: none;\\r\\n} */\"}','2018-05-05 15:05:04','2018-05-05 15:05:04','2018-05-17 13:03:13','8e1c58e8-db4a-4800-963d-1c934b0458c0'),(19,'craft-gonzo','dev-master','0.0.1',NULL,'unknown',1,NULL,'2018-05-06 13:22:45','2018-05-06 13:22:45','2018-05-17 13:03:13','184ee240-ce31-49ec-a49e-c60ebd802b39'),(20,'imager','v2.0.0','2.0.0',NULL,'unknown',1,NULL,'2018-05-08 12:39:28','2018-05-08 12:39:28','2018-05-17 13:03:13','e05cc6ce-2007-4105-a35c-ffc3f31a4290'),(21,'embeddedassets','1.0.2','1.0.0',NULL,'unknown',1,NULL,'2018-05-09 12:13:51','2018-05-09 12:13:51','2018-05-17 13:03:13','29da1330-a741-4098-90d0-050c87e62a11'),(22,'splash','3.0.2','3.0.0',NULL,'unknown',1,'{\"volume\":\"1\",\"authorField\":\"\",\"authorUrlField\":\"\",\"colorField\":\"\"}','2018-05-09 13:38:37','2018-05-09 13:38:37','2018-05-17 13:03:13','d5d895cd-0ec8-4217-95ec-0cceb92faa67');
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `queue`
--

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `relations`
--

LOCK TABLES `relations` WRITE;
/*!40000 ALTER TABLE `relations` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `relations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `resourcepaths`
--

LOCK TABLES `resourcepaths` WRITE;
/*!40000 ALTER TABLE `resourcepaths` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `resourcepaths` VALUES ('10431919','@app/web/assets/updates/dist'),('10656309','@craft/web/assets/pluginstore/dist'),('1141cf65','@runtime/assets/thumbs/16'),('11bab243','@craft/web/assets/feed/dist'),('11cd811c','@runtime/assets/thumbs/38'),('12a0f80d','@lib/jquery-ui'),('12e05ef7','@craft/web/assets/cp/dist'),('14cf7bbe','@lib/selectize'),('155d32b7','@lib/xregexp'),('1760deca','@runtime/assets/thumbs/41'),('17c138dd','@runtime/assets/thumbs/13'),('191e5374','@craft/web/assets/cp/dist'),('198a5993','@lib/garnishjs'),('1a98c5e5','@runtime/assets/thumbs/39'),('1c359a33','@runtime/assets/thumbs/40'),('1e18390f','@runtime/assets/thumbs/20'),('1ea33f34','@lib/xregexp'),('1f31763d','@lib/selectize'),('203a365c','@app/web/assets/matrix/dist'),('2108382d','@runtime/assets/thumbs/35'),('210ce331','@runtime/assets/thumbs/6'),('215c6741','@lib/timepicker'),('216ce8df','@runtime/assets/thumbs/11'),('218252e5','@mmikkel/cpfieldinspect/resources'),('21b0580f','@lib/prismjs'),('21e615c7','@runtime/assets/thumbs/42'),('22a8ae86','@app/web/assets/plugins/dist'),('23365286','@lib/jquery-touch-events'),('241bf635','@craft/web/assets/tablesettings/dist'),('2438a80b','@craft/web/assets/dbbackup/dist'),('24926e44','@lib/picturefill'),('24ea8a3a','@craft/web/assets/matrix/dist'),('24fa2255','@runtime/assets/thumbs/37'),('26a938ca','@craft/web/assets/login/dist'),('290d5e32','@app/web/assets/cp/dist'),('2956a305','@app/web/assets/plugins/dist'),('2a3388fe','@runtime/assets/thumbs/42'),('2a374e15','@lib/d3'),('2c315e43','@craft/web/assets/utilities/dist'),('2eaf8f07','@craft/web/assets/craftsupport/dist'),('2f181468','@app/web/assets/editentry/dist'),('2f84c3f3','@runtime/assets/thumbs/20'),('301a51c3','@vendor/craftcms/redactor/lib/redactor-plugins/fullscreen'),('30f6594b','@app/web/assets/dbbackup/dist'),('32e9cc60','@craft/web/assets/sites/dist'),('3393ab76','@runtime/assets/thumbs/37'),('3624c508','@craft/web/assets/recententries/dist'),('3973bfe6','@app/web/assets/sites/dist'),('3c7a6fba','@lib/fileupload'),('3d68c910','@runtime/assets/thumbs/37'),('3ddac88b','@craft/web/assets/recententries/dist'),('3fe78357','@craft/web/assets/updater/dist'),('402ecc40','@lib/jquery.payment'),('4038ce4b','@craft/web/assets/tablesettings/dist'),('40b1563a','@lib/picturefill'),('44190e22','@app/web/assets/matrix/dist'),('457f5f3f','@lib/timepicker'),('45936071','@lib/prismjs'),('45ea7be8','@lib/d3'),('47156af8','@lib/jquery-touch-events'),('485f5688','@craft/web/assets/editentry/dist'),('49eb4e3d','@runtime/assets/thumbs/36'),('4ae132b0','@runtime/assets/thumbs/14'),('4b3b2c16','@app/web/assets/editentry/dist'),('4b4f5bb9','@lib/picturefill'),('4ceb677b','@lib/jquery-touch-events'),('4d0fe2','@runtime/assets/thumbs/89'),('4d759b7b','@app/web/assets/plugins/dist'),('4d8694d5','@bower/jquery/dist'),('4e14766b','@lib/d3'),('4ed5b0e2','@runtime/assets/thumbs/11'),('4f5112ec','@runtime/assets/thumbs/35'),('5207fd76','@craft/web/assets/recententries/dist'),('52421f7e','@runtime/assets/thumbs/3'),('53a75a47','@lib/fileupload'),('585957c4','@lib/fileupload'),('5984d5d4','@runtime/assets/thumbs/36'),('5b6975dc','@runtime/assets/thumbs/3'),('5bc4bb29','@craft/web/assets/updater/dist'),('5c0963a8','@lib/velocity'),('5c2e37d6','@app/web/assets/clearcaches/dist'),('5c6e5f79','@runtime/assets/thumbs/6'),('5cc867a','@runtime/assets/thumbs/15'),('6063e395','@app/web/assets/dashboard/dist'),('62163f20','@lib/element-resize-detector'),('6311b850','@lib/fabric'),('6440ffae','@runtime/assets/thumbs/6'),('6592eb43','@craft/web/assets/generalsettings/dist'),('682a7c3e','@craft/web/assets/fields/dist'),('682e46ae','@runtime/assets/thumbs/3'),('686f0299','@mmikkel/cpfieldinspect/resources'),('68efb5d3','@lib/fabric'),('68f99488','@craft/web/assets/dashboard/dist'),('692d121','@lib/datepicker-i18n'),('694fe4dc','@lib/datepicker-i18n'),('6a01fc13','@app/web/assets/deprecationerrors/dist'),('6ad12567','@vendor/yiisoft/yii2/assets'),('6b9dee16','@app/web/assets/dashboard/dist'),('6cbdbf18','@craft/web/assets/updateswidget/dist'),('6cfac058','@app/web/assets/fields/dist'),('6efeae8a','@runtime/assets/thumbs/12'),('70ec43c0','@lib/selectize'),('727694ae','@rias/positionfieldtype/assetbundles/positionfieldtype/dist'),('738cc20e','@runtime/assets/thumbs/40'),('74fab25','@vendor/craftcms/redactor/lib/redactor-plugins/video'),('75ac552d','@lib'),('76576c6e','@lib/garnishjs'),('76c36689','@craft/web/assets/cp/dist'),('7732bd44','@runtime/assets/thumbs/16'),('7998121c','@runtime/assets/thumbs/13'),('7a80074a','@lib/xregexp'),('7da961ed','@lib/garnishjs'),('7fb856f4','@craft/web/assets/pluginstore/dist'),('80227c1e','@runtime/assets/thumbs/35'),('8099c83a','@app/web/assets/updateswidget/dist'),('846287f5','@app/web/assets/matrixsettings/dist'),('856e65c2','@runtime/assets/thumbs/11'),('85b79188','@runtime/assets/thumbs/40'),('85f56978','@app/web/assets/craftsupport/dist'),('867dba57','@craft/web/assets/plugins/dist'),('87a8f936','@lib/element-resize-detector'),('8903790e','@craft/web/assets/updateswidget/dist'),('89e8766','@craft/web/assets/updateswidget/dist'),('8d47529e','@craft/web/assets/dashboard/dist'),('8d83b7d4','@craft/web/assets/plugins/dist'),('8d9f826','@app/web/assets/fields/dist'),('8dcaecb3','@vendor/craftcms/redactor/lib/redactor'),('8e0b64fb','@app/web/assets/craftsupport/dist'),('8f23985a','@runtime/assets/thumbs/12'),('9012933b','@lib'),('901472c9','@runtime/assets/thumbs/6'),('90274c2b','@craft/web/assets/feed/dist'),('918baf3d','@typedlinkfield/resources'),('928db1f2','@craft/web/assets/matrixsettings/dist'),('933d0665','@lib/jquery-ui'),('937da09f','@craft/web/assets/cp/dist'),('9420f09b','@runtime/assets/thumbs/3'),('955285d6','@lib/selectize'),('95d80a61','@runtime/assets/thumbs/40'),('964051ed','@craft/web/assets/edituser/dist'),('9820114e','@runtime/assets/thumbs/38'),('98c30be6','@lib/jquery-ui'),('9a0690e2','@craft/web/assets/pluginstore/dist'),('9bd941a8','@craft/web/assets/feed/dist'),('9c2c7909','@runtime/assets/thumbs/41'),('9c5d06cd','@runtime/assets/thumbs/16'),('9ca59499','@benf/embeddedassets/resources'),('9d22c6d','@runtime/assets/thumbs/12'),('9ee3d36e','@runtime/assets/thumbs/6'),('9f3ec15c','@lib/xregexp'),('a0c19929','@lib/timepicker'),('a0e179ed','@runtime/assets/thumbs/41'),('a2c07642','@runtime/assets/thumbs/14'),('a362d964','@runtime/assets/thumbs/38'),('a36eadd9','@app/web/assets/cp/dist'),('a4cc7cec','@craft/web/assets/craftsupport/dist'),('a5900a56','@lib/jquery.payment'),('a734c6a2','@craft/web/assets/login/dist'),('a750b8a7','@app/web/assets/login/dist'),('a7e2b4ea','@app/web/assets/tablesettings/dist'),('a83852c3','@bower/jquery/dist'),('a890a05a','@app/web/assets/cp/dist'),('a8cb5d6d','@app/web/assets/plugins/dist'),('a8cd9830','@runtime/assets/thumbs/42'),('aa4649c9','@runtime/assets/thumbs/42'),('aa73464e','@runtime/assets/thumbs/13'),('aaaab204','@runtime/assets/thumbs/42'),('ab942132','@doublesecretagency/cpcss/resources'),('acaeb524','@app/web/assets/login/dist'),('acf1a4d4','@runtime/assets/thumbs/87'),('add6c3bd','@runtime/assets/thumbs/42'),('ade1909e','@craft/web/assets/editentry/dist'),('ae03ff0f','@ether/splash/resources'),('aec8dab5','@app/web/assets/utilities/dist'),('af32716f','@craft/web/assets/craftsupport/dist'),('b2c4bc62','@craft/web/assets/deprecationerrors/dist'),('b4960dc8','@craft/web/assets/updates/dist'),('b5a8d39a','@app/web/assets/feed/dist'),('b5dd87d7','@app/web/assets/recententries/dist'),('b6a4b713','@runtime/assets/thumbs/36'),('b7b93b60','@craft/web/assets/recententries/dist'),('b7e31209','@runtime/assets/thumbs/3'),('b856e0f2','@app/web/assets/pluginstore/dist'),('b9b7a5be','@lib/velocity'),('bbb281d6','@runtime/assets/thumbs/39'),('bcd4b7f3','@runtime/assets/thumbs/41'),('be238a54','@app/web/assets/recententries/dist'),('c094440','@craft/web/assets/fields/dist'),('c108914','@runtime/assets/thumbs/86'),('c12ca852','@lib/picturefill'),('c1544c2c','@craft/web/assets/matrix/dist'),('c1866e1d','@craft/web/assets/dbbackup/dist'),('c1b33228','@lib/jquery.payment'),('c1e49bc','@craft/web/assets/plugins/dist'),('c317fedc','@craft/web/assets/login/dist'),('c3c18c94','@app/web/assets/tablesettings/dist'),('c40e9e19','@lib/prismjs'),('c6803c3f','@runtime/assets/thumbs/6'),('c6889490','@lib/jquery-touch-events'),('c7e5673e','@bower/jquery/dist'),('c88d8d5a','@app/web/assets/login/dist'),('c98f9855','@craft/web/assets/utilities/dist'),('c9c2a8e0','@craft/web/assets/editentry/dist'),('ca4d3fab','@lib/jquery.payment'),('caebe2cb','@app/web/assets/utilities/dist'),('cb114911','@craft/web/assets/craftsupport/dist'),('cb539a96','@runtime/assets/thumbs/37'),('cc1b6abd','@bower/jquery/dist'),('ccb39824','@app/web/assets/cp/dist'),('ccc8dad','@lib/fabric'),('ccf09a56','@runtime/assets/thumbs/39'),('cd63b64e','@modules/sitemodule/assetbundles/sitemodule/dist'),('ce1b7157','@runtime/assets/thumbs/14'),('cf898803','@lib/d3'),('d18bebe4','@app/web/assets/feed/dist'),('d1febfa9','@app/web/assets/recententries/dist'),('d3e3e0cb','@runtime/assets/thumbs/15'),('d5cfff04','@yii/debug/assets'),('d66a9043','@lib/velocity'),('d6cdca2','@lib/datepicker-i18n'),('d6f5ff32','@runtime/assets/thumbs/15'),('d78bd50f','@app/web/assets/pluginstore/dist'),('d91def2e','@runtime/assets/thumbs/36'),('d95a200c','@martinherweg/craftgonzo/assetbundles/gonzo/dist'),('d9c4a9ac','@lib/fileupload'),('da75e667','@app/web/assets/feed/dist'),('dbaf8f2c','@runtime/assets/thumbs/3'),('dd6c0dd1','@runtime/assets/thumbs/38'),('dd949dc0','@lib/velocity'),('de65e6bc','@app/web/assets/assetindexes/dist'),('e041bf8b','@app/web/assets/matrixsettings/dist'),('e1d65106','@app/web/assets/craftsupport/dist'),('e22c46d','@app/web/assets/deprecationerrors/dist'),('e29a6763','@craft/web/assets/dashboard/dist'),('e38bc148','@lib/element-resize-detector'),('e875cccb','@lib/element-resize-detector'),('e9646ae0','@craft/web/assets/dashboard/dist'),('e9724bbb','@lib/fabric'),('e9a08faa','@craft/web/assets/plugins/dist'),('eb2f5eb9','@martinherweg/craftgonzo/assetbundles/gonzo/dist'),('ee672736','@benf/embeddedassets/resources'),('ee6d8305','@martinherweg/craftgonzo/assetbundles/gonzo/dist'),('ef44fdc7','@app/web/assets/updateswidget/dist'),('efedb4e5','@runtime/assets/thumbs/88'),('f0907133','@craft/redactor/assets/field/dist'),('f2f7b1a7','@runtime/assets/thumbs/38'),('f31b2e31','@runtime/assets/thumbs/15'),('f4047455','@craft/web/assets/feed/dist'),('f41db42d','@craft/web/assets/clearcaches/dist'),('f478c64','@runtime/assets/thumbs/3'),('f4a2feab','@craft/web/assets/assetindexes/dist'),('f62a16ee','@runtime/assets/thumbs/16'),('f6397dfd','@runtime/assets/thumbs/20'),('f6ae898c','@craft/web/assets/matrixsettings/dist'),('f71e3e1b','@lib/jquery-ui'),('fbed668','@app/web/assets/dashboard/dist'),('fc349f85','@lib/garnishjs'),('ffa2b989','@bower/bootstrap/dist'),('ffcfa6c6','@lib');
/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `routes`
--

LOCK TABLES `routes` WRITE;
/*!40000 ALTER TABLE `routes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `routes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `searchindex`
--

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `searchindex` VALUES (1,'username',0,1,' hi wewereyoung de '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(1,'email',0,1,' hi wewereyoung de '),(1,'slug',0,1,''),(2,'slug',0,1,' homepage '),(2,'title',0,1,' homepage '),(2,'field',3,1,''),(4,'field',9,1,''),(4,'slug',0,1,''),(10,'slug',0,1,' alban '),(10,'title',0,1,' alban '),(64,'field',36,1,' http drissy test '),(64,'field',37,1,' 1 '),(64,'field',38,1,' home '),(64,'slug',0,1,''),(67,'field',36,1,' mailto hi wewereyoung de '),(67,'field',37,1,' 1 '),(67,'field',38,1,''),(67,'slug',0,1,''),(68,'field',25,1,' wewereyoung '),(68,'field',26,1,' pinnasberg '),(68,'field',27,1,' 20359 '),(68,'field',28,1,' hamburg '),(68,'field',29,1,' germany '),(68,'field',30,1,' hi wewereyoung com '),(68,'field',31,1,''),(68,'field',32,1,''),(68,'slug',0,1,''),(49,'field',9,1,' hi '),(49,'slug',0,1,''),(50,'field',9,1,' hi '),(50,'slug',0,1,''),(51,'field',9,1,' hi '),(51,'slug',0,1,''),(52,'field',9,1,' hi '),(52,'slug',0,1,''),(53,'field',9,1,' hi '),(53,'slug',0,1,''),(54,'field',9,1,' hi '),(54,'slug',0,1,''),(67,'field',48,1,''),(64,'field',48,1,' 1 '),(55,'slug',0,1,' commercial '),(55,'title',0,1,' commercial '),(56,'slug',0,1,' crack '),(56,'title',0,1,' crack '),(58,'field',24,1,' hamburg wewereyoung germany hi wewereyoung com 20359 pinnasberg '),(58,'slug',0,1,''),(59,'field',33,1,''),(59,'slug',0,1,''),(60,'field',34,1,''),(60,'slug',0,1,''),(61,'field',35,1,' home 1 http drissy test 1 1 mailto hi wewereyoung de '),(61,'slug',0,1,''),(62,'field',39,1,''),(62,'slug',0,1,''),(63,'field',40,1,''),(63,'slug',0,1,''),(24,'slug',0,1,' wes hicks '),(24,'title',0,1,' wes hicks '),(74,'slug',0,1,' crime '),(74,'title',0,1,' crime '),(75,'filename',0,1,' raad tranquillo official video leonelruben json '),(75,'extension',0,1,' json '),(75,'kind',0,1,' json '),(75,'slug',0,1,''),(75,'title',0,1,' raad tranquillo official video leonelruben '),(77,'slug',0,1,' drama '),(77,'title',0,1,' drama '),(78,'filename',0,1,' eunoia 2015 they disappeared like two mystical ang json '),(78,'extension',0,1,' json '),(78,'kind',0,1,' json '),(78,'slug',0,1,''),(78,'title',0,1,' eunoia 2015 they disappeared like two mystical '),(80,'filename',0,1,' attak 2017 official trailer leonelruben json '),(80,'extension',0,1,' json '),(80,'kind',0,1,' json '),(80,'slug',0,1,''),(80,'title',0,1,' attak 2017 official trailer leonelruben '),(82,'slug',0,1,' trash '),(82,'title',0,1,' trash '),(83,'slug',0,1,' gamble '),(83,'title',0,1,' gamble '),(84,'filename',0,1,' akog_ss18 json '),(84,'extension',0,1,' json '),(84,'kind',0,1,' json '),(84,'slug',0,1,''),(84,'title',0,1,' akog_ss18 '),(86,'filename',0,1,' 1if9rewyy0 jpg '),(86,'extension',0,1,' jpg '),(86,'kind',0,1,' image '),(86,'slug',0,1,''),(86,'title',0,1,' _1if9rewyy0 '),(87,'filename',0,1,' iizstycdxxs jpg '),(87,'extension',0,1,' jpg '),(87,'kind',0,1,' image '),(87,'slug',0,1,''),(87,'title',0,1,' iizstycdxxs '),(88,'filename',0,1,' nrhkcdmlizy jpg '),(88,'extension',0,1,' jpg '),(88,'kind',0,1,' image '),(88,'slug',0,1,''),(88,'title',0,1,' nrhkcdmlizy '),(89,'filename',0,1,' anw7lm chfs jpg '),(89,'extension',0,1,' jpg '),(89,'kind',0,1,' image '),(89,'slug',0,1,''),(89,'title',0,1,' anw7lm chfs '),(90,'field',3,1,''),(90,'slug',0,1,' article '),(90,'title',0,1,' impressum '),(91,'slug',0,1,' data protection '),(91,'title',0,1,' datenschutz '),(91,'field',3,1,''),(92,'field',9,1,''),(92,'slug',0,1,''),(93,'field',9,1,''),(93,'slug',0,1,'');
/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections` VALUES (1,NULL,'Work','work','channel',1,1,'2018-05-02 13:43:24','2018-05-05 12:53:09','534f80b8-5d36-4785-ae42-80153dafbf2c'),(2,NULL,'Homepage','homepage','single',1,1,'2018-05-02 13:44:01','2018-05-02 18:45:46','067c114d-4f7a-4716-b308-0dfefa1de9e5'),(5,NULL,'Imprint','imprint','single',1,1,'2018-05-14 14:21:09','2018-05-14 14:28:58','26538c57-f825-4d98-a5a3-772d8fd7c508'),(6,NULL,'Data Protection','dataProtection','single',1,1,'2018-05-14 14:29:53','2018-05-14 14:29:53','863614ef-62f3-4ca2-9588-ad0671237297');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections_sites`
--

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections_sites` VALUES (1,1,1,1,'work/{postDate|date(\"Y\")}/{postDate|date(\"m\")}/{slug}','_entry',1,'2018-05-02 13:43:24','2018-05-05 12:53:09','714cda2d-ad11-4ad3-8464-656247f68ed7'),(2,2,1,1,'__home__','index',1,'2018-05-02 13:44:01','2018-05-02 18:45:46','e34b5f15-4657-46f7-949f-41794808245b'),(5,5,1,1,'imprint','_entry',1,'2018-05-14 14:21:09','2018-05-14 14:28:58','18e7153d-41df-4e91-8ec5-5ca02e02f455'),(6,6,1,1,'data-protection','_entry',1,'2018-05-14 14:29:53','2018-05-14 14:29:53','b19e886f-ffad-4935-9975-37cf17d26070');
/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `shunnedmessages`
--

LOCK TABLES `shunnedmessages` WRITE;
/*!40000 ALTER TABLE `shunnedmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sitegroups`
--

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sitegroups` VALUES (1,'drissy','2018-04-30 15:34:51','2018-04-30 15:34:51','f8d87a05-56b7-4aad-8e28-08f54307f0f7');
/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sites` VALUES (1,1,1,'drissy','default','en-US',1,'@web/',1,'2018-04-30 15:34:51','2018-04-30 15:34:51','18cc759f-911b-4dee-a438-b50790f9d6fb');
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structureelements`
--

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structures`
--

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `systemmessages`
--

LOCK TABLES `systemmessages` WRITE;
/*!40000 ALTER TABLE `systemmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `systemmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `systemsettings`
--

LOCK TABLES `systemsettings` WRITE;
/*!40000 ALTER TABLE `systemsettings` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `systemsettings` VALUES (1,'email','{\"fromEmail\":\"hi@wewereyoung.de\",\"fromName\":\"drissy\",\"transportType\":\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"}','2018-04-30 15:34:52','2018-04-30 15:34:52','22e0889f-a34a-40d0-b610-d2402b2f43d6'),(2,'users','{\"requireEmailVerification\":true,\"allowPublicRegistration\":false,\"defaultGroup\":null,\"photoVolumeId\":\"5\",\"photoSubpath\":\"\"}','2018-05-09 09:17:06','2018-05-09 09:17:06','eaf1346f-87ca-43b6-a568-3fec43adde76');
/*!40000 ALTER TABLE `systemsettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `taggroups`
--

LOCK TABLES `taggroups` WRITE;
/*!40000 ALTER TABLE `taggroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `taggroups` VALUES (1,'Default','default',10,'2018-05-03 11:01:12','2018-05-03 11:01:12','8521eaf1-092e-4c21-8e5d-7912bea06a88');
/*!40000 ALTER TABLE `taggroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `tags` VALUES (10,1,'2018-05-03 11:01:36','2018-05-03 11:01:36','46241b7f-32c0-45a1-bc75-7a9375b66f29'),(24,1,'2018-05-03 18:28:29','2018-05-03 18:28:29','1dda757d-f262-4db9-8be1-c53362e95d16'),(55,1,'2018-05-05 10:11:13','2018-05-05 10:11:13','1286c94b-8205-4ae5-b427-eef9c6cca225'),(56,1,'2018-05-05 11:46:06','2018-05-05 11:46:06','b70fb2dd-2b3b-4bec-aec1-cdbd4c0aa28f'),(74,1,'2018-05-09 13:35:06','2018-05-09 13:35:06','c20514d9-2650-4275-af58-bcdf25b32eca'),(77,1,'2018-05-09 13:39:06','2018-05-09 13:39:06','bd743000-7002-469d-ac1b-b1cf6214ddf5'),(82,1,'2018-05-09 13:41:14','2018-05-09 13:41:14','3c2627d8-f3e0-4d3d-8b1d-ffb5aab97ed1'),(83,1,'2018-05-09 13:41:21','2018-05-09 13:41:21','36f672e0-bce5-4699-88a9-0288d780747f');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `templatecachequeries`
--

LOCK TABLES `templatecachequeries` WRITE;
/*!40000 ALTER TABLE `templatecachequeries` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `templatecachequeries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups`
--

LOCK TABLES `usergroups` WRITE;
/*!40000 ALTER TABLE `usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups_users`
--

LOCK TABLES `usergroups_users` WRITE;
/*!40000 ALTER TABLE `usergroups_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions`
--

LOCK TABLES `userpermissions` WRITE;
/*!40000 ALTER TABLE `userpermissions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_usergroups`
--

LOCK TABLES `userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `userpermissions_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_users`
--

LOCK TABLES `userpermissions_users` WRITE;
/*!40000 ALTER TABLE `userpermissions_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpreferences`
--

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `userpreferences` VALUES (1,'{\"language\":\"en-US\",\"weekStartDay\":\"1\",\"enableDebugToolbarForSite\":false,\"enableDebugToolbarForCp\":false}');
/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `users` VALUES (1,'hi@wewereyoung.de',NULL,'','','hi@wewereyoung.de','$2y$13$/VNTkQd9mAJ3EkbWf9AanOGoE0fkqTw2LUddN9TjuYuWewJV5cgpC',1,0,0,0,'2018-05-17 13:01:12','127.0.0.1',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2018-04-30 15:34:52','2018-04-30 15:34:52','2018-05-17 13:01:12','30729f57-88c5-43b0-a651-b2b37bb3b4bd');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumefolders`
--

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `volumefolders` VALUES (1,NULL,1,'Site Images','','2018-05-02 14:08:06','2018-05-05 14:21:09','32d6a90d-c0df-49d8-9042-9080190e0cb4'),(3,NULL,NULL,'Temporary source',NULL,'2018-05-02 14:08:50','2018-05-02 14:08:50','8477c568-ffac-4f7a-bcda-c39235668005'),(4,3,NULL,'user_1','user_1/','2018-05-02 14:08:50','2018-05-02 14:08:50','95836bf6-54bd-4de5-8ac6-eff959a24a7b'),(5,NULL,3,'Site Downloads','','2018-05-05 14:19:33','2018-05-05 14:20:25','161951da-92c9-4d35-8e5d-ad31ca915b47'),(6,NULL,4,'Site Media','','2018-05-05 14:19:49','2018-05-05 14:19:49','52ff8844-7dc3-47bf-825e-8f4f76e5c78a'),(7,NULL,5,'Site Users','','2018-05-05 14:21:31','2018-05-05 14:21:31','2c1fecc4-bd20-4c9e-837e-fd5b911bf2e8');
/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `volumes` VALUES (1,5,'Site Images','siteImages','craft\\volumes\\Local',1,'@baseUrl/uploads/images','{\"path\":\"@basePath/uploads/images\"}',1,'2018-05-02 14:08:06','2018-05-05 14:21:09','81513b32-d6d3-4819-9687-a5d040fc148b'),(3,14,'Site Downloads','siteDownloads','craft\\volumes\\Local',1,'@baseUrl/uploads/downloads','{\"path\":\"@basePath/uploads/downloads\"}',3,'2018-05-05 14:19:33','2018-05-05 14:20:25','495c2d0c-9b28-4eb7-bc3a-4a83c8d44091'),(4,15,'Site Media','siteMedia','craft\\volumes\\Local',0,NULL,'{\"path\":\"@basePath/uploads/media\"}',4,'2018-05-05 14:19:49','2018-05-05 14:19:49','a165d8a4-ef7e-480c-a7f1-a9e19ab9750b'),(5,16,'Site Users','siteUsers','craft\\volumes\\Local',1,'@baseUrl/uploads/users','{\"path\":\"@basePath/uploads/users\"}',5,'2018-05-05 14:21:31','2018-05-05 14:21:34','6f1b81a3-998d-4341-a3a6-49903293a810');
/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,0,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}','2018-04-30 15:35:28','2018-04-30 15:35:28','81a76194-bf72-405a-bece-c0bc555e3dcd'),(2,1,'craft\\widgets\\CraftSupport',2,0,'[]','2018-04-30 15:35:28','2018-04-30 15:35:28','ab490d7d-451c-4fa7-ba6e-d5997ab8afcf'),(3,1,'craft\\widgets\\Updates',3,0,'[]','2018-04-30 15:35:28','2018-04-30 15:35:28','2a378f14-8561-495b-8780-b749b260070f'),(4,1,'craft\\widgets\\Feed',4,0,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}','2018-04-30 15:35:28','2018-04-30 15:35:28','ff12ee24-a29a-4531-803f-bfb11edc188c');
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping routines for database 'drissy_dev'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-17 15:33:18
