-- MySQL dump 10.16  Distrib 10.2.14-MariaDB, for osx10.13 (x86_64)
--
-- Host: localhost    Database: wfw
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
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
  `field_googleAnalytics` text DEFAULT NULL,
  `field_globalSocialNetworks` text DEFAULT NULL,
  `field_entryIntroHeadline` text DEFAULT NULL,
  `field_entryIntroText` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=190 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=3373 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=220 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=220 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=229 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=305 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixcontent_contentbuilder`
--

DROP TABLE IF EXISTS `matrixcontent_contentbuilder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixcontent_contentbuilder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_headline_headline` text DEFAULT NULL,
  `field_Text_Text` text DEFAULT NULL,
  `field_imageSingle_caption` text DEFAULT NULL,
  `field_imageCarousel_caption` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixcontent_contentbuilder_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `matrixcontent_contentbuilder_siteId_fk` (`siteId`),
  CONSTRAINT `matrixcontent_contentbuilder_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixcontent_contentbuilder_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=246 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=300 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seomatic_metabundles`
--

DROP TABLE IF EXISTS `seomatic_metabundles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seomatic_metabundles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `bundleVersion` varchar(255) NOT NULL DEFAULT '',
  `sourceBundleType` varchar(255) NOT NULL DEFAULT '',
  `sourceId` int(11) DEFAULT NULL,
  `sourceName` varchar(255) NOT NULL DEFAULT '',
  `sourceHandle` varchar(64) NOT NULL DEFAULT '',
  `sourceType` varchar(64) NOT NULL DEFAULT '',
  `sourceTemplate` varchar(500) DEFAULT '',
  `sourceSiteId` int(11) DEFAULT NULL,
  `sourceAltSiteSettings` text DEFAULT NULL,
  `sourceDateUpdated` datetime NOT NULL,
  `metaGlobalVars` text DEFAULT NULL,
  `metaSiteVars` text DEFAULT NULL,
  `metaSitemapVars` text DEFAULT NULL,
  `metaContainers` text DEFAULT NULL,
  `redirectsContainer` text DEFAULT NULL,
  `frontendTemplatesContainer` text DEFAULT NULL,
  `metaBundleSettings` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `seomatic_metabundles_sourceBundleType_idx` (`sourceBundleType`),
  KEY `seomatic_metabundles_sourceId_idx` (`sourceId`),
  KEY `seomatic_metabundles_sourceSiteId_idx` (`sourceSiteId`),
  KEY `seomatic_metabundles_sourceHandle_idx` (`sourceHandle`),
  CONSTRAINT `seomatic_metabundles_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
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
-- Dumping routines for database 'wfw'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-06-07 16:28:06
-- MySQL dump 10.16  Distrib 10.2.14-MariaDB, for osx10.13 (x86_64)
--
-- Host: localhost    Database: wfw
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
INSERT INTO `assets` VALUES (96,1,1,'photo-1528280469494-bc0421abebab.jpeg','image',2832,4240,2334431,NULL,'2018-06-06 13:51:35','2018-06-06 13:51:35','2018-06-07 13:58:02','ae0f8c06-295a-49cf-a95c-77666a4acd3c');
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
INSERT INTO `categories` VALUES (166,1,'2018-06-07 13:25:45','2018-06-07 13:25:45','df949426-6868-4f44-950c-87079df535b6'),(167,1,'2018-06-07 13:25:51','2018-06-07 13:25:51','12381b59-6066-493d-827b-f6bcea0ab753'),(168,1,'2018-06-07 13:26:06','2018-06-07 13:26:06','5727ec68-4d7f-48f5-8e2c-620f2e862097'),(169,1,'2018-06-07 13:26:13','2018-06-07 13:26:13','f335feff-5436-46c9-8349-49cba7d3cb60'),(170,1,'2018-06-07 13:26:17','2018-06-07 13:26:17','299fd899-2a72-4de8-a006-7c8a43f32b1d'),(172,1,'2018-06-07 13:27:13','2018-06-07 13:27:13','30cad93e-5d73-4ddd-ae7a-73865e3d1ed9');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups`
--

LOCK TABLES `categorygroups` WRITE;
/*!40000 ALTER TABLE `categorygroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `categorygroups` VALUES (1,4,49,'Projekt Typ','projekttyp','2018-06-07 13:25:20','2018-06-07 13:25:38','0b9d4531-e725-4bb8-a2c6-2703b8c10a8f');
/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups_sites`
--

LOCK TABLES `categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `categorygroups_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `categorygroups_sites` VALUES (1,1,1,1,'projekttyp/{slug}','projekttyp/_category','2018-06-07 13:25:20','2018-06-07 13:25:38','f69da294-e361-439b-8dac-d3a86b02a24e');
/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `content` VALUES (1,1,1,NULL,'2018-04-30 15:34:51','2018-06-02 11:49:31','675e89c3-9781-4d88-b20b-4c1a824af24a',NULL,NULL,NULL,NULL),(2,2,1,'Home','2018-05-02 13:44:02','2018-06-06 14:34:54','69a0351d-e731-4a72-b887-cc6b23372109',NULL,NULL,'asfsafasfsdf','<p>safasdfsdfsdfsdfsdfsdfsdfsdfsdfsdf</p>\n'),(6,10,1,'Alban','2018-05-03 11:01:36','2018-05-03 11:01:36','fee09d73-6b51-44cd-9833-9f02744b4c70',NULL,NULL,NULL,NULL),(16,24,1,'Wes Hicks','2018-05-03 18:28:29','2018-05-03 18:28:29','b58b905b-20f0-4292-86fd-b666d406dc6d',NULL,NULL,NULL,NULL),(37,55,1,'Commercial','2018-05-05 10:11:13','2018-05-05 10:11:13','4e238683-71d6-4ba2-9605-4896ea5d852b',NULL,NULL,NULL,NULL),(38,56,1,'Crack','2018-05-05 11:46:06','2018-05-05 11:46:06','448e81a4-795e-4f9c-8ff5-a698541318d6',NULL,NULL,NULL,NULL),(40,58,1,NULL,'2018-05-05 14:54:42','2018-05-17 13:02:28','f4779bbd-1410-4fb3-8457-7c18d447e53d',NULL,NULL,NULL,NULL),(41,59,1,NULL,'2018-05-05 14:55:05','2018-05-05 14:55:05','07cb7188-b7e0-44a2-b8ff-55701e7006ca',NULL,NULL,NULL,NULL),(42,60,1,NULL,'2018-05-05 14:55:25','2018-05-05 14:55:25','eeb2636f-1319-4ca5-8332-ea667ebd0b6c',NULL,NULL,NULL,NULL),(43,61,1,NULL,'2018-05-05 14:55:43','2018-05-17 13:03:01','8c67312e-5f43-4e97-a236-4a7d25375c6e',NULL,NULL,NULL,NULL),(44,62,1,NULL,'2018-05-05 14:56:01','2018-05-17 13:03:05','fc46befb-77f6-4bc7-8ddc-52547f34d407',NULL,NULL,NULL,NULL),(45,63,1,NULL,'2018-05-05 14:56:15','2018-05-05 14:56:15','032eb5c9-60ee-49f7-9dd8-0ea31780edc7',NULL,NULL,NULL,NULL),(51,74,1,'Crime','2018-05-09 13:35:06','2018-05-09 13:35:06','3cfe8694-60fe-49cf-9573-ae109d7c9d00',NULL,NULL,NULL,NULL),(54,77,1,'Drama','2018-05-09 13:39:06','2018-05-09 13:39:06','75760501-afce-4729-9201-4ac10a0eb03e',NULL,NULL,NULL,NULL),(59,82,1,'Trash','2018-05-09 13:41:14','2018-05-09 13:41:14','230fa0a5-01ea-4611-a7b2-8f41c07c24fd',NULL,NULL,NULL,NULL),(60,83,1,'Gamble','2018-05-09 13:41:21','2018-05-09 13:41:21','8c46b7fc-66b4-4abc-9eda-7f5a00d741e9',NULL,NULL,NULL,NULL),(70,96,1,'Photo 1528280469494 Bc0421Abebab','2018-06-06 13:51:32','2018-06-07 13:58:02','546e999e-e8df-4840-b05d-44a14a52ae2a',NULL,NULL,NULL,NULL),(77,107,1,'News','2018-06-07 08:12:35','2018-06-07 13:13:16','548a6a7b-d330-4657-9c0d-e9453eb5f79c',NULL,NULL,NULL,'<p><br /></p>\n'),(78,108,1,'Shop','2018-06-07 08:12:47','2018-06-07 13:13:16','b276d4ff-e65c-48e4-be74-701b453735ea',NULL,NULL,NULL,'<p><br /></p>\n'),(84,114,1,'Partner werden','2018-06-07 08:19:45','2018-06-07 13:13:16','f830e252-015c-43e6-9739-d511c09bb178',NULL,NULL,NULL,'<p><br /></p>\n'),(85,115,1,'Spenden','2018-06-07 08:20:00','2018-06-07 13:13:16','894c3b04-533e-4991-9575-4b2545b7401e',NULL,NULL,NULL,'<p><br /></p>\n'),(86,116,1,'Gönnerclub','2018-06-07 08:20:11','2018-06-07 13:13:16','4489d289-1d4a-413c-93ce-158409da11fe',NULL,NULL,NULL,'<p><br /></p>\n'),(87,117,1,'Gastropartner','2018-06-07 08:20:20','2018-06-07 13:13:16','43328c84-14a5-46c6-b017-3908b2492818',NULL,NULL,NULL,'<p><br /></p>\n'),(88,118,1,'Büropartner','2018-06-07 08:20:30','2018-06-07 13:13:16','3e8bc837-7546-4262-9cce-958a124bbb5f',NULL,NULL,NULL,'<p><br /></p>\n'),(89,119,1,'Freunde','2018-06-07 08:20:44','2018-06-07 13:13:16','b9129e6b-c21d-448f-bf74-d28497fffd41',NULL,NULL,NULL,'<p><br /></p>\n'),(90,120,1,'Crowdfunding','2018-06-07 08:20:54','2018-06-07 13:13:16','fee0a12c-fb83-4fa1-8ce7-ffcc88c6b518',NULL,NULL,NULL,'<p><br /></p>\n'),(99,129,1,'Aufklärung','2018-06-07 10:37:10','2018-06-07 10:40:48','d4b7982c-5669-4f13-9628-c25b055b899a',NULL,NULL,NULL,NULL),(103,133,1,'Gastro','2018-06-07 10:38:04','2018-06-07 10:40:48','a47d7dcf-fe03-4775-a344-defbf17c7f79',NULL,NULL,NULL,NULL),(117,147,1,'Unsere Partner','2018-06-07 12:55:54','2018-06-07 13:13:16','8d4db5a9-a8c8-4e49-aacd-b042094d8272',NULL,NULL,NULL,'<p><br /></p>\n'),(118,148,1,'Impressum','2018-06-07 12:59:44','2018-06-07 13:13:16','2b0132aa-769d-497a-b93d-e37a89347857',NULL,NULL,NULL,'<p><br /></p>\n'),(119,149,1,'Datenschutz','2018-06-07 12:59:56','2018-06-07 13:13:16','016087ad-e628-4b23-b19f-20f85331b882',NULL,NULL,NULL,'<p><br /></p>\n'),(121,151,1,'Über Uns','2018-06-07 13:00:29','2018-06-07 13:13:16','9f839b24-e268-4fb3-93f7-b9e8e6d504e3',NULL,NULL,NULL,'<p><br /></p>\n'),(122,152,1,'Wasserwissen','2018-06-07 13:00:52','2018-06-07 13:13:16','882e52fa-5eaf-48b9-9069-51fd92ca22c3',NULL,NULL,NULL,'<p><br /></p>\n'),(123,153,1,'Was wir machen','2018-06-07 13:03:04','2018-06-07 13:13:16','6923c0be-192c-494c-a49b-1764df7e6b4d',NULL,NULL,NULL,'<p><br /></p>\n'),(124,154,1,'Schweiz','2018-06-07 13:03:47','2018-06-07 13:13:16','a26c1bce-6720-4ecf-b4e1-7000947bc8f4',NULL,NULL,NULL,'<p><br /></p>\n'),(125,155,1,'Afrika','2018-06-07 13:04:07','2018-06-07 13:13:16','6d802acd-3441-4c07-8fa1-f0326cf428c0',NULL,NULL,NULL,'<p><br /></p>\n'),(128,158,1,'Tätigkeiten','2018-06-07 13:09:59','2018-06-07 13:13:16','15167c6e-f7bd-404f-a815-34b040fade4b',NULL,NULL,NULL,'<p><br /></p>\n'),(129,159,1,'Sensibilisierung','2018-06-07 13:10:25','2018-06-07 13:13:16','1aba2ba6-8f1a-4f30-be27-889fb1c9e9d6',NULL,NULL,NULL,'<p><br /></p>\n'),(130,160,1,'Aufklärung','2018-06-07 13:14:04','2018-06-07 13:14:04','96fff56a-077f-42be-af25-d5d41861d667',NULL,NULL,NULL,'<p><br /></p>\n'),(131,161,1,'Leitungswasser fördern','2018-06-07 13:14:16','2018-06-07 13:14:16','bd322215-1cbf-4965-bb50-c36419b0e5e2',NULL,NULL,NULL,'<p><br /></p>\n'),(132,162,1,'Länder','2018-06-07 13:14:44','2018-06-07 13:14:44','f7581459-8b72-47ad-90bb-b51721ced841',NULL,NULL,NULL,'<p><br /></p>\n'),(133,163,1,'Sambia','2018-06-07 13:14:51','2018-06-07 13:14:51','3a8a16fb-92c1-49ed-9cbf-2789153a4f58',NULL,NULL,NULL,'<p><br /></p>\n'),(134,164,1,'Mosambique','2018-06-07 13:15:03','2018-06-07 13:15:03','176a1b83-70dc-4278-9c8e-2f1f48e71f09',NULL,NULL,NULL,'<p><br /></p>\n'),(136,166,1,'Büro','2018-06-07 13:25:45','2018-06-07 13:25:45','7840efda-47fe-4b8a-bbfc-922f184d1a90',NULL,NULL,NULL,NULL),(137,167,1,'Gastro','2018-06-07 13:25:51','2018-06-07 13:25:51','b504951c-d805-45de-9a1c-525213c2dfbd',NULL,NULL,NULL,NULL),(138,168,1,'weitere Projekte','2018-06-07 13:26:06','2018-06-07 13:26:06','40edcd54-b633-4eae-b149-0612a581e8cd',NULL,NULL,NULL,NULL),(139,169,1,'Infrastruktur','2018-06-07 13:26:13','2018-06-07 13:26:13','e9de7326-6106-4aac-b9ba-5694e776549e',NULL,NULL,NULL,NULL),(140,170,1,'Bildung','2018-06-07 13:26:17','2018-06-07 13:26:17','6d7d9d08-a08b-4196-9eb7-2bfd74fa81c6',NULL,NULL,NULL,NULL),(142,172,1,'Sanitation & Hygiene','2018-06-07 13:27:13','2018-06-07 13:27:13','9c188900-276e-4952-9f85-7b9d281b67a5',NULL,NULL,NULL,NULL),(144,174,1,'Spenden','2018-06-07 13:36:21','2018-06-07 13:36:21','be525b58-cc56-414c-8d2d-b3c911dfa546',NULL,NULL,NULL,'<p><br /></p>\n'),(153,183,1,'Büro-Partner 1','2018-06-07 13:52:55','2018-06-07 13:52:55','5626f1fa-8e73-47d1-8665-a41c7950e8d2',NULL,NULL,NULL,NULL),(154,184,1,'Büro-Partner 2','2018-06-07 13:53:10','2018-06-07 13:53:10','043e0f64-fd08-452c-a91c-4699c87f53ef',NULL,NULL,NULL,NULL),(155,185,1,'Büro-Partner 3','2018-06-07 13:53:17','2018-06-07 13:53:17','6c9a44ba-1bee-4e1b-82c9-32c52532fa62',NULL,NULL,NULL,NULL),(157,187,1,'Büro-Partner 4','2018-06-07 13:53:41','2018-06-07 13:53:41','dc3dbe04-c3a0-44bc-80b2-e36ce3c0a828',NULL,NULL,NULL,NULL),(158,188,1,'Büro-Partner 5','2018-06-07 13:53:47','2018-06-07 13:53:47','22fa8c00-d814-46df-9ad2-ac464c32e2e3',NULL,NULL,NULL,NULL),(159,189,1,'Büro-Partner 6','2018-06-07 13:53:53','2018-06-07 13:53:53','5191a80b-201f-4a37-ac08-aea369e4b9bd',NULL,NULL,NULL,NULL),(160,190,1,'Gastro-Partner 1','2018-06-07 13:54:10','2018-06-07 13:54:10','5e1d0d9a-2a71-4bab-b4d2-708d0289222b',NULL,NULL,NULL,NULL),(161,191,1,'Gastro-Partner 2','2018-06-07 13:54:15','2018-06-07 13:54:15','b6002903-008b-4245-86bf-2ea3912377fa',NULL,NULL,NULL,NULL),(162,192,1,'Gastro-Partner 3','2018-06-07 13:54:18','2018-06-07 13:54:18','b91d6548-0caf-4551-9c6b-292267701d3d',NULL,NULL,NULL,NULL),(163,193,1,'Gastro-Partner 4','2018-06-07 13:54:21','2018-06-07 13:54:21','102d7875-5ec7-40aa-a2e4-c3bc36eb45de',NULL,NULL,NULL,NULL),(164,194,1,'Gastro-Partner 5','2018-06-07 13:54:25','2018-06-07 13:54:25','49143d71-45b3-4948-8493-8728d4bd2009',NULL,NULL,NULL,NULL),(165,195,1,'Gastro-Partner 6','2018-06-07 13:54:29','2018-06-07 13:54:29','7f13348a-867e-48b7-b99e-23650494edb9',NULL,NULL,NULL,NULL),(166,196,1,'Service-Partner 1','2018-06-07 13:54:42','2018-06-07 13:54:42','57fd06e3-075e-46d3-9578-1fda35b3367f',NULL,NULL,NULL,NULL),(167,197,1,'Service-Partner 2','2018-06-07 13:54:46','2018-06-07 13:54:46','c54fc2be-15fc-4ae5-a6fb-aa70bda8fe11',NULL,NULL,NULL,NULL),(168,198,1,'Service-Partner 3','2018-06-07 13:54:49','2018-06-07 13:54:49','3b7be195-c1f4-43e3-b744-7c5e82090b41',NULL,NULL,NULL,NULL),(169,199,1,'Service-Partner 4','2018-06-07 13:54:53','2018-06-07 13:54:53','f6e8754f-9f00-41c5-b35f-121ed35f49e4',NULL,NULL,NULL,NULL),(170,200,1,'Service-Partner 5','2018-06-07 13:55:00','2018-06-07 13:55:00','72180974-539d-4dfd-ade9-8e7054aea043',NULL,NULL,NULL,NULL),(171,201,1,'Service-Partner 6','2018-06-07 13:55:05','2018-06-07 13:55:05','725c3a8d-b301-490b-b5cb-666dd44d6dbb',NULL,NULL,NULL,NULL),(172,202,1,'News-Artikel 1','2018-06-07 13:55:27','2018-06-07 13:55:52','4263eff4-bf90-4d2f-ac54-bc0aed34ccca',NULL,NULL,NULL,'<p><br /></p>\n'),(173,203,1,'News-Artikel 2','2018-06-07 13:55:56','2018-06-07 13:55:56','ad46a801-f429-448a-bf65-c3944392abed',NULL,NULL,NULL,'<p><br /></p>\n'),(174,204,1,'News-Artikel 3','2018-06-07 13:55:59','2018-06-07 13:55:59','bbdd1749-0b4a-4fac-812a-9858f027522f',NULL,NULL,NULL,'<p><br /></p>\n'),(175,205,1,'News-Artikel 4','2018-06-07 13:56:03','2018-06-07 13:56:03','1cd016d9-0638-4d8e-8e77-010ea1bcc2ee',NULL,NULL,NULL,'<p><br /></p>\n'),(176,206,1,'News-Artikel 5','2018-06-07 13:56:07','2018-06-07 13:56:07','6de7b474-ebb9-46d5-a80c-8a65397b11e0',NULL,NULL,NULL,'<p><br /></p>\n'),(177,207,1,'News-Artikel 6','2018-06-07 13:56:12','2018-06-07 13:56:12','aa37b21e-31f7-4253-9ac5-28302ef536ad',NULL,NULL,NULL,'<p><br /></p>\n'),(178,208,1,'Projekt-Afrika 1','2018-06-07 13:56:32','2018-06-07 13:56:32','a28c20d1-997d-4e15-b466-442db4e2029b',NULL,NULL,NULL,NULL),(179,209,1,'Projekt-Afrika 2','2018-06-07 13:56:36','2018-06-07 13:56:36','3c1fddc0-e5ca-461b-b6c1-49d9570e4bd1',NULL,NULL,NULL,NULL),(180,210,1,'Projekt-Afrika 3','2018-06-07 13:56:39','2018-06-07 13:56:39','1604c833-ab4e-4ed9-93b6-b315e29ef1c8',NULL,NULL,NULL,NULL),(181,211,1,'Projekt-Afrika 4','2018-06-07 13:56:42','2018-06-07 13:56:42','d4b23741-64f4-416b-a5d7-0bb1fb7fb89b',NULL,NULL,NULL,NULL),(182,212,1,'Projekt-Afrika 5','2018-06-07 13:56:46','2018-06-07 13:56:46','95f163fc-e2d3-4525-b637-691a0e6de15a',NULL,NULL,NULL,NULL),(183,213,1,'Projekt-Afrika 6','2018-06-07 13:56:49','2018-06-07 13:56:49','f89fa363-3236-4016-bcf9-a6c6265acd0a',NULL,NULL,NULL,NULL),(184,214,1,'Projekt-Schweiz 1','2018-06-07 13:57:10','2018-06-07 13:57:10','b8dd6c28-d78d-4704-ac24-74d22b016f6f',NULL,NULL,NULL,NULL),(185,215,1,'Projekt-Schweiz 2','2018-06-07 13:57:14','2018-06-07 13:57:14','4382b33f-7f57-42f9-9b7d-f9eb28596613',NULL,NULL,NULL,NULL),(186,216,1,'Projekt-Schweiz 3','2018-06-07 13:57:17','2018-06-07 13:57:17','36cf9a33-c796-4d0d-905e-94e7cb1474b8',NULL,NULL,NULL,NULL),(187,217,1,'Projekt-Schweiz 4','2018-06-07 13:57:20','2018-06-07 13:57:20','73efa5f1-0896-48f2-948f-6863c55844ee',NULL,NULL,NULL,NULL),(188,218,1,'Projekt-Schweiz 5','2018-06-07 13:57:24','2018-06-07 13:57:24','c3115bd6-94ba-4600-a263-9184e652d5d9',NULL,NULL,NULL,NULL),(189,219,1,'Projekt-Schweiz 6','2018-06-07 13:57:28','2018-06-07 13:57:28','bffe1d56-b732-46e9-ab9e-52b5cde2a8a9',NULL,NULL,NULL,NULL);
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
INSERT INTO `deprecationerrors` VALUES (3319,'ElementQuery::getIterator()','/Users/hendrik/Documents/Github/Projects/drissy/templates/_matrix.twig:7','2018-05-17 13:07:29','/Users/hendrik/Documents/Github/Projects/drissy/templates/_matrix.twig',7,'Looping through element queries directly has been deprecated. Use the all() function to fetch the query results before looping over them.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/elements/db/ElementQuery.php\",\"line\":403,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"ElementQuery::getIterator()\\\", \\\"Looping through element queries directly has been deprecated. Us...\\\"\"},{\"objectClass\":\"craft\\\\elements\\\\db\\\\MatrixBlockQuery\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/storage/runtime/compiled_templates/55/55e711669fd7307f62e52fae3c5db96af6ada6c10ca1b66d44bc13ea681ff7e1.php\",\"line\":44,\"class\":\"craft\\\\elements\\\\db\\\\ElementQuery\",\"method\":\"getIterator\",\"args\":null},{\"objectClass\":\"__TwigTemplate_16877d09e36fa4cc40bf0625e67904b2b70b56d2c68736399bc7b45421f6855c\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/twig/twig/lib/Twig/Template.php\",\"line\":390,\"class\":\"__TwigTemplate_16877d09e36fa4cc40bf0625e67904b2b70b56d2c68736399bc7b45421f6855c\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_16877d09e36fa4cc40bf0625e67904b2b70b56d2c68736399bc7b45421f6855c\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":49,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_16877d09e36fa4cc40bf0625e67904b2b70b56d2c68736399bc7b45421f6855c\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/twig/twig/lib/Twig/Template.php\",\"line\":367,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_16877d09e36fa4cc40bf0625e67904b2b70b56d2c68736399bc7b45421f6855c\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":31,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_16877d09e36fa4cc40bf0625e67904b2b70b56d2c68736399bc7b45421f6855c\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/storage/runtime/compiled_templates/e5/e5e15eff547d3557a2f4a7f8906011da4e68060c4b32a2a24dd023705b507596.php\",\"line\":75,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...]\"},{\"objectClass\":\"__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/twig/twig/lib/Twig/Template.php\",\"line\":189,\"class\":\"__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279\",\"method\":\"block_itemContent\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/storage/runtime/compiled_templates/e5/e5e15eff547d3557a2f4a7f8906011da4e68060c4b32a2a24dd023705b507596.php\",\"line\":53,\"class\":\"Twig_Template\",\"method\":\"displayBlock\",\"args\":\"\\\"itemContent\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/twig/twig/lib/Twig/Template.php\",\"line\":189,\"class\":\"__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279\",\"method\":\"block_content\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/storage/runtime/compiled_templates/d5/d5e134785c122aec123de9836b85a905a00c68057346d22b8c728e5f14e56a3e.php\",\"line\":323,\"class\":\"Twig_Template\",\"method\":\"displayBlock\",\"args\":\"\\\"content\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/twig/twig/lib/Twig/Template.php\",\"line\":189,\"class\":\"__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa\",\"method\":\"block_body\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/storage/runtime/compiled_templates/d5/d5e134785c122aec123de9836b85a905a00c68057346d22b8c728e5f14e56a3e.php\",\"line\":278,\"class\":\"Twig_Template\",\"method\":\"displayBlock\",\"args\":\"\\\"body\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/twig/twig/lib/Twig/Template.php\",\"line\":390,\"class\":\"__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":49,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/twig/twig/lib/Twig/Template.php\",\"line\":367,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":31,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"_inline_css\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block__inline_css\\\"], \\\"content\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block_content\\\"], \\\"itemContent\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_09f0886202ef2ca9a0cf07923c5515fc24e14d09ac68a28a23b33e453367fefa\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/storage/runtime/compiled_templates/e5/e5e15eff547d3557a2f4a7f8906011da4e68060c4b32a2a24dd023705b507596.php\",\"line\":30,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"_inline_css\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block__inline_css\\\"], \\\"content\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block_content\\\"], \\\"itemContent\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/twig/twig/lib/Twig/Template.php\",\"line\":390,\"class\":\"__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"_inline_css\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block__inline_css\\\"], \\\"content\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block_content\\\"], \\\"itemContent\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":49,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"_inline_css\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block__inline_css\\\"], \\\"content\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block_content\\\"], \\\"itemContent\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/twig/twig/lib/Twig/Template.php\",\"line\":367,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"_inline_css\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block__inline_css\\\"], \\\"content\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block_content\\\"], \\\"itemContent\\\" => [__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":31,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_9d47d1a004b265cae3c7e4eb6bb7478442618b0780875d009c8e301fbfb71279\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/storage/runtime/compiled_templates/e0/e0c270ab72d283a8b52692d818b505e3909fd389e9c3d73c308129b79a623341.php\",\"line\":32,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...]\"},{\"objectClass\":\"__TwigTemplate_37a46ea4d9b62bbc387970fb078c64144acaaa98fe957acd82e197c7aa3eaf36\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/twig/twig/lib/Twig/Template.php\",\"line\":390,\"class\":\"__TwigTemplate_37a46ea4d9b62bbc387970fb078c64144acaaa98fe957acd82e197c7aa3eaf36\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_37a46ea4d9b62bbc387970fb078c64144acaaa98fe957acd82e197c7aa3eaf36\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":49,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_37a46ea4d9b62bbc387970fb078c64144acaaa98fe957acd82e197c7aa3eaf36\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/twig/twig/lib/Twig/Template.php\",\"line\":367,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_37a46ea4d9b62bbc387970fb078c64144acaaa98fe957acd82e197c7aa3eaf36\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":31,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"__TwigTemplate_37a46ea4d9b62bbc387970fb078c64144acaaa98fe957acd82e197c7aa3eaf36\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/twig/twig/lib/Twig/Template.php\",\"line\":375,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"__TwigTemplate_37a46ea4d9b62bbc387970fb078c64144acaaa98fe957acd82e197c7aa3eaf36\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/twig/twig/lib/Twig/Environment.php\",\"line\":289,\"class\":\"Twig_Template\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/web/View.php\",\"line\":305,\"class\":\"Twig_Environment\",\"method\":\"render\",\"args\":\"\\\"_entry\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/web/View.php\",\"line\":352,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderTemplate\",\"args\":\"\\\"_entry\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/web/Controller.php\",\"line\":128,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderPageTemplate\",\"args\":\"\\\"_entry\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/controllers/TemplatesController.php\",\"line\":78,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"renderTemplate\",\"args\":\"\\\"_entry\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":null,\"line\":null,\"class\":\"craft\\\\controllers\\\\TemplatesController\",\"method\":\"actionRender\",\"args\":\"\\\"_entry\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":null,\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/yiisoft/yii2/base/InlineAction.php\",\"line\":57,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"[craft\\\\controllers\\\\TemplatesController, \\\"actionRender\\\"], [\\\"_entry\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"yii\\\\base\\\\InlineAction\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/yiisoft/yii2/base/Controller.php\",\"line\":157,\"class\":\"yii\\\\base\\\\InlineAction\",\"method\":\"runWithParams\",\"args\":\"[\\\"template\\\" => \\\"_entry\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/web/Controller.php\",\"line\":76,\"class\":\"yii\\\\base\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"_entry\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/yiisoft/yii2/base/Module.php\",\"line\":528,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"_entry\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/web/Application.php\",\"line\":274,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"_entry\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/yiisoft/yii2/web/Application.php\",\"line\":103,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"_entry\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/craftcms/cms/src/web/Application.php\",\"line\":263,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/vendor/yiisoft/yii2/base/Application.php\",\"line\":386,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/hendrik/Documents/Github/Projects/drissy/web/index.php\",\"line\":42,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"run\",\"args\":null},{\"objectClass\":null,\"file\":\"/Users/hendrik/.composer/vendor/laravel/valet/server.php\",\"line\":147,\"class\":null,\"method\":\"require\",\"args\":\"\\\"/Users/hendrik/Documents/Github/Projects/drissy/web/index.php\\\"\"}]','2018-05-17 13:07:29','2018-05-17 13:07:29','01617ae9-94bd-4226-98e6-ef5e9e2ccb99'),(3337,'ElementQuery::getIterator()','/Users/hendrik/Documents/Github/Projects/wfw/templates/_matrix.twig:7','2018-06-07 14:17:39','/Users/hendrik/Documents/Github/Projects/wfw/templates/_matrix.twig',7,'Looping through element queries directly has been deprecated. Use the all() function to fetch the query results before looping over them.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/elements/db/ElementQuery.php\",\"line\":405,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"ElementQuery::getIterator()\\\", \\\"Looping through element queries directly has been deprecated. Us...\\\"\"},{\"objectClass\":\"craft\\\\elements\\\\db\\\\MatrixBlockQuery\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/storage/runtime/compiled_templates/07/075762a08bca734cd04c145d5fff2f3942078b0e9fd3064cbc630b04ded645f6.php\",\"line\":44,\"class\":\"craft\\\\elements\\\\db\\\\ElementQuery\",\"method\":\"getIterator\",\"args\":null},{\"objectClass\":\"__TwigTemplate_bc6257e8d699df6f66127da72083ab02df28185df8af8af5f4cf6ea4dbdfe6d6\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Template.php\",\"line\":390,\"class\":\"__TwigTemplate_bc6257e8d699df6f66127da72083ab02df28185df8af8af5f4cf6ea4dbdfe6d6\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_bc6257e8d699df6f66127da72083ab02df28185df8af8af5f4cf6ea4dbdfe6d6\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":49,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_bc6257e8d699df6f66127da72083ab02df28185df8af8af5f4cf6ea4dbdfe6d6\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Template.php\",\"line\":367,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_bc6257e8d699df6f66127da72083ab02df28185df8af8af5f4cf6ea4dbdfe6d6\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":31,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_bc6257e8d699df6f66127da72083ab02df28185df8af8af5f4cf6ea4dbdfe6d6\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/storage/runtime/compiled_templates/f0/f0a2436df2df52db05a3ad61c514edeb9f87117f20558ce766c3455679e0ed49.php\",\"line\":49,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...]\"},{\"objectClass\":\"__TwigTemplate_a8f77e8e7fa88ed8ca37f42132a2ecec97271c089f7875d3b760a814360ad77b\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Template.php\",\"line\":189,\"class\":\"__TwigTemplate_a8f77e8e7fa88ed8ca37f42132a2ecec97271c089f7875d3b760a814360ad77b\",\"method\":\"block_itemContent\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"itemContent\\\" => [__TwigTemplate_a8f77e8e7fa88ed8ca37f42132a2ecec97271c089f7875d3b760a814360ad77b, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_b2d5d830addd3928d6eea80deb8cb2b436035be25ed45860d8bd399250069c8e\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/storage/runtime/compiled_templates/a4/a492cc9257726d9f982e5ed4544cd83bb8e207392c171a4d4682a59037a3521a.php\",\"line\":24,\"class\":\"Twig_Template\",\"method\":\"displayBlock\",\"args\":\"\\\"itemContent\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"itemContent\\\" => [__TwigTemplate_a8f77e8e7fa88ed8ca37f42132a2ecec97271c089f7875d3b760a814360ad77b, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_b2d5d830addd3928d6eea80deb8cb2b436035be25ed45860d8bd399250069c8e\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Template.php\",\"line\":390,\"class\":\"__TwigTemplate_b2d5d830addd3928d6eea80deb8cb2b436035be25ed45860d8bd399250069c8e\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"itemContent\\\" => [__TwigTemplate_a8f77e8e7fa88ed8ca37f42132a2ecec97271c089f7875d3b760a814360ad77b, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_b2d5d830addd3928d6eea80deb8cb2b436035be25ed45860d8bd399250069c8e\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":49,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"itemContent\\\" => [__TwigTemplate_a8f77e8e7fa88ed8ca37f42132a2ecec97271c089f7875d3b760a814360ad77b, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_b2d5d830addd3928d6eea80deb8cb2b436035be25ed45860d8bd399250069c8e\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Template.php\",\"line\":367,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"itemContent\\\" => [__TwigTemplate_a8f77e8e7fa88ed8ca37f42132a2ecec97271c089f7875d3b760a814360ad77b, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_b2d5d830addd3928d6eea80deb8cb2b436035be25ed45860d8bd399250069c8e\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":31,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"itemContent\\\" => [__TwigTemplate_a8f77e8e7fa88ed8ca37f42132a2ecec97271c089f7875d3b760a814360ad77b, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_b2d5d830addd3928d6eea80deb8cb2b436035be25ed45860d8bd399250069c8e\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/storage/runtime/compiled_templates/f0/f0a2436df2df52db05a3ad61c514edeb9f87117f20558ce766c3455679e0ed49.php\",\"line\":28,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"itemContent\\\" => [__TwigTemplate_a8f77e8e7fa88ed8ca37f42132a2ecec97271c089f7875d3b760a814360ad77b, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_a8f77e8e7fa88ed8ca37f42132a2ecec97271c089f7875d3b760a814360ad77b\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Template.php\",\"line\":390,\"class\":\"__TwigTemplate_a8f77e8e7fa88ed8ca37f42132a2ecec97271c089f7875d3b760a814360ad77b\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"itemContent\\\" => [__TwigTemplate_a8f77e8e7fa88ed8ca37f42132a2ecec97271c089f7875d3b760a814360ad77b, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_a8f77e8e7fa88ed8ca37f42132a2ecec97271c089f7875d3b760a814360ad77b\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":49,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"itemContent\\\" => [__TwigTemplate_a8f77e8e7fa88ed8ca37f42132a2ecec97271c089f7875d3b760a814360ad77b, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_a8f77e8e7fa88ed8ca37f42132a2ecec97271c089f7875d3b760a814360ad77b\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Template.php\",\"line\":367,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"itemContent\\\" => [__TwigTemplate_a8f77e8e7fa88ed8ca37f42132a2ecec97271c089f7875d3b760a814360ad77b, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_a8f77e8e7fa88ed8ca37f42132a2ecec97271c089f7875d3b760a814360ad77b\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":31,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_a8f77e8e7fa88ed8ca37f42132a2ecec97271c089f7875d3b760a814360ad77b\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/storage/runtime/compiled_templates/4c/4c5f2bf48ce15af05cd9b501d76df9f35f26d9489486520cf993e9050701c80c.php\",\"line\":31,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...]\"},{\"objectClass\":\"__TwigTemplate_6f49207bf13c1ee59e171d0faa714acfdfd92f5d172b31106d39d4a4cafcfa37\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Template.php\",\"line\":390,\"class\":\"__TwigTemplate_6f49207bf13c1ee59e171d0faa714acfdfd92f5d172b31106d39d4a4cafcfa37\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_6f49207bf13c1ee59e171d0faa714acfdfd92f5d172b31106d39d4a4cafcfa37\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":49,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_6f49207bf13c1ee59e171d0faa714acfdfd92f5d172b31106d39d4a4cafcfa37\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Template.php\",\"line\":367,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_6f49207bf13c1ee59e171d0faa714acfdfd92f5d172b31106d39d4a4cafcfa37\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":31,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_6f49207bf13c1ee59e171d0faa714acfdfd92f5d172b31106d39d4a4cafcfa37\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/storage/runtime/compiled_templates/ef/ef01e09fffb6bac76239202d1dc99a31bc06ab0da5c2d36f58ce50c60e70da53.php\",\"line\":179,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...]\"},{\"objectClass\":\"__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Template.php\",\"line\":189,\"class\":\"__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09\",\"method\":\"block_content\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/storage/runtime/compiled_templates/8f/8fddc6b6a2658dc0b1fbde156cfd1bb9011a1526f8c3ea754445da667c773638.php\",\"line\":319,\"class\":\"Twig_Template\",\"method\":\"displayBlock\",\"args\":\"\\\"content\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Template.php\",\"line\":189,\"class\":\"__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b\",\"method\":\"block_body\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/storage/runtime/compiled_templates/8f/8fddc6b6a2658dc0b1fbde156cfd1bb9011a1526f8c3ea754445da667c773638.php\",\"line\":274,\"class\":\"Twig_Template\",\"method\":\"displayBlock\",\"args\":\"\\\"body\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Template.php\",\"line\":390,\"class\":\"__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":49,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Template.php\",\"line\":367,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":31,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"_inline_css\\\" => [__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09, \\\"block__inline_css\\\"], \\\"header\\\" => [__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09, \\\"block_header\\\"], \\\"content\\\" => [__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09, \\\"block_content\\\"], \\\"footer\\\" => [__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09, \\\"block_footer\\\"]]\"},{\"objectClass\":\"__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/storage/runtime/compiled_templates/ef/ef01e09fffb6bac76239202d1dc99a31bc06ab0da5c2d36f58ce50c60e70da53.php\",\"line\":53,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"_inline_css\\\" => [__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09, \\\"block__inline_css\\\"], \\\"header\\\" => [__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09, \\\"block_header\\\"], \\\"content\\\" => [__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09, \\\"block_content\\\"], \\\"footer\\\" => [__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09, \\\"block_footer\\\"]]\"},{\"objectClass\":\"__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Template.php\",\"line\":390,\"class\":\"__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"_inline_css\\\" => [__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09, \\\"block__inline_css\\\"], \\\"header\\\" => [__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09, \\\"block_header\\\"], \\\"content\\\" => [__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09, \\\"block_content\\\"], \\\"footer\\\" => [__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09, \\\"block_footer\\\"]]\"},{\"objectClass\":\"__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":49,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"_inline_css\\\" => [__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09, \\\"block__inline_css\\\"], \\\"header\\\" => [__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09, \\\"block_header\\\"], \\\"content\\\" => [__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09, \\\"block_content\\\"], \\\"footer\\\" => [__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09, \\\"block_footer\\\"]]\"},{\"objectClass\":\"__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Template.php\",\"line\":367,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"_inline_css\\\" => [__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09, \\\"block__inline_css\\\"], \\\"header\\\" => [__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09, \\\"block_header\\\"], \\\"content\\\" => [__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09, \\\"block_content\\\"], \\\"footer\\\" => [__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09, \\\"block_footer\\\"]]\"},{\"objectClass\":\"__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":31,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Template.php\",\"line\":375,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"__TwigTemplate_b5543efec96efb737a4da60f8aa2c8c967bdc9896c86fa6db33217faab535e09\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Environment.php\",\"line\":289,\"class\":\"Twig_Template\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/View.php\",\"line\":330,\"class\":\"Twig_Environment\",\"method\":\"render\",\"args\":\"\\\"index\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/View.php\",\"line\":377,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderTemplate\",\"args\":\"\\\"index\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/Controller.php\",\"line\":155,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderPageTemplate\",\"args\":\"\\\"index\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/controllers/TemplatesController.php\",\"line\":78,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"renderTemplate\",\"args\":\"\\\"index\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":null,\"line\":null,\"class\":\"craft\\\\controllers\\\\TemplatesController\",\"method\":\"actionRender\",\"args\":\"\\\"index\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":null,\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/yiisoft/yii2/base/InlineAction.php\",\"line\":57,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"[craft\\\\controllers\\\\TemplatesController, \\\"actionRender\\\"], [\\\"index\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"yii\\\\base\\\\InlineAction\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/yiisoft/yii2/base/Controller.php\",\"line\":157,\"class\":\"yii\\\\base\\\\InlineAction\",\"method\":\"runWithParams\",\"args\":\"[\\\"template\\\" => \\\"index\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/Controller.php\",\"line\":103,\"class\":\"yii\\\\base\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"index\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/yiisoft/yii2/base/Module.php\",\"line\":528,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"index\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/Application.php\",\"line\":273,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"index\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/yiisoft/yii2/web/Application.php\",\"line\":103,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"index\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/Application.php\",\"line\":262,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/yiisoft/yii2/base/Application.php\",\"line\":386,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/web/index.php\",\"line\":42,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"run\",\"args\":null},{\"objectClass\":null,\"file\":\"/Users/hendrik/.composer/vendor/laravel/valet/server.php\",\"line\":147,\"class\":null,\"method\":\"require\",\"args\":\"\\\"/Users/hendrik/Documents/Github/Projects/wfw/web/index.php\\\"\"}]','2018-06-07 14:17:39','2018-06-07 14:17:39','c760c3a3-d23d-4e63-bece-25f59f2e10a7'),(3338,'ElementQuery::getIterator()','/Users/hendrik/Documents/Github/Projects/wfw/templates/entry/news/default.twig:6','2018-06-07 14:17:37','/Users/hendrik/Documents/Github/Projects/wfw/templates/entry/news/default.twig',6,'Looping through element queries directly has been deprecated. Use the all() function to fetch the query results before looping over them.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/elements/db/ElementQuery.php\",\"line\":405,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"ElementQuery::getIterator()\\\", \\\"Looping through element queries directly has been deprecated. Us...\\\"\"},{\"objectClass\":\"craft\\\\elements\\\\db\\\\TagQuery\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/storage/runtime/compiled_templates/eb/ebb72e3f298c33a91299b2dde827288d75efe0db9ced54268e294a0fae66fa68.php\",\"line\":43,\"class\":\"craft\\\\elements\\\\db\\\\ElementQuery\",\"method\":\"getIterator\",\"args\":null},{\"objectClass\":\"__TwigTemplate_699e70b3d3241e2e77325a1ad5ed6b335005d6bf6c03c4e6da775aaf2c928f01\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Template.php\",\"line\":189,\"class\":\"__TwigTemplate_699e70b3d3241e2e77325a1ad5ed6b335005d6bf6c03c4e6da775aaf2c928f01\",\"method\":\"block_itemContent\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_1c5b920f78e1713af4de9119c3001de0f0daf412ac9ccbd59c95958a503d9dab, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_1c5b920f78e1713af4de9119c3001de0f0daf412ac9ccbd59c95958a503d9dab\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/storage/runtime/compiled_templates/c4/c466f3e99ef7b913582a1310a7f06851da8d86bbb93320f7dd5985997ae85ca6.php\",\"line\":94,\"class\":\"Twig_Template\",\"method\":\"displayBlock\",\"args\":\"\\\"itemContent\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_1c5b920f78e1713af4de9119c3001de0f0daf412ac9ccbd59c95958a503d9dab, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_1c5b920f78e1713af4de9119c3001de0f0daf412ac9ccbd59c95958a503d9dab\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Template.php\",\"line\":189,\"class\":\"__TwigTemplate_1c5b920f78e1713af4de9119c3001de0f0daf412ac9ccbd59c95958a503d9dab\",\"method\":\"block_content\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_1c5b920f78e1713af4de9119c3001de0f0daf412ac9ccbd59c95958a503d9dab, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/storage/runtime/compiled_templates/8f/8fddc6b6a2658dc0b1fbde156cfd1bb9011a1526f8c3ea754445da667c773638.php\",\"line\":319,\"class\":\"Twig_Template\",\"method\":\"displayBlock\",\"args\":\"\\\"content\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_1c5b920f78e1713af4de9119c3001de0f0daf412ac9ccbd59c95958a503d9dab, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Template.php\",\"line\":189,\"class\":\"__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b\",\"method\":\"block_body\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_1c5b920f78e1713af4de9119c3001de0f0daf412ac9ccbd59c95958a503d9dab, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/storage/runtime/compiled_templates/8f/8fddc6b6a2658dc0b1fbde156cfd1bb9011a1526f8c3ea754445da667c773638.php\",\"line\":274,\"class\":\"Twig_Template\",\"method\":\"displayBlock\",\"args\":\"\\\"body\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_1c5b920f78e1713af4de9119c3001de0f0daf412ac9ccbd59c95958a503d9dab, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Template.php\",\"line\":390,\"class\":\"__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_1c5b920f78e1713af4de9119c3001de0f0daf412ac9ccbd59c95958a503d9dab, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":49,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_1c5b920f78e1713af4de9119c3001de0f0daf412ac9ccbd59c95958a503d9dab, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Template.php\",\"line\":367,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"metadata\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_metadata\\\"], \\\"_inline_css\\\" => [__TwigTemplate_1c5b920f78e1713af4de9119c3001de0f0daf412ac9ccbd59c95958a503d9dab, \\\"block__inline_css\\\"], \\\"head\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_head\\\"], \\\"body\\\" => [__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b, \\\"block_body\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":31,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"_inline_css\\\" => [__TwigTemplate_1c5b920f78e1713af4de9119c3001de0f0daf412ac9ccbd59c95958a503d9dab, \\\"block__inline_css\\\"], \\\"content\\\" => [__TwigTemplate_1c5b920f78e1713af4de9119c3001de0f0daf412ac9ccbd59c95958a503d9dab, \\\"block_content\\\"], \\\"itemContent\\\" => [__TwigTemplate_699e70b3d3241e2e77325a1ad5ed6b335005d6bf6c03c4e6da775aaf2c928f01, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_6f18756052623268df9aff7606763aa05975835df71ab97dabb35d84ce36032b\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/storage/runtime/compiled_templates/c4/c466f3e99ef7b913582a1310a7f06851da8d86bbb93320f7dd5985997ae85ca6.php\",\"line\":30,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"_inline_css\\\" => [__TwigTemplate_1c5b920f78e1713af4de9119c3001de0f0daf412ac9ccbd59c95958a503d9dab, \\\"block__inline_css\\\"], \\\"content\\\" => [__TwigTemplate_1c5b920f78e1713af4de9119c3001de0f0daf412ac9ccbd59c95958a503d9dab, \\\"block_content\\\"], \\\"itemContent\\\" => [__TwigTemplate_699e70b3d3241e2e77325a1ad5ed6b335005d6bf6c03c4e6da775aaf2c928f01, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_1c5b920f78e1713af4de9119c3001de0f0daf412ac9ccbd59c95958a503d9dab\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Template.php\",\"line\":390,\"class\":\"__TwigTemplate_1c5b920f78e1713af4de9119c3001de0f0daf412ac9ccbd59c95958a503d9dab\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"_inline_css\\\" => [__TwigTemplate_1c5b920f78e1713af4de9119c3001de0f0daf412ac9ccbd59c95958a503d9dab, \\\"block__inline_css\\\"], \\\"content\\\" => [__TwigTemplate_1c5b920f78e1713af4de9119c3001de0f0daf412ac9ccbd59c95958a503d9dab, \\\"block_content\\\"], \\\"itemContent\\\" => [__TwigTemplate_699e70b3d3241e2e77325a1ad5ed6b335005d6bf6c03c4e6da775aaf2c928f01, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_1c5b920f78e1713af4de9119c3001de0f0daf412ac9ccbd59c95958a503d9dab\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":49,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"_inline_css\\\" => [__TwigTemplate_1c5b920f78e1713af4de9119c3001de0f0daf412ac9ccbd59c95958a503d9dab, \\\"block__inline_css\\\"], \\\"content\\\" => [__TwigTemplate_1c5b920f78e1713af4de9119c3001de0f0daf412ac9ccbd59c95958a503d9dab, \\\"block_content\\\"], \\\"itemContent\\\" => [__TwigTemplate_699e70b3d3241e2e77325a1ad5ed6b335005d6bf6c03c4e6da775aaf2c928f01, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_1c5b920f78e1713af4de9119c3001de0f0daf412ac9ccbd59c95958a503d9dab\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Template.php\",\"line\":367,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"_inline_css\\\" => [__TwigTemplate_1c5b920f78e1713af4de9119c3001de0f0daf412ac9ccbd59c95958a503d9dab, \\\"block__inline_css\\\"], \\\"content\\\" => [__TwigTemplate_1c5b920f78e1713af4de9119c3001de0f0daf412ac9ccbd59c95958a503d9dab, \\\"block_content\\\"], \\\"itemContent\\\" => [__TwigTemplate_699e70b3d3241e2e77325a1ad5ed6b335005d6bf6c03c4e6da775aaf2c928f01, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_1c5b920f78e1713af4de9119c3001de0f0daf412ac9ccbd59c95958a503d9dab\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":31,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"itemContent\\\" => [__TwigTemplate_699e70b3d3241e2e77325a1ad5ed6b335005d6bf6c03c4e6da775aaf2c928f01, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_1c5b920f78e1713af4de9119c3001de0f0daf412ac9ccbd59c95958a503d9dab\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/storage/runtime/compiled_templates/eb/ebb72e3f298c33a91299b2dde827288d75efe0db9ced54268e294a0fae66fa68.php\",\"line\":28,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"itemContent\\\" => [__TwigTemplate_699e70b3d3241e2e77325a1ad5ed6b335005d6bf6c03c4e6da775aaf2c928f01, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_699e70b3d3241e2e77325a1ad5ed6b335005d6bf6c03c4e6da775aaf2c928f01\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Template.php\",\"line\":390,\"class\":\"__TwigTemplate_699e70b3d3241e2e77325a1ad5ed6b335005d6bf6c03c4e6da775aaf2c928f01\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"itemContent\\\" => [__TwigTemplate_699e70b3d3241e2e77325a1ad5ed6b335005d6bf6c03c4e6da775aaf2c928f01, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_699e70b3d3241e2e77325a1ad5ed6b335005d6bf6c03c4e6da775aaf2c928f01\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":49,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"itemContent\\\" => [__TwigTemplate_699e70b3d3241e2e77325a1ad5ed6b335005d6bf6c03c4e6da775aaf2c928f01, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_699e70b3d3241e2e77325a1ad5ed6b335005d6bf6c03c4e6da775aaf2c928f01\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Template.php\",\"line\":367,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"itemContent\\\" => [__TwigTemplate_699e70b3d3241e2e77325a1ad5ed6b335005d6bf6c03c4e6da775aaf2c928f01, \\\"block_itemContent\\\"]]\"},{\"objectClass\":\"__TwigTemplate_699e70b3d3241e2e77325a1ad5ed6b335005d6bf6c03c4e6da775aaf2c928f01\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":31,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_699e70b3d3241e2e77325a1ad5ed6b335005d6bf6c03c4e6da775aaf2c928f01\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/storage/runtime/compiled_templates/4d/4db408137de304f7d2c025d457dbd0598fe6e4643ce52683dd8c19595f106774.php\",\"line\":32,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...]\"},{\"objectClass\":\"__TwigTemplate_2f452648b6ea9a9c0dd926fdf8758f5c1fbe3627ef5b47837056e648f595f8af\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Template.php\",\"line\":390,\"class\":\"__TwigTemplate_2f452648b6ea9a9c0dd926fdf8758f5c1fbe3627ef5b47837056e648f595f8af\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_2f452648b6ea9a9c0dd926fdf8758f5c1fbe3627ef5b47837056e648f595f8af\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":49,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_2f452648b6ea9a9c0dd926fdf8758f5c1fbe3627ef5b47837056e648f595f8af\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Template.php\",\"line\":367,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_2f452648b6ea9a9c0dd926fdf8758f5c1fbe3627ef5b47837056e648f595f8af\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":31,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"__TwigTemplate_2f452648b6ea9a9c0dd926fdf8758f5c1fbe3627ef5b47837056e648f595f8af\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Template.php\",\"line\":375,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"__TwigTemplate_2f452648b6ea9a9c0dd926fdf8758f5c1fbe3627ef5b47837056e648f595f8af\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/twig/twig/lib/Twig/Environment.php\",\"line\":289,\"class\":\"Twig_Template\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/View.php\",\"line\":330,\"class\":\"Twig_Environment\",\"method\":\"render\",\"args\":\"\\\"_entry\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/View.php\",\"line\":377,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderTemplate\",\"args\":\"\\\"_entry\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/Controller.php\",\"line\":155,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderPageTemplate\",\"args\":\"\\\"_entry\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/controllers/TemplatesController.php\",\"line\":78,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"renderTemplate\",\"args\":\"\\\"_entry\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":null,\"line\":null,\"class\":\"craft\\\\controllers\\\\TemplatesController\",\"method\":\"actionRender\",\"args\":\"\\\"_entry\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":null,\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/yiisoft/yii2/base/InlineAction.php\",\"line\":57,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"[craft\\\\controllers\\\\TemplatesController, \\\"actionRender\\\"], [\\\"_entry\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"yii\\\\base\\\\InlineAction\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/yiisoft/yii2/base/Controller.php\",\"line\":157,\"class\":\"yii\\\\base\\\\InlineAction\",\"method\":\"runWithParams\",\"args\":\"[\\\"template\\\" => \\\"_entry\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/Controller.php\",\"line\":103,\"class\":\"yii\\\\base\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"_entry\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/yiisoft/yii2/base/Module.php\",\"line\":528,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"_entry\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/Application.php\",\"line\":273,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"_entry\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/yiisoft/yii2/web/Application.php\",\"line\":103,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"_entry\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/craftcms/cms/src/web/Application.php\",\"line\":262,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/vendor/yiisoft/yii2/base/Application.php\",\"line\":386,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/hendrik/Documents/Github/Projects/wfw/web/index.php\",\"line\":42,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"run\",\"args\":null},{\"objectClass\":null,\"file\":\"/Users/hendrik/.composer/vendor/laravel/valet/server.php\",\"line\":147,\"class\":null,\"method\":\"require\",\"args\":\"\\\"/Users/hendrik/Documents/Github/Projects/wfw/web/index.php\\\"\"}]','2018-06-07 14:17:37','2018-06-07 14:17:37','f004851e-1cca-49d2-aa57-7fd3a6cb5f95');
/*!40000 ALTER TABLE `deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elementindexsettings`
--

LOCK TABLES `elementindexsettings` WRITE;
/*!40000 ALTER TABLE `elementindexsettings` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elementindexsettings` VALUES (1,'craft\\elements\\Entry','{\"sources\":{\"section:8\":{\"tableAttributes\":{\"1\":\"postDate\",\"2\":\"link\",\"3\":\"_childme_addChild\"}},\"section:16\":{\"tableAttributes\":{\"1\":\"postDate\",\"2\":\"expiryDate\",\"3\":\"author\",\"4\":\"link\",\"5\":\"_childme_addChild\"}}}}','2018-06-07 13:07:49','2018-06-07 13:07:49','c0253826-d335-4342-b6ef-1cefccc9901f');
/*!40000 ALTER TABLE `elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements`
--

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements` VALUES (1,NULL,'craft\\elements\\User',1,0,'2018-04-30 15:34:51','2018-06-02 11:49:31','c2c327d7-1d14-444c-9feb-223f6b479232'),(2,2,'craft\\elements\\Entry',1,0,'2018-05-02 13:44:02','2018-06-06 14:34:54','3e82961a-c8a1-442d-a0af-30eaed2d3309'),(10,10,'craft\\elements\\Tag',1,0,'2018-05-03 11:01:36','2018-05-03 11:01:36','4af14f8a-63c3-4d27-9cc1-bb2f48b064c0'),(24,10,'craft\\elements\\Tag',1,0,'2018-05-03 18:28:29','2018-05-03 18:28:29','680ae242-0fcb-4bff-8c4f-c02c9f83f0be'),(49,NULL,'craft\\elements\\MatrixBlock',1,0,'2018-05-04 18:38:52','2018-05-04 18:38:52','aa472de6-0cef-49b0-bb54-b75e52231a85'),(50,NULL,'craft\\elements\\MatrixBlock',1,0,'2018-05-04 18:39:00','2018-05-04 18:39:00','a5cba8f2-8047-46fd-82e4-a588183fcc91'),(51,NULL,'craft\\elements\\MatrixBlock',1,0,'2018-05-04 18:39:08','2018-05-04 18:39:08','d072e691-c762-437c-ae63-8bf6bc809729'),(52,NULL,'craft\\elements\\MatrixBlock',1,0,'2018-05-04 18:39:16','2018-05-04 18:39:16','c29fc490-381c-4567-b277-65fa4946de1a'),(53,NULL,'craft\\elements\\MatrixBlock',1,0,'2018-05-04 18:39:23','2018-05-04 18:39:23','f0092775-3365-4534-a86a-0076b9c18dec'),(54,NULL,'craft\\elements\\MatrixBlock',1,0,'2018-05-04 18:39:30','2018-05-04 18:39:30','8868e861-1090-462a-aade-94629d5f91d6'),(55,10,'craft\\elements\\Tag',1,0,'2018-05-05 10:11:13','2018-05-05 10:11:13','f36b849b-7630-4a4f-a021-95eda31ef3a5'),(56,10,'craft\\elements\\Tag',1,0,'2018-05-05 11:46:06','2018-05-05 11:46:06','1a1bed3f-2613-43a1-b086-8fd60ec744fb'),(58,19,'craft\\elements\\GlobalSet',1,0,'2018-05-05 14:54:42','2018-05-17 13:02:28','7e7ab4b6-3b63-4cd1-af4b-b11389d75e7d'),(59,20,'craft\\elements\\GlobalSet',1,0,'2018-05-05 14:55:05','2018-05-05 14:55:05','c79e9a6a-d2ef-4463-b596-10f04fda5cfb'),(60,21,'craft\\elements\\GlobalSet',1,0,'2018-05-05 14:55:25','2018-05-05 14:55:25','27306160-d4ac-4f57-bbac-4c7301674a7e'),(61,22,'craft\\elements\\GlobalSet',1,0,'2018-05-05 14:55:43','2018-05-17 13:03:01','fc300dc0-d283-4410-9478-b416cf88714b'),(62,23,'craft\\elements\\GlobalSet',1,0,'2018-05-05 14:56:01','2018-05-17 13:03:05','67c1db8f-bfbf-4fd1-a8ad-0050a55716e3'),(63,24,'craft\\elements\\GlobalSet',1,0,'2018-05-05 14:56:15','2018-05-05 14:56:15','0dd50a36-eed5-4674-93ea-1c6e6e0431aa'),(64,17,'craft\\elements\\MatrixBlock',1,0,'2018-05-05 14:59:34','2018-05-17 13:03:01','ef2338f0-c325-49f2-a6b1-0cddcc6b2999'),(67,17,'craft\\elements\\MatrixBlock',1,0,'2018-05-05 14:59:34','2018-05-17 13:03:01','4cdb18cc-d780-4ab3-8b7c-47d902eccfa1'),(68,13,'craft\\elements\\MatrixBlock',1,0,'2018-05-05 15:14:21','2018-05-17 13:02:28','6b8028eb-c870-4766-bbe3-1db671d6573a'),(74,10,'craft\\elements\\Tag',1,0,'2018-05-09 13:35:06','2018-05-09 13:35:06','8896ba8f-1ca9-4d1e-9e38-6fcada0cfa57'),(77,10,'craft\\elements\\Tag',1,0,'2018-05-09 13:39:06','2018-05-09 13:39:06','ab3bb779-276f-4209-96be-27453a752075'),(82,10,'craft\\elements\\Tag',1,0,'2018-05-09 13:41:14','2018-05-09 13:41:14','5b71c97b-c4d6-49a6-89ae-d02422b80a8b'),(83,10,'craft\\elements\\Tag',1,0,'2018-05-09 13:41:21','2018-05-09 13:41:21','06161023-06f1-451f-9cdb-53f128db9c3b'),(92,NULL,'craft\\elements\\MatrixBlock',1,0,'2018-05-14 14:31:07','2018-05-17 13:01:58','af0a4941-a6f4-445b-831b-25d44a243883'),(93,NULL,'craft\\elements\\MatrixBlock',1,0,'2018-05-14 14:31:38','2018-05-17 13:01:31','ecef848d-e9cb-46bf-aefd-6d67ce37f3ec'),(96,5,'craft\\elements\\Asset',1,0,'2018-06-06 13:51:32','2018-06-07 13:58:02','931c7a8e-db51-4fe2-b7a7-5350ed6d90bc'),(107,31,'craft\\elements\\Entry',1,0,'2018-06-07 08:12:35','2018-06-07 13:13:16','09f2f7bb-a3cc-4ec8-9c19-981ba51fad17'),(108,31,'craft\\elements\\Entry',1,0,'2018-06-07 08:12:47','2018-06-07 13:13:16','8582b301-555a-4fc5-9e5b-dbf4075a7afd'),(114,31,'craft\\elements\\Entry',1,0,'2018-06-07 08:19:45','2018-06-07 13:13:16','505e141f-77b6-4477-aab5-e86f53952c52'),(115,31,'craft\\elements\\Entry',1,0,'2018-06-07 08:20:00','2018-06-07 13:13:16','51a248ba-53fb-4304-86dc-1f555d170c6c'),(116,31,'craft\\elements\\Entry',1,0,'2018-06-07 08:20:11','2018-06-07 13:13:16','b82f5dc2-9480-43ce-a976-3a1480e92227'),(117,31,'craft\\elements\\Entry',1,0,'2018-06-07 08:20:20','2018-06-07 13:13:16','f34004a7-8c8a-424f-8cc2-f67d16b2211c'),(118,31,'craft\\elements\\Entry',1,0,'2018-06-07 08:20:30','2018-06-07 13:13:16','64257576-4055-46ac-ad04-578c68260299'),(119,31,'craft\\elements\\Entry',1,0,'2018-06-07 08:20:44','2018-06-07 13:13:16','12ea31e4-2024-4ac8-9ae2-e13aed68ca7c'),(120,31,'craft\\elements\\Entry',1,0,'2018-06-07 08:20:54','2018-06-07 13:13:16','a53940c0-d700-4503-963f-dddca0343e9c'),(129,NULL,'craft\\elements\\Entry',1,0,'2018-06-07 10:37:10','2018-06-07 10:40:48','5e0e3095-a2cd-4c2d-852d-b18e8140da2c'),(133,NULL,'craft\\elements\\Entry',1,0,'2018-06-07 10:38:04','2018-06-07 10:40:48','b8b6c14c-9e67-4d31-9324-ab426e7827d0'),(147,31,'craft\\elements\\Entry',1,0,'2018-06-07 12:55:54','2018-06-07 13:13:16','c65c4694-9f0b-40b1-954b-3b4d9826e583'),(148,31,'craft\\elements\\Entry',1,0,'2018-06-07 12:59:44','2018-06-07 13:13:16','80477f8c-6b52-440c-921e-1f7586f12c5d'),(149,31,'craft\\elements\\Entry',1,0,'2018-06-07 12:59:56','2018-06-07 13:13:16','5232a9d5-8497-4d0d-ba10-56b7e910de52'),(151,31,'craft\\elements\\Entry',1,0,'2018-06-07 13:00:29','2018-06-07 13:13:16','4498ecaa-39df-473b-8548-703fc8e3cc3b'),(152,31,'craft\\elements\\Entry',1,0,'2018-06-07 13:00:52','2018-06-07 13:13:16','20e3aab5-699e-410f-95ec-f007474c5aca'),(153,31,'craft\\elements\\Entry',1,0,'2018-06-07 13:03:04','2018-06-07 13:13:16','961fc0f9-8c95-4107-bc37-862eefd23c44'),(154,31,'craft\\elements\\Entry',1,0,'2018-06-07 13:03:47','2018-06-07 13:13:16','1e2f0c05-fae1-40a9-9701-096570176ea7'),(155,31,'craft\\elements\\Entry',1,0,'2018-06-07 13:04:07','2018-06-07 13:13:16','d5d520c2-6ff2-4b24-8d76-a74c6268ea01'),(158,31,'craft\\elements\\Entry',1,0,'2018-06-07 13:09:59','2018-06-07 13:13:16','573415e9-c3f8-4b1d-adc9-b6de46c44cb3'),(159,31,'craft\\elements\\Entry',1,0,'2018-06-07 13:10:25','2018-06-07 13:13:16','c6c9e4cc-ace4-46d5-bf40-1f05fdc5273b'),(160,31,'craft\\elements\\Entry',1,0,'2018-06-07 13:14:04','2018-06-07 13:14:04','d37189ee-e40a-4f44-b36c-cd30d746d3b2'),(161,31,'craft\\elements\\Entry',1,0,'2018-06-07 13:14:16','2018-06-07 13:14:16','b8344a00-9711-4023-889a-27fb7ac0a6dc'),(162,31,'craft\\elements\\Entry',1,0,'2018-06-07 13:14:44','2018-06-07 13:14:44','38d0ff28-eac6-42c8-8e35-7a0753f1b6b9'),(163,31,'craft\\elements\\Entry',1,0,'2018-06-07 13:14:51','2018-06-07 13:14:51','868c6c68-4b70-4946-b5bb-242e40688a51'),(164,31,'craft\\elements\\Entry',1,0,'2018-06-07 13:15:03','2018-06-07 13:15:03','009a22d6-2193-4818-ac1b-4434e4d3e53c'),(166,49,'craft\\elements\\Category',1,0,'2018-06-07 13:25:45','2018-06-07 13:25:45','731d06a1-cf53-4b07-a1ec-1ff52984d293'),(167,49,'craft\\elements\\Category',1,0,'2018-06-07 13:25:51','2018-06-07 13:25:51','b5268585-1356-4657-90ca-aba42328e58c'),(168,49,'craft\\elements\\Category',1,0,'2018-06-07 13:26:06','2018-06-07 13:26:06','ca29fa75-f567-4aee-967c-13424d56eb17'),(169,49,'craft\\elements\\Category',1,0,'2018-06-07 13:26:13','2018-06-07 13:26:13','a80809ba-2604-41dd-87fe-94870c03109d'),(170,49,'craft\\elements\\Category',1,0,'2018-06-07 13:26:17','2018-06-07 13:26:17','03c314c8-e8e9-434f-9622-148f84a8fdd9'),(172,49,'craft\\elements\\Category',1,0,'2018-06-07 13:27:13','2018-06-07 13:27:13','b13285db-9b8c-4314-91a3-0d86cabf0611'),(174,31,'craft\\elements\\Entry',1,0,'2018-06-07 13:36:21','2018-06-07 13:36:21','922a3e6e-fc1b-4d6e-9518-1f4024f3975f'),(183,45,'craft\\elements\\Entry',1,0,'2018-06-07 13:52:55','2018-06-07 13:52:55','e2153b16-e139-4994-8f6e-709354013dc6'),(184,45,'craft\\elements\\Entry',1,0,'2018-06-07 13:53:10','2018-06-07 13:53:10','7546e510-13a6-44d9-8d62-b6e8a09566fd'),(185,45,'craft\\elements\\Entry',1,0,'2018-06-07 13:53:17','2018-06-07 13:53:17','a08aef53-0dc0-42bc-a61a-95f8d175f616'),(187,45,'craft\\elements\\Entry',1,0,'2018-06-07 13:53:41','2018-06-07 13:53:41','89af7d80-f0e5-4526-b947-954de7593c1b'),(188,45,'craft\\elements\\Entry',1,0,'2018-06-07 13:53:47','2018-06-07 13:53:47','7362fe64-8971-44da-8e37-43215299c66e'),(189,45,'craft\\elements\\Entry',1,0,'2018-06-07 13:53:53','2018-06-07 13:53:53','0f4046b5-494f-484c-9d68-c87de5eea202'),(190,43,'craft\\elements\\Entry',1,0,'2018-06-07 13:54:10','2018-06-07 13:54:10','7bb37294-1b70-42c0-bee6-3fa5cec5cbd4'),(191,43,'craft\\elements\\Entry',1,0,'2018-06-07 13:54:15','2018-06-07 13:54:15','eee487b0-98a2-4549-919a-afe389172347'),(192,43,'craft\\elements\\Entry',1,0,'2018-06-07 13:54:18','2018-06-07 13:54:18','fac9766d-f4eb-45bd-92a0-1bca6c6ef217'),(193,43,'craft\\elements\\Entry',1,0,'2018-06-07 13:54:21','2018-06-07 13:54:21','ec0c62b1-c574-4a80-97fa-2ddef3d87fbd'),(194,43,'craft\\elements\\Entry',1,0,'2018-06-07 13:54:25','2018-06-07 13:54:25','58dd542b-3c17-4b92-99c7-75c12dfcbbfb'),(195,43,'craft\\elements\\Entry',1,0,'2018-06-07 13:54:29','2018-06-07 13:54:29','a6d0c041-bc89-43ee-836c-f4f39f4e9d93'),(196,44,'craft\\elements\\Entry',1,0,'2018-06-07 13:54:42','2018-06-07 13:54:42','75ad9a22-5fa6-4a76-a203-8d17839bbffe'),(197,44,'craft\\elements\\Entry',1,0,'2018-06-07 13:54:46','2018-06-07 13:54:46','3fb11cc7-5732-4fec-a3fd-79c9119d99e1'),(198,44,'craft\\elements\\Entry',1,0,'2018-06-07 13:54:49','2018-06-07 13:54:49','f702eb6c-15f7-4215-8ad9-d516c4cbdf1b'),(199,44,'craft\\elements\\Entry',1,0,'2018-06-07 13:54:53','2018-06-07 13:54:53','4a421e41-2c4b-4dce-a426-ad7bbc59cf80'),(200,44,'craft\\elements\\Entry',1,0,'2018-06-07 13:55:00','2018-06-07 13:55:00','8366d784-360a-4e22-9682-6d72959f0759'),(201,44,'craft\\elements\\Entry',1,0,'2018-06-07 13:55:05','2018-06-07 13:55:05','8b436114-a701-41f5-ba52-dd44f1fdf9c2'),(202,27,'craft\\elements\\Entry',1,0,'2018-06-07 13:55:27','2018-06-07 13:55:52','75a5fc6b-8ee5-452f-ade7-50c3946eac4f'),(203,27,'craft\\elements\\Entry',1,0,'2018-06-07 13:55:56','2018-06-07 13:55:56','f9d394e9-0b60-418a-9803-a51a730a915b'),(204,27,'craft\\elements\\Entry',1,0,'2018-06-07 13:55:59','2018-06-07 13:55:59','877c0a4e-8df3-43f4-a826-6b5f02323373'),(205,27,'craft\\elements\\Entry',1,0,'2018-06-07 13:56:03','2018-06-07 13:56:03','69592a9c-6279-4169-87a5-eb6b14b8f95a'),(206,27,'craft\\elements\\Entry',1,0,'2018-06-07 13:56:07','2018-06-07 13:56:07','4dc71506-c3da-4741-9023-0c477eac769b'),(207,27,'craft\\elements\\Entry',1,0,'2018-06-07 13:56:12','2018-06-07 13:56:12','5b4a40a0-ff8e-4be8-8f95-8162e993b186'),(208,48,'craft\\elements\\Entry',1,0,'2018-06-07 13:56:32','2018-06-07 13:56:32','e9a94987-b63b-426e-a092-fbb1c1ee93fd'),(209,48,'craft\\elements\\Entry',1,0,'2018-06-07 13:56:36','2018-06-07 13:56:36','0f1ff384-2bae-4208-ad05-51ab7f3192ae'),(210,48,'craft\\elements\\Entry',1,0,'2018-06-07 13:56:39','2018-06-07 13:56:39','d6f16ec1-3eff-476f-b731-1e879637478e'),(211,48,'craft\\elements\\Entry',1,0,'2018-06-07 13:56:42','2018-06-07 13:56:42','0856c2a6-5744-46d3-ac01-fd40a243fc97'),(212,48,'craft\\elements\\Entry',1,0,'2018-06-07 13:56:46','2018-06-07 13:56:46','76339e35-29bf-4e4b-bd9d-ff7f51b00327'),(213,48,'craft\\elements\\Entry',1,0,'2018-06-07 13:56:49','2018-06-07 13:56:49','0dc73074-f648-4a82-9d8d-54c1031864db'),(214,47,'craft\\elements\\Entry',1,0,'2018-06-07 13:57:10','2018-06-07 13:57:10','9832bfce-c37b-4d22-a18c-d3e61ebd2b7a'),(215,47,'craft\\elements\\Entry',1,0,'2018-06-07 13:57:14','2018-06-07 13:57:14','f3b0adb1-6366-46c4-91a1-aeac94bb6301'),(216,47,'craft\\elements\\Entry',1,0,'2018-06-07 13:57:17','2018-06-07 13:57:17','11a7e9a6-f6ab-4225-95f8-cd084a961299'),(217,47,'craft\\elements\\Entry',1,0,'2018-06-07 13:57:20','2018-06-07 13:57:20','5b8832a2-ca93-4ad2-b056-4dea8b5a7bea'),(218,47,'craft\\elements\\Entry',1,0,'2018-06-07 13:57:24','2018-06-07 13:57:24','a70a4092-93a7-4264-9896-7476d014da1b'),(219,47,'craft\\elements\\Entry',1,0,'2018-06-07 13:57:28','2018-06-07 13:57:28','30ab7761-10a6-4664-9425-0ac5b706df27');
/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements_sites`
--

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements_sites` VALUES (1,1,1,NULL,NULL,1,'2018-04-30 15:34:51','2018-06-02 11:49:31','e6dc4c34-570f-4aeb-be99-b86c0852551b'),(2,2,1,'homepage','__home__',1,'2018-05-02 13:44:02','2018-06-06 14:34:54','0750e19d-7597-4738-9e4a-953e4c50ed8e'),(10,10,1,'alban',NULL,1,'2018-05-03 11:01:36','2018-05-03 11:01:36','3c7c20fa-9a39-4af4-b66d-2b1be482c809'),(24,24,1,'wes-hicks',NULL,1,'2018-05-03 18:28:29','2018-05-03 18:28:29','4112137e-89e9-4b0d-8986-472beea85a25'),(49,49,1,NULL,NULL,1,'2018-05-04 18:38:52','2018-05-04 18:38:52','03b59824-9100-476e-9942-b13d12e31d5b'),(50,50,1,NULL,NULL,1,'2018-05-04 18:39:00','2018-05-04 18:39:00','38887ee6-130c-4d0f-87d7-7f5fc31adaa5'),(51,51,1,NULL,NULL,1,'2018-05-04 18:39:08','2018-05-04 18:39:08','aaa65250-7a3e-4c5c-9e7e-74c3b0defd26'),(52,52,1,NULL,NULL,1,'2018-05-04 18:39:16','2018-05-04 18:39:16','c099d09f-b125-4c65-8b2a-4f713acd3285'),(53,53,1,NULL,NULL,1,'2018-05-04 18:39:23','2018-05-04 18:39:23','7f37f38b-119b-47e2-aadd-98ac8c0467f1'),(54,54,1,NULL,NULL,1,'2018-05-04 18:39:30','2018-05-04 18:39:30','a7af1af2-748d-481e-a9de-af444dc048a8'),(55,55,1,'commercial',NULL,1,'2018-05-05 10:11:13','2018-05-05 10:11:13','e9ed38a4-29c3-4d2c-9512-8b32eb8b2380'),(56,56,1,'crack',NULL,1,'2018-05-05 11:46:06','2018-05-05 11:46:06','5fff93bd-c553-4a0a-958d-03177f223aae'),(58,58,1,NULL,NULL,1,'2018-05-05 14:54:42','2018-05-17 13:02:28','6a26f0f7-b839-4239-9dc4-4253d0c26c0d'),(59,59,1,NULL,NULL,1,'2018-05-05 14:55:05','2018-05-05 14:55:05','684a3312-1fe4-460d-ab07-4a05f3462682'),(60,60,1,NULL,NULL,1,'2018-05-05 14:55:25','2018-05-05 14:55:25','bb163444-617d-4cc9-8308-8b810ccbd2cd'),(61,61,1,NULL,NULL,1,'2018-05-05 14:55:43','2018-05-17 13:03:01','4e46a723-36fe-4bb1-bbcf-57f54c6f0ae4'),(62,62,1,NULL,NULL,1,'2018-05-05 14:56:01','2018-05-17 13:03:05','150a0643-f8ec-4311-b299-8a5a0c94c762'),(63,63,1,NULL,NULL,1,'2018-05-05 14:56:15','2018-05-05 14:56:15','c1ccb4ef-24ee-48ed-a7b0-00c85758c097'),(64,64,1,NULL,NULL,1,'2018-05-05 14:59:34','2018-05-17 13:03:01','790f5213-9fcd-46f2-af2f-77cdccf145ea'),(67,67,1,NULL,NULL,1,'2018-05-05 14:59:34','2018-05-17 13:03:01','7675707f-b75f-4ca6-bc99-4e445810a77b'),(68,68,1,NULL,NULL,1,'2018-05-05 15:14:21','2018-05-17 13:02:28','b1e2aa15-557c-4b14-936f-374589283d9e'),(74,74,1,'crime',NULL,1,'2018-05-09 13:35:06','2018-05-09 13:35:06','9d6336dc-34bb-4cf4-b44d-3ca74d9b5c79'),(77,77,1,'drama',NULL,1,'2018-05-09 13:39:06','2018-05-09 13:39:06','00c6d930-2df2-460f-a478-78ba64b06e23'),(82,82,1,'trash',NULL,1,'2018-05-09 13:41:14','2018-05-09 13:41:14','00c6c99e-c38b-4758-b9da-831342e51a41'),(83,83,1,'gamble',NULL,1,'2018-05-09 13:41:21','2018-05-09 13:41:21','bb4a3b53-5cd1-4627-bade-a56db007f178'),(92,92,1,NULL,NULL,1,'2018-05-14 14:31:07','2018-05-17 13:01:58','96f7c313-8e1c-4ee5-9622-5298ca84a0c9'),(93,93,1,NULL,NULL,1,'2018-05-14 14:31:38','2018-05-17 13:01:31','e3a2a900-646d-4598-8ee5-907712691679'),(96,96,1,NULL,NULL,1,'2018-06-06 13:51:32','2018-06-07 13:58:02','262cf54e-2099-4d7c-aba7-3352d2dd845d'),(107,107,1,'news','news',1,'2018-06-07 08:12:35','2018-06-07 13:13:16','02f08d96-2c53-40d3-84a9-151a3de6476b'),(108,108,1,'shop','shop',1,'2018-06-07 08:12:47','2018-06-07 13:13:16','42b25950-9281-4f9e-8923-ce86bffa1720'),(114,114,1,'mitmachen','mitmachen',1,'2018-06-07 08:19:45','2018-06-07 13:36:02','d9cef590-873a-4143-b775-0b6ce60abf58'),(115,115,1,'spenden','mitmachen/spenden',1,'2018-06-07 08:20:00','2018-06-07 13:13:16','7156482e-b36c-4c3c-bdb9-dfa6bb512550'),(116,116,1,'gönnerclub','mitmachen/gönnerclub',1,'2018-06-07 08:20:11','2018-06-07 13:13:16','64c0d20e-1686-4055-b6b2-1b8b1f3e57d0'),(117,117,1,'gastropartner','mitmachen/gastropartner',1,'2018-06-07 08:20:20','2018-06-07 13:13:16','c75f9c80-23ad-4060-ae56-22bcffce9a81'),(118,118,1,'büropartner','mitmachen/büropartner',1,'2018-06-07 08:20:30','2018-06-07 13:13:16','c48d6fd4-0985-4121-8072-2d62ca5e997a'),(119,119,1,'freunde','mitmachen/freunde',1,'2018-06-07 08:20:44','2018-06-07 13:13:16','3ce6e7fc-ec67-4b3c-b2be-45267b6ba91c'),(120,120,1,'crowdfunding','mitmachen/crowdfunding',1,'2018-06-07 08:20:54','2018-06-07 13:13:16','ddb5a459-59b1-4ae0-a33b-52cd7d7e4248'),(129,129,1,'aufklärung','aufklärung',1,'2018-06-07 10:37:10','2018-06-07 10:40:48','198f5da0-5ceb-4ccc-8c27-865b715aedbb'),(133,133,1,'gastro','gastro',1,'2018-06-07 10:38:04','2018-06-07 10:40:49','87a16f14-7e80-4d4d-833a-808858395546'),(147,147,1,'unsere-partner','unsere-partner',1,'2018-06-07 12:55:54','2018-06-07 13:36:06','3f2a0d08-f649-493a-b468-deb69e5fb1d6'),(148,148,1,'impressum','impressum',1,'2018-06-07 12:59:44','2018-06-07 13:13:16','d863b5bc-7b6f-4e5a-bf3f-0ea8d1faf00d'),(149,149,1,'datenschutz','datenschutz',1,'2018-06-07 12:59:56','2018-06-07 13:13:16','cf0ed887-540d-4b1d-8d2d-4c202aeb1a26'),(151,151,1,'über-uns','über-uns',1,'2018-06-07 13:00:29','2018-06-07 13:35:43','8e353912-f5ae-4d71-b12e-9fcd71004523'),(152,152,1,'wasserwissen','wasserwissen',1,'2018-06-07 13:00:52','2018-06-07 13:35:52','145e5386-6e72-41fe-9c01-09e8ea4870a7'),(153,153,1,'was-wir-machen','was-wir-machen',1,'2018-06-07 13:03:04','2018-06-07 13:35:31','19540e35-ddac-45b5-b27c-c8d50d3a8eb1'),(154,154,1,'schweiz','was-wir-machen/schweiz',1,'2018-06-07 13:03:47','2018-06-07 13:13:17','9ab80ac1-7ec3-480a-87cf-7b079d2c5095'),(155,155,1,'afrika','was-wir-machen/afrika',1,'2018-06-07 13:04:07','2018-06-07 13:13:17','4b8e220e-323b-4f80-8b3c-8b52a2875072'),(158,158,1,'tätigkeiten','was-wir-machen/schweiz/tätigkeiten',1,'2018-06-07 13:09:59','2018-06-07 13:13:17','77511517-f1a0-49f1-8c66-ce23518c2f26'),(159,159,1,'sensibilisierung','was-wir-machen/schweiz/tätigkeiten/sensibilisierung',1,'2018-06-07 13:10:25','2018-06-07 13:13:17','c31884b1-b89c-43d3-aee8-3e9ac0105b98'),(160,160,1,'aufklärung','was-wir-machen/schweiz/tätigkeiten/aufklärung',1,'2018-06-07 13:14:04','2018-06-07 13:14:05','ce010c83-548c-4d67-bdde-1b7f6dc6a043'),(161,161,1,'leitungswasser-fördern','was-wir-machen/schweiz/tätigkeiten/leitungswasser-fördern',1,'2018-06-07 13:14:16','2018-06-07 13:14:17','78940cd0-7322-471b-96e9-3dd025ed9352'),(162,162,1,'länder','was-wir-machen/afrika/länder',1,'2018-06-07 13:14:44','2018-06-07 13:14:44','48b8b9be-1996-488d-8c41-be3b64f3fbb5'),(163,163,1,'sambia','was-wir-machen/afrika/länder/sambia',1,'2018-06-07 13:14:51','2018-06-07 13:14:51','2d704f77-5408-478b-88c0-5ee1941822a6'),(164,164,1,'mosambique','was-wir-machen/afrika/länder/mosambique',1,'2018-06-07 13:15:03','2018-06-07 13:15:03','3929d350-12eb-43f0-86f2-49df66e684dd'),(166,166,1,'büro','projekttyp/büro',1,'2018-06-07 13:25:45','2018-06-07 13:25:47','dc1c6356-74ea-4b38-8332-0c2703ea86f9'),(167,167,1,'gastro','projekttyp/gastro',1,'2018-06-07 13:25:51','2018-06-07 13:25:52','94b51303-0c12-43d9-ba5a-b474daec7cd2'),(168,168,1,'weitere-projekte','projekttyp/weitere-projekte',1,'2018-06-07 13:26:06','2018-06-07 13:26:07','20242f16-e143-4d4e-97ec-c6603266a586'),(169,169,1,'infrastruktur','projekttyp/infrastruktur',1,'2018-06-07 13:26:13','2018-06-07 13:26:13','6fb44eaa-d660-4306-bae9-8f9dbf36d14f'),(170,170,1,'bildung','projekttyp/bildung',1,'2018-06-07 13:26:17','2018-06-07 13:26:18','d56f3ca0-c2be-4b17-b55f-285d4dee8161'),(172,172,1,'sanitation-hygiene','projekttyp/sanitation-hygiene',1,'2018-06-07 13:27:13','2018-06-07 13:27:14','e4e443da-59d8-4aa5-9367-3fd9a6563822'),(174,174,1,'spenden','spenden',1,'2018-06-07 13:36:21','2018-06-07 13:36:35','131b01af-8133-493e-9211-d32640a6c97b'),(183,183,1,'büro-partner-1','partner-buero/büro-partner-1',1,'2018-06-07 13:52:55','2018-06-07 13:52:55','5cca53a1-c093-4ba0-9f67-9be1154954a9'),(184,184,1,'büro-partner-2','partner-buero/büro-partner-2',1,'2018-06-07 13:53:10','2018-06-07 13:53:10','57855ff0-8abd-4470-bdeb-1d7a2cdffb20'),(185,185,1,'büro-partner-3','partner-buero/büro-partner-3',1,'2018-06-07 13:53:17','2018-06-07 13:53:17','295ab3d6-fda5-4721-8895-862df219baba'),(187,187,1,'büro-partner-4','partner-buero/büro-partner-4',1,'2018-06-07 13:53:41','2018-06-07 13:53:41','ca6a1811-7296-4eaa-a223-f6963502b717'),(188,188,1,'büro-partner-5','partner-buero/büro-partner-5',1,'2018-06-07 13:53:47','2018-06-07 13:53:47','1150998d-5623-40d3-9dee-80114b2ab656'),(189,189,1,'büro-partner-6','partner-buero/büro-partner-6',1,'2018-06-07 13:53:53','2018-06-07 13:53:53','f4bf355d-d76c-4fb5-b8d5-e87118423896'),(190,190,1,'gastro-partner-1','partner-gastro/gastro-partner-1',1,'2018-06-07 13:54:10','2018-06-07 13:54:10','e280bdd4-8e91-4eaf-af75-f8ebbc1f03d0'),(191,191,1,'gastro-partner-2','partner-gastro/gastro-partner-2',1,'2018-06-07 13:54:15','2018-06-07 13:54:15','463bbc52-2072-47fc-bbae-fc69e3254fcd'),(192,192,1,'gastro-partner-3','partner-gastro/gastro-partner-3',1,'2018-06-07 13:54:18','2018-06-07 13:54:18','9aeb0a1f-e7fe-4c3a-8dab-cddc44af3008'),(193,193,1,'gastro-partner-4','partner-gastro/gastro-partner-4',1,'2018-06-07 13:54:21','2018-06-07 13:54:21','d268e49f-d8ba-47e4-bcb1-b444e2ae1403'),(194,194,1,'gastro-partner-5','partner-gastro/gastro-partner-5',1,'2018-06-07 13:54:25','2018-06-07 13:54:25','285d97be-f38b-4310-b467-a01cc3b2dce1'),(195,195,1,'gastro-partner-6','partner-gastro/gastro-partner-6',1,'2018-06-07 13:54:29','2018-06-07 13:54:29','55746d55-4a79-481c-a25e-61da5cee39a7'),(196,196,1,'service-partner-1','partner-service/service-partner-1',1,'2018-06-07 13:54:42','2018-06-07 13:54:42','d2411488-22be-44c1-bcf5-69301b3f888b'),(197,197,1,'service-partner-2','partner-service/service-partner-2',1,'2018-06-07 13:54:46','2018-06-07 13:54:46','ff9729f6-2908-47c4-b4d4-3dc6b7806df3'),(198,198,1,'service-partner-3','partner-service/service-partner-3',1,'2018-06-07 13:54:49','2018-06-07 13:54:49','ba7ffe66-8451-4aeb-a498-134ef9648ed1'),(199,199,1,'service-partner-4','partner-service/service-partner-4',1,'2018-06-07 13:54:53','2018-06-07 13:54:53','bf34222d-ecde-4457-83e4-fcacf868f3b7'),(200,200,1,'service-partner-5','partner-service/service-partner-5',1,'2018-06-07 13:55:00','2018-06-07 13:55:00','0244ef8a-43d7-4060-a612-931b08a94bef'),(201,201,1,'service-partner-6','partner-service/service-partner-6',1,'2018-06-07 13:55:05','2018-06-07 13:55:05','1742e49e-fac9-44cb-9ff1-c34e2b3fd6bd'),(202,202,1,'news-artikel-1','news/2018/06/news-artikel-1',1,'2018-06-07 13:55:27','2018-06-07 13:55:52','d86080b2-de3d-4ba1-8bde-c956b441a7e0'),(203,203,1,'news-artikel-2','news/2018/06/news-artikel-2',1,'2018-06-07 13:55:56','2018-06-07 13:55:56','44484325-65d9-425e-9c00-3e6c4fa07baf'),(204,204,1,'news-artikel-3','news/2018/06/news-artikel-3',1,'2018-06-07 13:55:59','2018-06-07 13:55:59','18337f61-3a0f-4390-9b89-79cddebd449a'),(205,205,1,'news-artikel-4','news/2018/06/news-artikel-4',1,'2018-06-07 13:56:03','2018-06-07 13:56:03','e4b9eb0a-b0ed-47b4-a9b3-0225e4c3dda5'),(206,206,1,'news-artikel-5','news/2018/06/news-artikel-5',1,'2018-06-07 13:56:07','2018-06-07 13:56:07','92806848-fd9a-4914-a31f-9f057542f503'),(207,207,1,'news-artikel-6','news/2018/06/news-artikel-6',1,'2018-06-07 13:56:12','2018-06-07 13:56:12','d60f59d3-ce69-4b21-be56-a30ca0fb63af'),(208,208,1,'projekt-afrika-1','projekt-afrika-1',1,'2018-06-07 13:56:32','2018-06-07 13:56:32','80cb94d7-3779-448a-bd6c-6dad7d916e4b'),(209,209,1,'projekt-afrika-2','projekt-afrika-2',1,'2018-06-07 13:56:36','2018-06-07 13:56:36','ccce409f-9daf-4c31-9ef9-9d6b358e5c0b'),(210,210,1,'projekt-afrika-3','projekt-afrika-3',1,'2018-06-07 13:56:39','2018-06-07 13:56:39','eba6b4f0-4068-476d-bf0d-249cdc2afcf0'),(211,211,1,'projekt-afrika-4','projekt-afrika-4',1,'2018-06-07 13:56:42','2018-06-07 13:56:42','09185ecb-9512-4aaa-a6da-9bde2edc22e7'),(212,212,1,'projekt-afrika-5','projekt-afrika-5',1,'2018-06-07 13:56:46','2018-06-07 13:56:46','a4a2b3a5-ca8f-45e3-80e5-2d6dfddec7b6'),(213,213,1,'projekt-afrika-6','projekt-afrika-6',1,'2018-06-07 13:56:49','2018-06-07 13:56:49','07b0b822-666d-43ca-9101-18aa782cbb08'),(214,214,1,'projekt-schweiz-1','projekt-schweiz-1',1,'2018-06-07 13:57:10','2018-06-07 13:57:10','c2cb30d7-a165-4e85-b4b4-91e61dbd3cad'),(215,215,1,'projekt-schweiz-2','projekt-schweiz-2',1,'2018-06-07 13:57:14','2018-06-07 13:57:14','6a28208f-fc06-4a42-97d5-392017bbf5bb'),(216,216,1,'projekt-schweiz-3','projekt-schweiz-3',1,'2018-06-07 13:57:17','2018-06-07 13:57:17','231e3306-ab60-44c0-b218-d4bb7a52a088'),(217,217,1,'projekt-schweiz-4','projekt-schweiz-4',1,'2018-06-07 13:57:20','2018-06-07 13:57:20','bb8a5a5b-9858-4c1f-9ea4-f0874fb98019'),(218,218,1,'projekt-schweiz-5','projekt-schweiz-5',1,'2018-06-07 13:57:24','2018-06-07 13:57:24','58fc471b-28f7-46e4-9315-75831300f002'),(219,219,1,'projekt-schweiz-6','projekt-schweiz-6',1,'2018-06-07 13:57:28','2018-06-07 13:57:28','54d51314-8fa9-43c8-87a6-2c8160fecd1a');
/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entries`
--

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entries` VALUES (2,2,2,NULL,'2018-05-02 13:44:02',NULL,'2018-05-02 13:44:02','2018-06-06 14:34:54','22f3a55e-321d-460c-91ec-d7880db97383'),(107,8,10,1,'2018-06-07 08:12:35',NULL,'2018-06-07 08:12:35','2018-06-07 13:13:16','e1054de0-7a96-4e26-bdbd-3c5acdf73f65'),(108,8,10,1,'2018-06-07 08:12:47',NULL,'2018-06-07 08:12:47','2018-06-07 13:13:16','43e35877-fbd1-4b5f-b848-ad3cba0154d5'),(114,8,10,1,'2018-06-07 08:19:00',NULL,'2018-06-07 08:19:45','2018-06-07 13:13:16','44acfdc8-85e9-4bbd-bb6a-1927bebe39d6'),(115,8,10,1,'2018-06-07 08:20:00',NULL,'2018-06-07 08:20:01','2018-06-07 13:13:16','959bf821-5a9a-412c-906d-8f9679a39a20'),(116,8,10,1,'2018-06-07 08:20:11',NULL,'2018-06-07 08:20:11','2018-06-07 13:13:16','15254f88-7902-4cdd-9789-764f06dcced0'),(117,8,10,1,'2018-06-07 08:20:20',NULL,'2018-06-07 08:20:20','2018-06-07 13:13:16','b3b2c03e-ce25-4265-9a0d-a86f72f279f4'),(118,8,10,1,'2018-06-07 08:20:30',NULL,'2018-06-07 08:20:30','2018-06-07 13:13:16','e78cb694-1b2c-4677-bcf3-c8926a978abd'),(119,8,10,1,'2018-06-07 08:20:44',NULL,'2018-06-07 08:20:44','2018-06-07 13:13:16','0beb882e-aafe-40ba-b55d-3c6673cd87ed'),(120,8,10,1,'2018-06-07 08:20:54',NULL,'2018-06-07 08:20:54','2018-06-07 13:13:16','588b6004-a4a9-4ede-8553-964aa191a8fa'),(147,8,10,1,'2018-06-07 12:55:54',NULL,'2018-06-07 12:55:54','2018-06-07 13:13:16','4f0d694d-2731-430d-b8e9-a2b5f4818d39'),(148,8,10,1,'2018-06-07 12:59:44',NULL,'2018-06-07 12:59:44','2018-06-07 13:13:16','f07dc8fa-88a6-4c5a-bb0e-a2dd57aacb79'),(149,8,10,1,'2018-06-07 12:59:56',NULL,'2018-06-07 12:59:56','2018-06-07 13:13:16','c36b1c6b-2c56-46cb-ba87-d0f81178af06'),(151,8,10,1,'2018-06-07 13:00:29',NULL,'2018-06-07 13:00:29','2018-06-07 13:13:16','16636bc0-b927-486d-9b28-97f12cbcc91f'),(152,8,10,1,'2018-06-07 13:00:52',NULL,'2018-06-07 13:00:52','2018-06-07 13:13:16','205a7a2c-df0c-4214-a2a2-971b33602fe0'),(153,8,10,1,'2018-06-07 13:03:04',NULL,'2018-06-07 13:03:04','2018-06-07 13:13:16','30e6a7a8-ee9b-41d1-a7aa-a3855097b285'),(154,8,10,1,'2018-06-07 13:03:47',NULL,'2018-06-07 13:03:47','2018-06-07 13:13:16','9bf03975-2845-45c4-85ad-7ab574745332'),(155,8,10,1,'2018-06-07 13:04:07',NULL,'2018-06-07 13:04:07','2018-06-07 13:13:16','affa7b09-9331-4bfa-b4dd-c5b379e29778'),(158,8,10,1,'2018-06-07 13:09:59',NULL,'2018-06-07 13:09:59','2018-06-07 13:13:16','12040c79-5ce3-47b0-b1aa-ad0afbb2e0f4'),(159,8,10,1,'2018-06-07 13:10:25',NULL,'2018-06-07 13:10:25','2018-06-07 13:13:16','51e1eff6-f3c0-444a-a86e-6a594ce9ea1e'),(160,8,10,1,'2018-06-07 13:14:04',NULL,'2018-06-07 13:14:04','2018-06-07 13:14:04','d970d5b7-6ff4-4699-a6e4-793164d62612'),(161,8,10,1,'2018-06-07 13:14:16',NULL,'2018-06-07 13:14:16','2018-06-07 13:14:16','5ff0043e-fddb-42b9-80ef-b7c51fc8e486'),(162,8,10,1,'2018-06-07 13:14:44',NULL,'2018-06-07 13:14:44','2018-06-07 13:14:44','500da967-ec7a-4c92-be63-8c9e96647239'),(163,8,10,1,'2018-06-07 13:14:51',NULL,'2018-06-07 13:14:51','2018-06-07 13:14:51','ae11ce90-1592-4dea-af0b-22ceca8d178b'),(164,8,10,1,'2018-06-07 13:15:03',NULL,'2018-06-07 13:15:03','2018-06-07 13:15:03','a36b9d80-710e-4fc2-bf73-bf625ec98823'),(174,8,10,1,'2018-06-07 13:36:21',NULL,'2018-06-07 13:36:21','2018-06-07 13:36:21','4d512141-452f-419c-a41b-1223f0e7834a'),(183,15,22,1,'2018-06-07 13:52:55',NULL,'2018-06-07 13:52:55','2018-06-07 13:52:55','634d9002-a856-4b74-b9ef-42926b35a34e'),(184,15,22,1,'2018-06-07 13:53:10',NULL,'2018-06-07 13:53:10','2018-06-07 13:53:10','0c17fd28-eb13-4219-be83-79f0d7786dac'),(185,15,22,1,'2018-06-07 13:53:17',NULL,'2018-06-07 13:53:17','2018-06-07 13:53:17','8aa02157-fc7f-4d81-9428-7923d202af29'),(187,15,22,1,'2018-06-07 13:53:41',NULL,'2018-06-07 13:53:41','2018-06-07 13:53:41','1543d8c1-3a14-4a6a-9ecf-a6d857cd1c30'),(188,15,22,1,'2018-06-07 13:53:47',NULL,'2018-06-07 13:53:47','2018-06-07 13:53:47','9fbbc903-4f50-4487-a43e-88d85d6ee28b'),(189,15,22,1,'2018-06-07 13:53:53',NULL,'2018-06-07 13:53:53','2018-06-07 13:53:53','9b4c7596-56d8-4c76-adf6-386664e77c1b'),(190,13,20,1,'2018-06-07 13:54:10',NULL,'2018-06-07 13:54:10','2018-06-07 13:54:10','6d982f79-f2b1-4330-aaec-1c119bf17df8'),(191,13,20,1,'2018-06-07 13:54:15',NULL,'2018-06-07 13:54:15','2018-06-07 13:54:15','3730867f-e4c2-496e-a8df-09b176d11579'),(192,13,20,1,'2018-06-07 13:54:18',NULL,'2018-06-07 13:54:18','2018-06-07 13:54:18','76736adc-d672-4fa7-8acf-367c4e4d78df'),(193,13,20,1,'2018-06-07 13:54:21',NULL,'2018-06-07 13:54:21','2018-06-07 13:54:21','ca15e320-e2aa-4d72-a7dc-0855644fa7a7'),(194,13,20,1,'2018-06-07 13:54:25',NULL,'2018-06-07 13:54:25','2018-06-07 13:54:25','e48b1a55-2381-45f0-a7aa-db59c76be45a'),(195,13,20,1,'2018-06-07 13:54:29',NULL,'2018-06-07 13:54:29','2018-06-07 13:54:29','be8919ca-7bd9-4123-acb4-239d0ce22e77'),(196,14,21,1,'2018-06-07 13:54:42',NULL,'2018-06-07 13:54:42','2018-06-07 13:54:42','b9205437-6c53-4a58-a4c8-bcc55dcff7c1'),(197,14,21,1,'2018-06-07 13:54:46',NULL,'2018-06-07 13:54:46','2018-06-07 13:54:46','b1d9c39f-3846-4054-976e-2332ff198cec'),(198,14,21,1,'2018-06-07 13:54:49',NULL,'2018-06-07 13:54:49','2018-06-07 13:54:49','ad36baf4-0258-4100-827d-e2dd77be02d1'),(199,14,21,1,'2018-06-07 13:54:53',NULL,'2018-06-07 13:54:53','2018-06-07 13:54:53','2bfb0910-3b61-484f-9ae1-9cdba12d48a2'),(200,14,21,1,'2018-06-07 13:55:00',NULL,'2018-06-07 13:55:00','2018-06-07 13:55:00','75efbfa7-2f85-4ff0-8072-c21eaf9c305f'),(201,14,21,1,'2018-06-07 13:55:05',NULL,'2018-06-07 13:55:05','2018-06-07 13:55:05','807842dc-f659-42b7-826f-c3e30610685e'),(202,7,9,1,'2018-06-07 13:55:00',NULL,'2018-06-07 13:55:27','2018-06-07 13:55:52','2f70eb48-3af9-477e-bc90-99d1f98733dd'),(203,7,9,1,'2018-06-07 13:55:56',NULL,'2018-06-07 13:55:56','2018-06-07 13:55:56','e82663f1-a12d-43ac-9b34-bc4d252415f4'),(204,7,9,1,'2018-06-07 13:55:59',NULL,'2018-06-07 13:55:59','2018-06-07 13:55:59','d4e52cd3-8cf5-41a1-8fe5-49f10371aaf9'),(205,7,9,1,'2018-06-07 13:56:03',NULL,'2018-06-07 13:56:03','2018-06-07 13:56:03','0434e844-4357-428c-ba39-470e23a4639e'),(206,7,9,1,'2018-06-07 13:56:07',NULL,'2018-06-07 13:56:07','2018-06-07 13:56:07','21a20c02-13d9-4999-9b0e-e542a2fe35f2'),(207,7,9,1,'2018-06-07 13:56:12',NULL,'2018-06-07 13:56:12','2018-06-07 13:56:12','51c49fd3-9e33-4362-a2ea-1e94a1da961d'),(208,18,25,1,'2018-06-07 13:56:32',NULL,'2018-06-07 13:56:32','2018-06-07 13:56:32','8a52c094-3f75-4a1c-90c6-83238fce8531'),(209,18,25,1,'2018-06-07 13:56:36',NULL,'2018-06-07 13:56:36','2018-06-07 13:56:36','a24cc5c0-d7f2-4d3b-8ca2-342d6470de27'),(210,18,25,1,'2018-06-07 13:56:39',NULL,'2018-06-07 13:56:39','2018-06-07 13:56:39','87a04849-e97e-4ea6-9ee4-a547c01653a0'),(211,18,25,1,'2018-06-07 13:56:42',NULL,'2018-06-07 13:56:42','2018-06-07 13:56:42','16a1a9ce-5f73-47d3-bd5b-fa931406bdbf'),(212,18,25,1,'2018-06-07 13:56:46',NULL,'2018-06-07 13:56:46','2018-06-07 13:56:46','0ac7739c-ee8f-43f2-84e1-8f8655755f6d'),(213,18,25,1,'2018-06-07 13:56:49',NULL,'2018-06-07 13:56:49','2018-06-07 13:56:49','910d5a73-3c4b-4858-b2b8-2b7cc7ac80da'),(214,17,24,1,'2018-06-07 13:57:10',NULL,'2018-06-07 13:57:10','2018-06-07 13:57:10','f00fdaa9-311f-49c3-b58c-b5c3efc00e89'),(215,17,24,1,'2018-06-07 13:57:14',NULL,'2018-06-07 13:57:14','2018-06-07 13:57:14','155d0e38-48bc-421a-8832-73def1490a40'),(216,17,24,1,'2018-06-07 13:57:17',NULL,'2018-06-07 13:57:17','2018-06-07 13:57:17','f5bf8892-ef0b-4fe8-b954-d58beeced4c6'),(217,17,24,1,'2018-06-07 13:57:20',NULL,'2018-06-07 13:57:21','2018-06-07 13:57:21','b74e29cd-6329-44b2-9dee-70b74cb2b42b'),(218,17,24,1,'2018-06-07 13:57:24',NULL,'2018-06-07 13:57:24','2018-06-07 13:57:24','03a6849d-134e-4800-a7e0-6010be44421d'),(219,17,24,1,'2018-06-07 13:57:28',NULL,'2018-06-07 13:57:28','2018-06-07 13:57:28','75e21dfb-0b50-4f2b-b2c3-ca24cb27db31');
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
INSERT INTO `entrytypes` VALUES (2,2,2,'Home','home',1,'Title',NULL,1,'2018-05-02 13:44:01','2018-06-06 14:31:54','a3f178d7-ee1d-4173-bf3a-3d230419eaf9'),(9,7,27,'Default','default',1,'Title',NULL,1,'2018-06-05 21:37:22','2018-06-06 14:30:05','742f491a-f258-4335-8b63-b0fefec2ab16'),(10,8,31,'Default','default',1,'Title',NULL,1,'2018-06-06 14:32:06','2018-06-06 14:33:45','878485b9-a197-43b9-a415-3b92e572a88e'),(20,13,43,'Partner - Gastro','partnerGastro',1,'Title',NULL,1,'2018-06-07 10:23:33','2018-06-07 10:23:33','5a054d79-b434-4a04-b81d-6c54668f7a39'),(21,14,44,'Partner - Service','partnerService',1,'Title',NULL,1,'2018-06-07 10:24:42','2018-06-07 10:24:42','38e50dee-7a71-4dd3-9f2e-ca0ec9b97b93'),(22,15,45,'Partner - Büro','partnerBuero',1,'Title',NULL,1,'2018-06-07 10:25:12','2018-06-07 10:25:12','36828b3e-41a4-4b6f-abd9-9d6abd32d19a'),(24,17,47,'Default','default',1,'Title',NULL,1,'2018-06-07 13:12:51','2018-06-07 13:30:53','019524cc-c161-46e4-a19b-6ac0c3039d47'),(25,18,48,'Default','default',1,'Title',NULL,1,'2018-06-07 13:13:33','2018-06-07 13:22:00','3c8720de-a338-498c-9f4d-4dbc9c2746ee');
/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entryversions`
--

LOCK TABLES `entryversions` WRITE;
/*!40000 ALTER TABLE `entryversions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entryversions` VALUES (1,2,2,1,1,1,'Revision from May 3, 2018, 3:22:10 AM','{\"typeId\":\"2\",\"authorId\":null,\"title\":\"Homepage\",\"slug\":\"homepage\",\"postDate\":1525268642,\"expiryDate\":null,\"enabled\":\"1\",\"newParentId\":null,\"fields\":{\"3\":[]}}','2018-05-03 10:23:42','2018-05-03 10:23:42','183af983-4002-4cd6-9e54-b37a934543c6'),(2,2,2,1,1,2,'','{\"typeId\":\"2\",\"authorId\":null,\"title\":\"Homepage\",\"slug\":\"homepage\",\"postDate\":1525268642,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"3\":{\"4\":{\"type\":\"text\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"textContent\":\"<p>Lorem ipsum dolor amet stumptown vape blue bottle leggings. Tousled celiac sriracha, godard photo booth banh mi meh four loko pop-up drinking vinegar butcher art party before they sold out hell of. Ramps church-key schlitz, kombucha prism tumblr health goth intelligentsia readymade chillwave affogato butcher. Pork belly 90\'s vice tote bag truffaut helvetica PBR&amp;B direct trade readymade green juice pitchfork prism. Cloud bread poke irony neutra pop-up yuccie YOLO disrupt.</p><p>Crucifix taiyaki squid heirloom, prism farm-to-table meditation occupy everyday carry mustache aesthetic master cleanse. Kitsch craft beer 3 wolf moon tofu shoreditch. Literally wolf taiyaki selfies, freegan keffiyeh tumeric portland pickled vexillologist fam bicycle rights austin snackwave. Intelligentsia man bun food truck, knausgaard blue bottle messenger bag williamsburg tacos hexagon disrupt. Williamsburg subway tile roof party waistcoat.</p>\"}},\"5\":{\"type\":\"image\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"image\":[\"3\"],\"caption\":\"Braden Collum\",\"layout\":\"full\"}}}}}','2018-05-03 10:56:50','2018-05-03 10:56:50','103325f4-4bd0-4ce7-b832-3fd72ff09367'),(17,2,2,1,1,3,'','{\"typeId\":\"2\",\"authorId\":null,\"title\":\"Homepage\",\"slug\":\"homepage\",\"postDate\":1525268642,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"3\":{\"4\":{\"type\":\"text\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"textContent\":\"<p>Lorem ipsum dolor amet stumptown vape blue bottle leggings. Tousled celiac sriracha, godard photo booth banh mi meh four loko pop-up drinking vinegar butcher art party before they sold out hell of. Ramps church-key schlitz, kombucha prism tumblr health goth intelligentsia readymade chillwave affogato butcher. Pork belly 90\'s vice tote bag truffaut helvetica PBR&amp;B direct trade readymade green juice pitchfork prism. Cloud bread poke irony neutra pop-up yuccie YOLO disrupt.</p>\\n<p>Crucifix taiyaki squid heirloom, prism farm-to-table meditation occupy everyday carry mustache aesthetic master cleanse. Kitsch craft beer 3 wolf moon tofu shoreditch. Literally wolf taiyaki selfies, freegan keffiyeh tumeric portland pickled vexillologist fam bicycle rights austin snackwave. Intelligentsia man bun food truck, knausgaard blue bottle messenger bag williamsburg tacos hexagon disrupt. Williamsburg subway tile roof party waistcoat.</p>\\n\"}},\"5\":{\"type\":\"image\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"image\":[\"16\"],\"caption\":\"Image Caption\",\"layout\":\"full\"}}}}}','2018-05-03 18:31:45','2018-05-03 18:31:45','11c2af9f-544b-4710-a826-a836aded1c3f'),(97,2,2,1,1,4,'','{\"typeId\":\"2\",\"authorId\":null,\"title\":\"Homepage\",\"slug\":\"homepage\",\"postDate\":1525268642,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"3\":{\"4\":{\"type\":\"text\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"textContent\":\"<p><br /></p>\\n\"}}}}}','2018-05-17 13:01:45','2018-05-17 13:01:45','69409e72-1593-4160-8bc3-49d2a85591f8'),(99,2,2,1,1,5,'','{\"typeId\":\"2\",\"authorId\":null,\"title\":\"Homepage\",\"slug\":\"homepage\",\"postDate\":1525268642,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"3\":{\"4\":{\"type\":\"text\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"textContent\":\"<p><br /></p>\\n\"}}},\"50\":\"asfsafasfsdf\",\"51\":[],\"52\":\"<p>safasdfsdfsdfsdfsdfsdfsdfsdfsdfsdf</p>\\n\"}}','2018-06-04 09:30:57','2018-06-04 09:30:57','25bae1c7-da86-49ed-b60a-9249854ca372'),(108,2,2,1,1,6,'','{\"typeId\":\"2\",\"authorId\":null,\"title\":\"Home\",\"slug\":\"homepage\",\"postDate\":1525268642,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"3\":{\"4\":{\"type\":\"text\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"textContent\":\"<p><br /></p>\\n\"}}},\"50\":\"asfsafasfsdf\",\"51\":[],\"52\":\"<p>safasdfsdfsdfsdfsdfsdfsdfsdfsdfsdf</p>\\n\"}}','2018-06-06 14:34:54','2018-06-06 14:34:54','b78ba85e-fdf3-4cea-8c61-7d67924d42c9'),(115,107,8,1,1,1,'','{\"typeId\":\"10\",\"authorId\":\"1\",\"title\":\"News\",\"slug\":\"news\",\"postDate\":1528359155,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"51\":[],\"52\":\"<p><br /></p>\\n\"}}','2018-06-07 08:12:35','2018-06-07 08:12:35','0fcace19-1f6f-470b-b249-719978251e37'),(116,108,8,1,1,1,'','{\"typeId\":\"10\",\"authorId\":\"1\",\"title\":\"Shop\",\"slug\":\"shop\",\"postDate\":1528359167,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"51\":[],\"52\":\"<p><br /></p>\\n\"}}','2018-06-07 08:12:47','2018-06-07 08:12:47','9de7035d-44fc-4b17-a5a3-e2a4790813b8'),(123,114,8,1,1,1,'','{\"typeId\":\"10\",\"authorId\":\"1\",\"title\":\"Mitmachen\",\"slug\":\"mitmachen\",\"postDate\":1528359585,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"51\":[],\"52\":\"<p><br /></p>\\n\"}}','2018-06-07 08:19:45','2018-06-07 08:19:45','1db09508-9bfd-484f-8a83-637e43e8cf08'),(124,115,8,1,1,1,'','{\"typeId\":\"10\",\"authorId\":\"1\",\"title\":\"Spenden\",\"slug\":\"spenden\",\"postDate\":1528359600,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"51\":[],\"52\":\"<p><br /></p>\\n\"}}','2018-06-07 08:20:01','2018-06-07 08:20:01','8f8266c3-0c8c-4df4-8090-252617483dc9'),(125,116,8,1,1,1,'','{\"typeId\":\"10\",\"authorId\":\"1\",\"title\":\"Gönnerclub\",\"slug\":\"gönnerclub\",\"postDate\":1528359611,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"51\":[],\"52\":\"<p><br /></p>\\n\"}}','2018-06-07 08:20:11','2018-06-07 08:20:11','a4c4fff9-db2b-432e-8b70-2197f44f199e'),(126,117,8,1,1,1,'','{\"typeId\":\"10\",\"authorId\":\"1\",\"title\":\"Gastropartner\",\"slug\":\"gastropartner\",\"postDate\":1528359620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"51\":[],\"52\":\"<p><br /></p>\\n\"}}','2018-06-07 08:20:20','2018-06-07 08:20:20','48a93946-1a10-4d60-ad53-8de67a4c7ba1'),(127,118,8,1,1,1,'','{\"typeId\":\"10\",\"authorId\":\"1\",\"title\":\"Büropartner\",\"slug\":\"büropartner\",\"postDate\":1528359630,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"51\":[],\"52\":\"<p><br /></p>\\n\"}}','2018-06-07 08:20:30','2018-06-07 08:20:30','e5d90ce9-c3e3-4b85-83a4-2ea185823ec6'),(128,119,8,1,1,1,'','{\"typeId\":\"10\",\"authorId\":\"1\",\"title\":\"Freunde\",\"slug\":\"freunde\",\"postDate\":1528359644,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"51\":[],\"52\":\"<p><br /></p>\\n\"}}','2018-06-07 08:20:44','2018-06-07 08:20:44','5edcaf0d-ef9f-42bf-98f4-364263d0c209'),(129,120,8,1,1,1,'','{\"typeId\":\"10\",\"authorId\":\"1\",\"title\":\"Crowdfunding\",\"slug\":\"crowdfunding\",\"postDate\":1528359654,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"51\":[],\"52\":\"<p><br /></p>\\n\"}}','2018-06-07 08:20:54','2018-06-07 08:20:54','29014966-2914-44d7-bd5c-1fdb1bfd84e6'),(159,147,8,1,1,1,'','{\"typeId\":\"10\",\"authorId\":\"1\",\"title\":\"Unsere Partner\",\"slug\":\"unsere-partner\",\"postDate\":1528376154,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"51\":[],\"52\":\"<p><br /></p>\\n\"}}','2018-06-07 12:55:54','2018-06-07 12:55:54','cc8f6d8c-1f25-4526-a8de-c242a49c2acc'),(161,114,8,1,1,2,'','{\"typeId\":\"10\",\"authorId\":\"1\",\"title\":\"Partner werden\",\"slug\":\"mitmachen\",\"postDate\":1528359540,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"51\":[],\"52\":\"<p><br /></p>\\n\"}}','2018-06-07 12:56:27','2018-06-07 12:56:27','aaae5b92-f939-4cfd-8aca-7ebde1e94159'),(162,148,8,1,1,1,'','{\"typeId\":\"10\",\"authorId\":\"1\",\"title\":\"Impressum\",\"slug\":\"impressum\",\"postDate\":1528376384,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"51\":[],\"52\":\"<p><br /></p>\\n\"}}','2018-06-07 12:59:44','2018-06-07 12:59:44','3d289696-4402-4c78-9cdd-f3e43c94cd3a'),(163,149,8,1,1,1,'','{\"typeId\":\"10\",\"authorId\":\"1\",\"title\":\"Datenschutz\",\"slug\":\"datenschutz\",\"postDate\":1528376396,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"51\":[],\"52\":\"<p><br /></p>\\n\"}}','2018-06-07 12:59:56','2018-06-07 12:59:56','40f00849-c959-47dd-9386-e866d3a98c07'),(165,151,8,1,1,1,'','{\"typeId\":\"10\",\"authorId\":\"1\",\"title\":\"Über Uns\",\"slug\":\"über-uns\",\"postDate\":1528376429,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"51\":[],\"52\":\"<p><br /></p>\\n\"}}','2018-06-07 13:00:29','2018-06-07 13:00:29','78d7229e-3c48-45f5-82d8-f34b0f7e3407'),(166,152,8,1,1,1,'','{\"typeId\":\"10\",\"authorId\":\"1\",\"title\":\"Wasserwissen\",\"slug\":\"wasserwissen\",\"postDate\":1528376452,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"51\":[],\"52\":\"<p><br /></p>\\n\"}}','2018-06-07 13:00:52','2018-06-07 13:00:52','12d60b56-1d5b-4e50-a2a2-a3e111151723'),(167,153,8,1,1,1,'','{\"typeId\":\"10\",\"authorId\":\"1\",\"title\":\"Was wir machen\",\"slug\":\"was-wir-machen\",\"postDate\":1528376584,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"51\":[],\"52\":\"<p><br /></p>\\n\"}}','2018-06-07 13:03:04','2018-06-07 13:03:04','5e4b9dd8-7a8e-404f-8cf3-bee215026d20'),(168,154,8,1,1,1,'','{\"typeId\":\"10\",\"authorId\":\"1\",\"title\":\"Schweiz\",\"slug\":\"schweiz\",\"postDate\":1528376627,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"153\",\"fields\":{\"51\":[],\"52\":\"<p><br /></p>\\n\"}}','2018-06-07 13:03:47','2018-06-07 13:03:47','c917c065-0935-4792-913b-6d343bd83340'),(169,155,8,1,1,1,'','{\"typeId\":\"10\",\"authorId\":\"1\",\"title\":\"Afrika\",\"slug\":\"afrika\",\"postDate\":1528376647,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"153\",\"fields\":{\"51\":[],\"52\":\"<p><br /></p>\\n\"}}','2018-06-07 13:04:07','2018-06-07 13:04:07','941df6ef-2c6a-4b0d-8022-b361c78357b5'),(172,158,8,1,1,1,'','{\"typeId\":\"10\",\"authorId\":\"1\",\"title\":\"Tätigkeiten\",\"slug\":\"tätigkeiten\",\"postDate\":1528376999,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"154\",\"fields\":{\"51\":[],\"52\":\"<p><br /></p>\\n\"}}','2018-06-07 13:09:59','2018-06-07 13:09:59','8dec180a-ee70-4b5f-8200-0df09e3a8e2e'),(173,159,8,1,1,1,'','{\"typeId\":\"10\",\"authorId\":\"1\",\"title\":\"Sensibilisierung\",\"slug\":\"sensibilisierung\",\"postDate\":1528377025,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"158\",\"fields\":{\"51\":[],\"52\":\"<p><br /></p>\\n\"}}','2018-06-07 13:10:25','2018-06-07 13:10:25','118a1107-7f42-4ae3-9a75-cabe1c23db46'),(174,160,8,1,1,1,'','{\"typeId\":\"10\",\"authorId\":\"1\",\"title\":\"Aufklärung\",\"slug\":\"aufklärung\",\"postDate\":1528377244,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"158\",\"fields\":{\"51\":[],\"52\":\"<p><br /></p>\\n\"}}','2018-06-07 13:14:04','2018-06-07 13:14:04','bd935bca-9083-4781-9822-5c3f223f62e3'),(175,161,8,1,1,1,'','{\"typeId\":\"10\",\"authorId\":\"1\",\"title\":\"Leitungswasser fördern\",\"slug\":\"leitungswasser-fördern\",\"postDate\":1528377256,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"158\",\"fields\":{\"51\":[],\"52\":\"<p><br /></p>\\n\"}}','2018-06-07 13:14:16','2018-06-07 13:14:16','ed368452-6f31-42da-9379-b2cce471a386'),(176,162,8,1,1,1,'','{\"typeId\":\"10\",\"authorId\":\"1\",\"title\":\"Länder\",\"slug\":\"länder\",\"postDate\":1528377284,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"155\",\"fields\":{\"51\":[],\"52\":\"<p><br /></p>\\n\"}}','2018-06-07 13:14:44','2018-06-07 13:14:44','5ceed5e8-64af-4d6c-b4d2-236c3ecadf88'),(177,163,8,1,1,1,'','{\"typeId\":\"10\",\"authorId\":\"1\",\"title\":\"Sambia\",\"slug\":\"sambia\",\"postDate\":1528377291,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"162\",\"fields\":{\"51\":[],\"52\":\"<p><br /></p>\\n\"}}','2018-06-07 13:14:51','2018-06-07 13:14:51','01f46ca8-0d1a-487a-bb47-50b1fe6270d6'),(178,164,8,1,1,1,'','{\"typeId\":\"10\",\"authorId\":\"1\",\"title\":\"Mosambique\",\"slug\":\"mosambique\",\"postDate\":1528377303,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"162\",\"fields\":{\"51\":[],\"52\":\"<p><br /></p>\\n\"}}','2018-06-07 13:15:03','2018-06-07 13:15:03','4ea6ae13-41a2-4623-a71e-64a268c45b6b'),(182,174,8,1,1,1,'','{\"typeId\":\"10\",\"authorId\":\"1\",\"title\":\"Spenden\",\"slug\":\"spenden\",\"postDate\":1528378581,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"51\":[],\"52\":\"<p><br /></p>\\n\"}}','2018-06-07 13:36:21','2018-06-07 13:36:21','c9c19dfa-ec3f-48f8-8964-64420f9c382a'),(191,183,15,1,1,1,'','{\"typeId\":\"22\",\"authorId\":\"1\",\"title\":\"Büro-Partner 1\",\"slug\":\"büro-partner-1\",\"postDate\":1528379575,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2018-06-07 13:52:56','2018-06-07 13:52:56','2abae350-3037-4941-98b6-033e5883d7e4'),(192,184,15,1,1,1,'','{\"typeId\":\"22\",\"authorId\":\"1\",\"title\":\"Büro-Partner 2\",\"slug\":\"büro-partner-2\",\"postDate\":1528379590,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2018-06-07 13:53:10','2018-06-07 13:53:10','dd79d715-97ce-4efb-9682-f8ad91bfe582'),(193,185,15,1,1,1,'','{\"typeId\":\"22\",\"authorId\":\"1\",\"title\":\"Büro-Partner 3\",\"slug\":\"büro-partner-3\",\"postDate\":1528379597,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2018-06-07 13:53:17','2018-06-07 13:53:17','e743dfc2-31a2-4f3d-a3c3-cd547cd41e1f'),(195,187,15,1,1,1,'','{\"typeId\":\"22\",\"authorId\":\"1\",\"title\":\"Büro-Partner 4\",\"slug\":\"büro-partner-4\",\"postDate\":1528379621,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2018-06-07 13:53:41','2018-06-07 13:53:41','11348849-45be-45bb-84b2-301fe366a492'),(196,188,15,1,1,1,'','{\"typeId\":\"22\",\"authorId\":\"1\",\"title\":\"Büro-Partner 5\",\"slug\":\"büro-partner-5\",\"postDate\":1528379627,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2018-06-07 13:53:47','2018-06-07 13:53:47','32205452-7338-4bad-b900-ef72aeb65c5d'),(197,189,15,1,1,1,'','{\"typeId\":\"22\",\"authorId\":\"1\",\"title\":\"Büro-Partner 6\",\"slug\":\"büro-partner-6\",\"postDate\":1528379633,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2018-06-07 13:53:53','2018-06-07 13:53:53','c02c8a11-300e-4ea8-836d-a06aad0e8327'),(198,190,13,1,1,1,'','{\"typeId\":\"20\",\"authorId\":\"1\",\"title\":\"Gastro-Partner 1\",\"slug\":\"gastro-partner-1\",\"postDate\":1528379650,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2018-06-07 13:54:10','2018-06-07 13:54:10','a0b1494a-bf89-4dcb-aed3-8b16b2e5a5c2'),(199,191,13,1,1,1,'','{\"typeId\":\"20\",\"authorId\":\"1\",\"title\":\"Gastro-Partner 2\",\"slug\":\"gastro-partner-2\",\"postDate\":1528379655,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2018-06-07 13:54:15','2018-06-07 13:54:15','8a4e3550-289d-4ce2-adb3-5e25c4964b3a'),(200,192,13,1,1,1,'','{\"typeId\":\"20\",\"authorId\":\"1\",\"title\":\"Gastro-Partner 3\",\"slug\":\"gastro-partner-3\",\"postDate\":1528379658,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2018-06-07 13:54:18','2018-06-07 13:54:18','6a7572fd-264d-4f45-9dd8-e6cf5fe6fea6'),(201,193,13,1,1,1,'','{\"typeId\":\"20\",\"authorId\":\"1\",\"title\":\"Gastro-Partner 4\",\"slug\":\"gastro-partner-4\",\"postDate\":1528379661,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2018-06-07 13:54:21','2018-06-07 13:54:21','c6ba1724-a0de-44c5-a6b2-90ab4decbcfa'),(202,194,13,1,1,1,'','{\"typeId\":\"20\",\"authorId\":\"1\",\"title\":\"Gastro-Partner 5\",\"slug\":\"gastro-partner-5\",\"postDate\":1528379665,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2018-06-07 13:54:25','2018-06-07 13:54:25','a5af7e53-4bc4-42d8-b433-23a50b163121'),(203,195,13,1,1,1,'','{\"typeId\":\"20\",\"authorId\":\"1\",\"title\":\"Gastro-Partner 6\",\"slug\":\"gastro-partner-6\",\"postDate\":1528379669,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2018-06-07 13:54:29','2018-06-07 13:54:29','1e058d2e-194b-4a31-8e90-253f3c91f7a4'),(204,196,14,1,1,1,'','{\"typeId\":\"21\",\"authorId\":\"1\",\"title\":\"Service-Partner 1\",\"slug\":\"service-partner-1\",\"postDate\":1528379682,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2018-06-07 13:54:42','2018-06-07 13:54:42','5f7c9e59-2128-45c5-bdc6-c317a875418b'),(205,197,14,1,1,1,'','{\"typeId\":\"21\",\"authorId\":\"1\",\"title\":\"Service-Partner 2\",\"slug\":\"service-partner-2\",\"postDate\":1528379686,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2018-06-07 13:54:46','2018-06-07 13:54:46','b39fdbeb-f143-4802-b01e-7357bd78010d'),(206,198,14,1,1,1,'','{\"typeId\":\"21\",\"authorId\":\"1\",\"title\":\"Service-Partner 3\",\"slug\":\"service-partner-3\",\"postDate\":1528379689,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2018-06-07 13:54:49','2018-06-07 13:54:49','d379d3e7-1720-4025-9837-94c19fd2e961'),(207,199,14,1,1,1,'','{\"typeId\":\"21\",\"authorId\":\"1\",\"title\":\"Service-Partner 4\",\"slug\":\"service-partner-4\",\"postDate\":1528379693,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2018-06-07 13:54:53','2018-06-07 13:54:53','19360b40-74ca-46e9-a1ae-055fd2997f44'),(208,200,14,1,1,1,'','{\"typeId\":\"21\",\"authorId\":\"1\",\"title\":\"Service-Partner 5\",\"slug\":\"service-partner-5\",\"postDate\":1528379700,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2018-06-07 13:55:00','2018-06-07 13:55:00','748b39e1-5a97-4ab1-b458-dc257bcec822'),(209,201,14,1,1,1,'','{\"typeId\":\"21\",\"authorId\":\"1\",\"title\":\"Service-Partner 6\",\"slug\":\"service-partner-6\",\"postDate\":1528379705,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2018-06-07 13:55:06','2018-06-07 13:55:06','3975708f-3947-40b3-90e1-aba9c27c84a4'),(210,202,7,1,1,1,'','{\"typeId\":\"9\",\"authorId\":\"1\",\"title\":\"News-Artikel 1\",\"slug\":\"news-artikel-1\",\"postDate\":1528379727,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"53\":[],\"51\":[],\"52\":\"<p><br /></p>\\n\",\"6\":[]}}','2018-06-07 13:55:27','2018-06-07 13:55:27','a61ccea4-b49b-44e8-b3f6-0ec97db8ff70'),(211,202,7,1,1,2,'','{\"typeId\":\"9\",\"authorId\":\"1\",\"title\":\"News-Artikel 1\",\"slug\":\"news-artikel-1\",\"postDate\":1528379700,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"53\":[],\"51\":[],\"52\":\"<p><br /></p>\\n\",\"6\":[]}}','2018-06-07 13:55:52','2018-06-07 13:55:52','ddf6b0e5-8d18-4062-a3ed-f595f2404ad5'),(212,203,7,1,1,1,'','{\"typeId\":\"9\",\"authorId\":\"1\",\"title\":\"News-Artikel 2\",\"slug\":\"news-artikel-2\",\"postDate\":1528379756,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"53\":[],\"51\":[],\"52\":\"<p><br /></p>\\n\",\"6\":[]}}','2018-06-07 13:55:56','2018-06-07 13:55:56','e6b86d3e-76f4-41a3-97f8-00274624713b'),(213,204,7,1,1,1,'','{\"typeId\":\"9\",\"authorId\":\"1\",\"title\":\"News-Artikel 3\",\"slug\":\"news-artikel-3\",\"postDate\":1528379759,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"53\":[],\"51\":[],\"52\":\"<p><br /></p>\\n\",\"6\":[]}}','2018-06-07 13:55:59','2018-06-07 13:55:59','02dfb666-3de3-4f8d-8c5b-28620b63ec52'),(214,205,7,1,1,1,'','{\"typeId\":\"9\",\"authorId\":\"1\",\"title\":\"News-Artikel 4\",\"slug\":\"news-artikel-4\",\"postDate\":1528379763,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"53\":[],\"51\":[],\"52\":\"<p><br /></p>\\n\",\"6\":[]}}','2018-06-07 13:56:03','2018-06-07 13:56:03','15178591-491a-4cb9-97bb-18e9f0c74535'),(215,206,7,1,1,1,'','{\"typeId\":\"9\",\"authorId\":\"1\",\"title\":\"News-Artikel 5\",\"slug\":\"news-artikel-5\",\"postDate\":1528379767,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"53\":[],\"51\":[],\"52\":\"<p><br /></p>\\n\",\"6\":[]}}','2018-06-07 13:56:07','2018-06-07 13:56:07','699b1698-1495-48ec-9986-f0f91c945ef0'),(216,207,7,1,1,1,'','{\"typeId\":\"9\",\"authorId\":\"1\",\"title\":\"News-Artikel 6\",\"slug\":\"news-artikel-6\",\"postDate\":1528379772,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"53\":[],\"51\":[],\"52\":\"<p><br /></p>\\n\",\"6\":[]}}','2018-06-07 13:56:12','2018-06-07 13:56:12','809ee0b0-ba9f-4605-bdb4-abf802ac40e1'),(217,208,18,1,1,1,'','{\"typeId\":\"25\",\"authorId\":\"1\",\"title\":\"Projekt-Afrika 1\",\"slug\":\"projekt-afrika-1\",\"postDate\":1528379792,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2018-06-07 13:56:32','2018-06-07 13:56:32','e66a71e6-f57e-4625-bc78-cd2d0e68cc8c'),(218,209,18,1,1,1,'','{\"typeId\":\"25\",\"authorId\":\"1\",\"title\":\"Projekt-Afrika 2\",\"slug\":\"projekt-afrika-2\",\"postDate\":1528379796,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2018-06-07 13:56:36','2018-06-07 13:56:36','3b04573b-8a8a-4429-84cd-8e06b2b583f8'),(219,210,18,1,1,1,'','{\"typeId\":\"25\",\"authorId\":\"1\",\"title\":\"Projekt-Afrika 3\",\"slug\":\"projekt-afrika-3\",\"postDate\":1528379799,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2018-06-07 13:56:39','2018-06-07 13:56:39','5072c544-493b-4055-9981-c06526dadd7a'),(220,211,18,1,1,1,'','{\"typeId\":\"25\",\"authorId\":\"1\",\"title\":\"Projekt-Afrika 4\",\"slug\":\"projekt-afrika-4\",\"postDate\":1528379802,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2018-06-07 13:56:42','2018-06-07 13:56:42','bcd115f5-4308-42fb-81cd-48a3b51daf1d'),(221,212,18,1,1,1,'','{\"typeId\":\"25\",\"authorId\":\"1\",\"title\":\"Projekt-Afrika 5\",\"slug\":\"projekt-afrika-5\",\"postDate\":1528379806,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2018-06-07 13:56:46','2018-06-07 13:56:46','76507b70-71af-4a35-b0ce-f6210af0c0c7'),(222,213,18,1,1,1,'','{\"typeId\":\"25\",\"authorId\":\"1\",\"title\":\"Projekt-Afrika 6\",\"slug\":\"projekt-afrika-6\",\"postDate\":1528379809,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2018-06-07 13:56:49','2018-06-07 13:56:49','32b95852-a6f3-45ab-ad87-7686f1cd8299'),(223,214,17,1,1,1,'','{\"typeId\":\"24\",\"authorId\":\"1\",\"title\":\"Projekt-Schweiz 1\",\"slug\":\"projekt-schweiz-1\",\"postDate\":1528379830,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"61\":[]}}','2018-06-07 13:57:10','2018-06-07 13:57:10','15e02541-3f9b-484e-9924-c54d9e25eb11'),(224,215,17,1,1,1,'','{\"typeId\":\"24\",\"authorId\":\"1\",\"title\":\"Projekt-Schweiz 2\",\"slug\":\"projekt-schweiz-2\",\"postDate\":1528379834,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"61\":[]}}','2018-06-07 13:57:14','2018-06-07 13:57:14','49e54bdd-0287-4d1d-a567-bf80d8cfdd07'),(225,216,17,1,1,1,'','{\"typeId\":\"24\",\"authorId\":\"1\",\"title\":\"Projekt-Schweiz 3\",\"slug\":\"projekt-schweiz-3\",\"postDate\":1528379837,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"61\":[]}}','2018-06-07 13:57:17','2018-06-07 13:57:17','d24f252c-8864-4323-a9cb-f18243dc8aa7'),(226,217,17,1,1,1,'','{\"typeId\":\"24\",\"authorId\":\"1\",\"title\":\"Projekt-Schweiz 4\",\"slug\":\"projekt-schweiz-4\",\"postDate\":1528379840,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"61\":[]}}','2018-06-07 13:57:21','2018-06-07 13:57:21','9b95820f-a8a5-4b4d-9ca7-ad91ebd4acd3'),(227,218,17,1,1,1,'','{\"typeId\":\"24\",\"authorId\":\"1\",\"title\":\"Projekt-Schweiz 5\",\"slug\":\"projekt-schweiz-5\",\"postDate\":1528379844,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"61\":[]}}','2018-06-07 13:57:24','2018-06-07 13:57:24','ab99bf27-23b4-409b-949a-3034e682e98f'),(228,219,17,1,1,1,'','{\"typeId\":\"24\",\"authorId\":\"1\",\"title\":\"Projekt-Schweiz 6\",\"slug\":\"projekt-schweiz-6\",\"postDate\":1528379848,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"61\":[]}}','2018-06-07 13:57:28','2018-06-07 13:57:28','5b64079e-6247-4bed-803a-2d8f5c8374fd');
/*!40000 ALTER TABLE `entryversions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldgroups`
--

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldgroups` VALUES (1,'Default','2018-04-30 15:34:51','2018-05-02 13:47:05','e1ec6658-e650-41d6-a8b2-4892e452865b'),(3,'Globals','2018-05-05 14:13:31','2018-05-05 14:13:31','5a27fb7b-bf48-4ac9-afdc-02d559faa2fc'),(4,'Entry','2018-06-02 11:20:41','2018-06-02 11:20:41','91b620a7-57a0-4432-a52e-9d37d5d4c17c'),(5,'Project Specific','2018-06-07 14:27:31','2018-06-07 14:27:31','edfef69a-be97-4855-bcac-3f7883c12cd4');
/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayoutfields`
--

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayoutfields` VALUES (143,13,53,25,0,1,'2018-05-05 14:15:55','2018-05-05 14:15:55','bccf0aad-c0a9-49b2-a135-668e1e0848b9'),(144,13,53,26,0,2,'2018-05-05 14:15:55','2018-05-05 14:15:55','6db7753d-675b-4f6c-addc-c64e206c77a2'),(145,13,53,27,0,3,'2018-05-05 14:15:55','2018-05-05 14:15:55','be230a88-056a-42b3-8208-eaa3356fff79'),(146,13,53,28,0,4,'2018-05-05 14:15:55','2018-05-05 14:15:55','6637b7a7-3270-4e91-a119-292172eef413'),(147,13,53,29,0,5,'2018-05-05 14:15:55','2018-05-05 14:15:55','fa260d36-b438-4eb9-b0c6-103a1d570d21'),(148,13,53,30,0,6,'2018-05-05 14:15:55','2018-05-05 14:15:55','8453e341-55ae-4f59-b471-2ba3f3f7019f'),(149,13,53,31,0,7,'2018-05-05 14:15:55','2018-05-05 14:15:55','dee0d8e4-fcd2-410d-b3ba-edd04d4c5781'),(150,13,53,32,0,8,'2018-05-05 14:15:55','2018-05-05 14:15:55','706c0ad0-8b9c-441a-b086-17c652e66479'),(158,18,58,41,0,1,'2018-05-05 14:52:41','2018-05-05 14:52:41','4e5cc467-afe1-4679-9d28-76df04a2eb95'),(159,18,58,42,0,2,'2018-05-05 14:52:41','2018-05-05 14:52:41','730c855b-fb3e-4909-9cba-51d79e27fb2b'),(160,18,58,43,0,3,'2018-05-05 14:52:41','2018-05-05 14:52:41','fca93dbf-d098-49b7-9325-43f12b279678'),(161,18,58,44,0,4,'2018-05-05 14:52:41','2018-05-05 14:52:41','760b06b8-e532-4b57-a933-24c7e707b900'),(162,18,58,45,0,5,'2018-05-05 14:52:41','2018-05-05 14:52:41','2b25971c-0a77-4e3f-b026-555167f12246'),(163,18,58,46,0,6,'2018-05-05 14:52:41','2018-05-05 14:52:41','bc1f41cf-8aa7-47f7-bd0c-aa0abd90143d'),(164,18,58,47,0,7,'2018-05-05 14:52:41','2018-05-05 14:52:41','3e8847af-b8af-495c-b815-1e51bc7470c6'),(171,19,62,24,0,1,'2018-05-05 14:54:42','2018-05-05 14:54:42','3b85a0f4-f2fa-4455-908a-d7ffa6edf531'),(172,20,63,33,0,1,'2018-05-05 14:55:05','2018-05-05 14:55:05','cccd835b-9808-4f62-8957-178ccf51efcf'),(173,21,64,34,0,1,'2018-05-05 14:55:25','2018-05-05 14:55:25','1d8aa828-ebf2-4301-b0ac-e5c322181005'),(174,22,65,35,0,1,'2018-05-05 14:55:43','2018-05-05 14:55:43','0f7e90b6-d279-424a-92a2-29cc390f11e6'),(175,23,66,39,0,1,'2018-05-05 14:56:01','2018-05-05 14:56:01','86805ed2-65a6-4875-9959-90bf3659a7dc'),(176,24,67,40,0,1,'2018-05-05 14:56:15','2018-05-05 14:56:15','464c839a-7665-4273-b9f7-5dab96e3d17b'),(196,17,73,36,0,1,'2018-05-09 10:36:46','2018-05-09 10:36:46','c8418a21-4d06-48b5-9829-809d162f9014'),(197,17,73,37,0,2,'2018-05-09 10:36:46','2018-05-09 10:36:46','f58a715c-7d60-4898-9b17-f592e2adcd2a'),(198,17,73,38,0,3,'2018-05-09 10:36:46','2018-05-09 10:36:46','3baabd12-4904-4390-969a-137b6703d87a'),(199,17,73,48,0,4,'2018-05-09 10:36:46','2018-05-09 10:36:46','6fc1f7ec-282c-4e41-90b0-ceb4b43c61ab'),(266,27,101,53,0,1,'2018-06-06 14:30:05','2018-06-06 14:30:05','f2269348-55d1-4c4f-919c-f742756546c9'),(267,27,101,6,0,2,'2018-06-06 14:30:05','2018-06-06 14:30:05','01b6a054-48ce-4ba3-83c0-400c81cbc337'),(268,27,102,50,0,1,'2018-06-06 14:30:05','2018-06-06 14:30:05','0b2e3e63-812b-4a8c-8fe1-94bf3388b504'),(269,27,102,52,0,2,'2018-06-06 14:30:05','2018-06-06 14:30:05','af219142-f69d-4578-ac8e-c11d783e32d1'),(270,27,102,51,0,3,'2018-06-06 14:30:05','2018-06-06 14:30:05','a3799703-c3d6-47ee-9bb5-34b39c491852'),(272,2,104,50,0,1,'2018-06-06 14:31:54','2018-06-06 14:31:54','0e898bd3-527f-44a1-a319-c85a9fbdbbf5'),(273,2,104,52,0,2,'2018-06-06 14:31:54','2018-06-06 14:31:54','5f8dc96b-77ab-4928-b985-bc1270e3d468'),(274,2,104,51,0,3,'2018-06-06 14:31:54','2018-06-06 14:31:54','2aa61287-9f9c-44e3-baa5-b71a80c89057'),(277,31,107,50,0,1,'2018-06-06 14:33:45','2018-06-06 14:33:45','da4ba911-49fd-4c74-a020-bbe51cf11fce'),(278,31,107,51,0,2,'2018-06-06 14:33:45','2018-06-06 14:33:45','d4a6626a-830b-4cad-b1de-2eb0706362ee'),(279,31,107,52,0,3,'2018-06-06 14:33:45','2018-06-06 14:33:45','e947ed58-e12f-493d-83e8-3c5895b67ad8'),(287,28,113,54,0,1,'2018-06-07 06:39:05','2018-06-07 06:39:05','b3f2c44d-eda3-4931-beec-4151d4764756'),(288,29,114,55,0,1,'2018-06-07 06:39:05','2018-06-07 06:39:05','0be468ad-9b08-47a7-bc70-c743c100bb2c'),(289,30,115,56,0,1,'2018-06-07 06:39:05','2018-06-07 06:39:05','682336ea-cc0b-45d6-8725-0eecb986881c'),(290,30,115,57,0,2,'2018-06-07 06:39:05','2018-06-07 06:39:05','c7b44960-24a7-4ada-aa49-f611109b8c56'),(291,32,116,58,0,1,'2018-06-07 06:39:05','2018-06-07 06:39:05','1ec41b5a-045c-4d02-85df-8ae5bd042b35'),(292,32,116,59,0,2,'2018-06-07 06:39:05','2018-06-07 06:39:05','e046829f-1f08-4ded-85cd-ab4f4745a343'),(293,33,117,60,0,1,'2018-06-07 06:39:05','2018-06-07 06:39:05','0e821ccc-53e8-4178-a7b2-38959bd62c14'),(304,47,123,61,0,1,'2018-06-07 13:30:53','2018-06-07 13:30:53','29c6766a-c56e-48ea-9097-ebf2cf2a0e9a');
/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouts`
--

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayouts` VALUES (2,'craft\\elements\\Entry','2018-05-02 13:44:01','2018-06-06 14:31:54','3ff7feb7-9483-4284-9ee1-a88e94eb0d73'),(5,'craft\\elements\\Asset','2018-05-02 14:08:06','2018-05-05 14:21:09','20ca6733-f934-4cdf-bbfe-4c695639d2cd'),(6,'craft\\elements\\Asset','2018-05-02 14:08:20','2018-05-05 10:02:36','a1b0b660-a144-4776-ae6a-d7b431caccba'),(10,'craft\\elements\\Tag','2018-05-03 11:01:12','2018-05-03 11:01:12','fed836f5-1e45-43fc-b7a9-ea52237c9522'),(13,'craft\\elements\\MatrixBlock','2018-05-05 14:15:55','2018-05-05 14:15:55','515d060c-f927-41a8-a079-34e3c78db28a'),(14,'craft\\elements\\Asset','2018-05-05 14:19:33','2018-05-05 14:20:25','2c14f4ce-84b3-4c65-b92b-90fcc10e8e56'),(15,'craft\\elements\\Asset','2018-05-05 14:19:49','2018-05-05 14:19:49','7b3f9391-27fa-4515-9a53-9c87eee777fd'),(16,'craft\\elements\\Asset','2018-05-05 14:21:31','2018-05-05 14:21:34','3a67ac72-aaad-46a9-96ff-21a951883763'),(17,'craft\\elements\\MatrixBlock','2018-05-05 14:33:17','2018-05-09 10:36:46','54cedc0a-554b-4c8f-9177-741b531907fd'),(18,'craft\\elements\\MatrixBlock','2018-05-05 14:51:26','2018-05-05 14:52:41','1bd030a3-2187-4d19-b08f-319c714ce3ae'),(19,'craft\\elements\\GlobalSet','2018-05-05 14:54:42','2018-05-05 14:54:42','71659b6f-ad96-4ea7-adc9-48852560bd6c'),(20,'craft\\elements\\GlobalSet','2018-05-05 14:55:05','2018-05-05 14:55:05','7b4d5025-b806-477c-96ed-857f67f2a93c'),(21,'craft\\elements\\GlobalSet','2018-05-05 14:55:25','2018-05-05 14:55:25','c81d12f1-0d46-4d28-a8a8-f0148b8f9578'),(22,'craft\\elements\\GlobalSet','2018-05-05 14:55:43','2018-05-05 14:55:43','0d120dcf-4215-49e0-b590-5492cb4e6304'),(23,'craft\\elements\\GlobalSet','2018-05-05 14:56:01','2018-05-05 14:56:01','85cac511-5027-4bc0-a0da-18c18c2c1002'),(24,'craft\\elements\\GlobalSet','2018-05-05 14:56:15','2018-05-05 14:56:15','5c6ec872-4eb0-4126-a7a1-e1c435503a6d'),(27,'craft\\elements\\Entry','2018-06-05 21:37:22','2018-06-06 14:30:05','a81dbae8-d063-4585-8b65-b3fb37b6da8b'),(28,'craft\\elements\\MatrixBlock','2018-06-06 14:03:35','2018-06-07 06:39:05','68b561f8-b4e4-4ce0-a9f9-8d517fbba1da'),(29,'craft\\elements\\MatrixBlock','2018-06-06 14:03:35','2018-06-07 06:39:05','1aa64524-68c5-455d-a660-8f32e713c6a8'),(30,'craft\\elements\\MatrixBlock','2018-06-06 14:03:35','2018-06-07 06:39:05','cfed0598-07ce-4e73-8c4b-7bf5756939a2'),(31,'craft\\elements\\Entry','2018-06-06 14:32:06','2018-06-06 14:33:45','d56df7e3-53e7-4bdf-8c04-6d46e6196f6b'),(32,'craft\\elements\\MatrixBlock','2018-06-07 06:37:25','2018-06-07 06:39:05','5e82262c-af43-4cda-aa44-0c46e5755961'),(33,'craft\\elements\\MatrixBlock','2018-06-07 06:37:25','2018-06-07 06:39:05','d53fca31-4484-445a-9406-b0f9e412e6a4'),(43,'craft\\elements\\Entry','2018-06-07 10:23:33','2018-06-07 10:23:33','3e6f1335-9154-42db-bd25-ece97614cfc1'),(44,'craft\\elements\\Entry','2018-06-07 10:24:42','2018-06-07 10:24:42','bf7ba85c-4aa9-4b14-a313-5409d927ed44'),(45,'craft\\elements\\Entry','2018-06-07 10:25:12','2018-06-07 10:25:12','c5d0e283-d6ed-410b-a220-ce2c5bb4a3b5'),(47,'craft\\elements\\Entry','2018-06-07 13:12:51','2018-06-07 13:30:53','bb460806-8189-4a25-9fc2-f3eba2840794'),(48,'craft\\elements\\Entry','2018-06-07 13:13:33','2018-06-07 13:22:00','20ba0cb6-71a6-4078-beda-2eae7a120ff5'),(49,'craft\\elements\\Category','2018-06-07 13:25:20','2018-06-07 13:25:38','691481a8-66dd-4eaa-a10e-65edd7039590');
/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouttabs`
--

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayouttabs` VALUES (53,13,'Content',1,'2018-05-05 14:15:55','2018-05-05 14:15:55','3b7d0611-5410-48a4-a3bd-994503e9e2a8'),(58,18,'Content',1,'2018-05-05 14:52:41','2018-05-05 14:52:41','712edfd4-226f-4ae8-97d5-451d9e95fbf5'),(62,19,'Content',1,'2018-05-05 14:54:42','2018-05-05 14:54:42','e3242352-5bb4-4e02-a2b1-80faff2f9961'),(63,20,'Content',1,'2018-05-05 14:55:05','2018-05-05 14:55:05','34bc915e-8ebd-4cd8-9458-735204141cdf'),(64,21,'Content',1,'2018-05-05 14:55:25','2018-05-05 14:55:25','86147f2f-e0da-4989-a37f-0683e5b8f401'),(65,22,'Content',1,'2018-05-05 14:55:43','2018-05-05 14:55:43','e0a554c6-ab3b-4104-a0a3-9df41e3fe907'),(66,23,'Content',1,'2018-05-05 14:56:01','2018-05-05 14:56:01','6a587ae0-ae06-45c8-ba21-e0ecdac66d18'),(67,24,'Content',1,'2018-05-05 14:56:15','2018-05-05 14:56:15','8c58f46c-7974-4e1e-bfe3-75ac6084e7f3'),(73,17,'Content',1,'2018-05-09 10:36:46','2018-05-09 10:36:46','3d7b6b64-e9cf-46a4-b663-43f44895b1f3'),(101,27,'Content',1,'2018-06-06 14:30:05','2018-06-06 14:30:05','27a6f9a6-26a8-4fbf-bf53-d970f595b0bb'),(102,27,'Entry',2,'2018-06-06 14:30:05','2018-06-06 14:30:05','4732b2db-fc22-498c-ba8a-47f33ef76e3d'),(103,2,'Content',1,'2018-06-06 14:31:54','2018-06-06 14:31:54','a62a0124-86c0-4f25-9a25-6368ba257de8'),(104,2,'Entry',2,'2018-06-06 14:31:54','2018-06-06 14:31:54','ce1d7b53-69bb-4625-8d1c-6bf4d9d26ae2'),(106,31,'Content',1,'2018-06-06 14:33:45','2018-06-06 14:33:45','8f0fd69f-e8f7-41c1-a5b7-9f63d209a59d'),(107,31,'Entry',2,'2018-06-06 14:33:45','2018-06-06 14:33:45','00b5b3d1-f42e-4920-a7c8-b1f0f996902d'),(113,28,'Content',1,'2018-06-07 06:39:05','2018-06-07 06:39:05','86f1007e-0a3c-41c0-b147-3d1eb3feb410'),(114,29,'Content',1,'2018-06-07 06:39:05','2018-06-07 06:39:05','ec5b69da-308c-48fe-8bcc-88d59210267d'),(115,30,'Content',1,'2018-06-07 06:39:05','2018-06-07 06:39:05','b5e1addf-f17a-4b63-8ae7-2591384832cf'),(116,32,'Content',1,'2018-06-07 06:39:05','2018-06-07 06:39:05','87d55af4-338f-4e05-8873-b805787deecc'),(117,33,'Content',1,'2018-06-07 06:39:05','2018-06-07 06:39:05','9f7a3ac3-9d0a-43dd-9249-8b0c331b9534'),(123,47,'Meta',1,'2018-06-07 13:30:53','2018-06-07 13:30:53','add2b4d5-27fa-469e-89bc-5ed9507ba1d1');
/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fields` VALUES (6,1,'Tags','tags','global','','site',NULL,'craft\\fields\\Tags','{\"sources\":\"*\",\"source\":\"taggroup:1\",\"targetSiteId\":null,\"viewMode\":null,\"limit\":null,\"selectionLabel\":\"Type\",\"localizeRelations\":false}','2018-05-02 13:55:11','2018-06-06 13:55:48','40a85f37-50a3-46b8-8352-f7ea391d4157'),(8,1,'Image','image','global','','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"1\",\"defaultUploadLocationSource\":\"folder:1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":[\"folder:1\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"\",\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-05-02 13:55:38','2018-05-09 12:14:34','bb8bb8ce-b2af-4cf8-a4f8-6b944b6540ef'),(24,3,'Contact','globalContact','global','','site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"1\",\"maxBlocks\":\"1\",\"localizeBlocks\":false}','2018-05-05 14:15:55','2018-05-05 14:15:55','0407801d-6589-406a-b952-404e0d45afb3'),(25,NULL,'Company','company','matrixBlockType:4','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-05-05 14:15:55','2018-05-05 14:15:55','e8cde0cd-5e24-4c6a-8150-745056d35e89'),(26,NULL,'Street','street','matrixBlockType:4','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-05-05 14:15:55','2018-05-05 14:15:55','79ffe0ec-b511-4270-b837-43368e4de1bf'),(27,NULL,'Postal Code','postalCode','matrixBlockType:4','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-05-05 14:15:55','2018-05-05 14:15:55','e35af801-4d4d-45c2-af9c-3e246bb445a2'),(28,NULL,'City','city','matrixBlockType:4','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-05-05 14:15:55','2018-05-05 14:15:55','bfab8623-b51b-4322-84ed-97ba3dfc88d5'),(29,NULL,'Country','country','matrixBlockType:4','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-05-05 14:15:55','2018-05-05 14:15:55','82aa3124-663a-4397-8788-a7838f125761'),(30,NULL,'Mail','mail','matrixBlockType:4','','none',NULL,'craft\\fields\\Email','[]','2018-05-05 14:15:55','2018-05-05 14:15:55','ea5b3e03-505b-469c-b4f6-8d54b2e50228'),(31,NULL,'Phone','phone','matrixBlockType:4','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-05-05 14:15:55','2018-05-05 14:15:55','5b94af38-0bab-4f10-8781-868e51cfc5aa'),(32,NULL,'Mobile Phone','mobilePhone','matrixBlockType:4','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-05-05 14:15:55','2018-05-05 14:15:55','a3e15648-5d5b-4a08-87e9-4b1d458c0469'),(33,3,'Google Analytics','googleAnalytics','global','globalGoogleAnalytics','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-05-05 14:16:27','2018-05-05 14:16:27','659b4cf8-9aa7-4de6-9cb7-f6de744d5e6c'),(34,3,'Logo','logo','global','','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"1\",\"defaultUploadLocationSource\":\"folder:1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":[\"folder:1\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"1\",\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-05-05 14:22:51','2018-05-09 08:52:44','2518a794-91b3-46ca-9e7f-30145b383d06'),(35,3,'NavigationMain','globalNavigationMain','global','','site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"localizeBlocks\":false}','2018-05-05 14:33:17','2018-05-09 10:36:46','9f60c63a-d41d-464d-b017-7fd160522e19'),(36,NULL,'Menu Item','menuItem','matrixBlockType:5','','none',NULL,'typedlinkfield\\fields\\LinkField','{\"allowCustomText\":\"1\",\"allowedLinkNames\":[\"url\",\"category\",\"entry\"],\"allowTarget\":\"1\",\"defaultLinkName\":\"url\",\"defaultText\":\"\",\"typeSettings\":{\"url\":{\"disableValidation\":\"1\"},\"email\":{\"disableValidation\":\"\"},\"tel\":{\"disableValidation\":\"\"},\"asset\":{\"sources\":\"*\"},\"category\":{\"sources\":\"*\"},\"entry\":{\"sources\":\"*\"},\"globalset\":{\"sources\":\"*\"}}}','2018-05-05 14:33:17','2018-05-09 10:36:46','05024d07-504c-4c29-9697-4e9b461b9067'),(37,NULL,'Is Active','isActive','matrixBlockType:5','','none',NULL,'craft\\fields\\Lightswitch','{\"default\":\"\"}','2018-05-05 14:47:46','2018-05-09 10:36:46','504cbccf-3005-4cc3-8d88-315c041490f3'),(38,NULL,'Highlight Triggers','highlightTriggers','matrixBlockType:5','Do not edit!','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-05-05 14:47:46','2018-05-09 10:36:46','d1958f93-1586-444e-8190-1b864041baa4'),(39,3,'Social Networks','globalSocialNetworks','global','','none',NULL,'craft\\fields\\Table','{\"addRowLabel\":\"Add a row\",\"maxRows\":\"\",\"minRows\":\"\",\"columns\":{\"col1\":{\"heading\":\"Network\",\"handle\":\"network\",\"width\":\"\",\"type\":\"singleline\"},\"col2\":{\"heading\":\"Alias\",\"handle\":\"alias\",\"width\":\"\",\"type\":\"singleline\"},\"col3\":{\"heading\":\"Url\",\"handle\":\"url\",\"width\":\"\",\"type\":\"singleline\"}},\"defaults\":{\"row1\":{\"col1\":\"\",\"col2\":\"\",\"col3\":\"\"}},\"columnType\":\"text\"}','2018-05-05 14:48:57','2018-05-05 14:48:57','8592a4e0-b651-4080-b81a-f5e10b7f5ff1'),(40,3,'Watermark','globalWatermark','global','','site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"localizeBlocks\":false}','2018-05-05 14:51:26','2018-05-05 14:52:41','f9b5b11d-0a27-420e-81a2-0d2252de9a8d'),(41,NULL,'Use Watermark','useWatermark','matrixBlockType:6','','none',NULL,'craft\\fields\\Lightswitch','{\"default\":\"\"}','2018-05-05 14:51:26','2018-05-05 14:52:41','10eab488-dcb8-4bac-bc6b-99d863e07600'),(42,NULL,'Image','image','matrixBlockType:6','','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"1\",\"defaultUploadLocationSource\":\"folder:1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":[\"folder:1\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-05-05 14:51:26','2018-05-05 14:52:41','5487b7ce-fd50-4c91-b65c-23a1b9717eaa'),(43,NULL,'Width','width','matrixBlockType:6','','none',NULL,'craft\\fields\\Number','{\"min\":null,\"max\":null,\"decimals\":\"0\",\"size\":null}','2018-05-05 14:52:41','2018-05-05 14:52:41','f5718b58-0e01-407f-b44f-7095c1d14c72'),(44,NULL,'Height','height','matrixBlockType:6','','none',NULL,'craft\\fields\\Number','{\"min\":null,\"max\":null,\"decimals\":\"0\",\"size\":null}','2018-05-05 14:52:41','2018-05-05 14:52:41','7c04d331-4f18-4a05-8f48-fb0a66e7585e'),(45,NULL,'Opacity','opacity','matrixBlockType:6','','none',NULL,'craft\\fields\\Number','{\"min\":null,\"max\":\"1\",\"decimals\":\"1\",\"size\":null}','2018-05-05 14:52:41','2018-05-05 14:52:41','b7b3a420-5cf4-4673-b90b-4c76c593ad1f'),(46,NULL,'Offset X-Axis','offsetXAxis','matrixBlockType:6','','none',NULL,'craft\\fields\\Number','{\"min\":null,\"max\":null,\"decimals\":\"0\",\"size\":null}','2018-05-05 14:52:41','2018-05-05 14:52:41','b062a085-36d1-403c-81e7-5a8b25a1fc0e'),(47,NULL,'Offset Y-Axis','offsetYAxis','matrixBlockType:6','','none',NULL,'craft\\fields\\Number','{\"min\":null,\"max\":null,\"decimals\":\"0\",\"size\":null}','2018-05-05 14:52:41','2018-05-05 14:52:41','a954759e-94e6-435a-8140-321cbe7d2b10'),(48,NULL,'Segment Position','segmentPosition','matrixBlockType:5','','none',NULL,'craft\\fields\\Number','{\"min\":null,\"max\":null,\"decimals\":\"0\",\"size\":null}','2018-05-09 09:39:51','2018-05-09 10:36:46','3003f6f2-4f5f-4e0c-9a38-09f81fc5b227'),(49,1,'Media','media','global','','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"1\",\"defaultUploadLocationSource\":\"folder:1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:6\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"audio\",\"json\",\"video\"],\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"\",\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-05-09 12:17:02','2018-05-09 12:17:02','c5ea66cf-e95a-40f6-b4ad-45644c47a362'),(50,4,'Entry Intro Headline','entryIntroHeadline','global','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"1\",\"initialRows\":\"2\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-06-02 11:21:47','2018-06-02 11:23:14','951d89ff-6e8f-4a34-8a5b-b516f4c36322'),(51,4,'Entry Intro Image','entryIntroImage','global','','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"1\",\"defaultUploadLocationSource\":\"folder:1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":[\"folder:1\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"\",\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-06-02 11:22:26','2018-06-02 11:23:42','c2812dbe-ddd6-4c95-b547-c2749900f9a3'),(52,4,'Entry Intro Text','entryIntroText','global','','none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Simple.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"}','2018-06-02 11:24:08','2018-06-06 13:53:47','8b27df82-2732-4aca-ac49-ae1aab641203'),(53,1,'Content Builder','contentBuilder','global','','site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"localizeBlocks\":false}','2018-06-06 14:03:34','2018-06-07 06:39:04','ef820e5f-c948-4953-911f-c1f47c7a76aa'),(54,NULL,'Headline','headline','matrixBlockType:7','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-06-06 14:03:35','2018-06-07 06:39:05','12b71424-c2c2-4b38-b210-a39d237cd07d'),(55,NULL,'Text','Text','matrixBlockType:8','','none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Standard.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"\",\"availableTransforms\":\"*\"}','2018-06-06 14:03:35','2018-06-07 06:39:05','c0dab484-c812-4fe6-b252-6adfb00df345'),(56,NULL,'Image','image','matrixBlockType:9','','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"1\",\"defaultUploadLocationSource\":\"folder:1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-06-06 14:03:35','2018-06-07 06:39:05','6e8689bb-7209-4b88-83c1-e95d1c38e08b'),(57,NULL,'Caption','caption','matrixBlockType:9','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-06-07 06:37:25','2018-06-07 06:39:05','6b4d6739-865a-4ad7-aab0-9a0b0e408f18'),(58,NULL,'Images','images','matrixBlockType:10','','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"1\",\"defaultUploadLocationSource\":\"folder:1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"illustrator\",\"image\"],\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"\",\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-06-07 06:37:25','2018-06-07 06:39:05','b7e328f7-b4fc-454d-b7bd-e7810c313029'),(59,NULL,'Caption','caption','matrixBlockType:10','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-06-07 06:37:25','2018-06-07 06:39:05','e3216769-97dc-4b5c-ac9f-ac9204c2efda'),(60,NULL,'Images','images','matrixBlockType:11','','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"1\",\"defaultUploadLocationSource\":\"folder:1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"illustrator\",\"image\"],\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"\",\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-06-07 06:37:25','2018-06-07 06:39:05','70ab5c37-3c51-4533-8587-7c129fa934c5'),(61,1,'Category','category','global','','site',NULL,'craft\\fields\\Categories','{\"branchLimit\":\"\",\"sources\":\"*\",\"source\":\"group:1\",\"targetSiteId\":null,\"viewMode\":null,\"limit\":null,\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-06-07 13:30:06','2018-06-07 13:32:04','d42af441-9c37-4c1b-bf38-11a0d34a8abe');
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
INSERT INTO `info` VALUES (1,'3.0.10.2','3.0.91',1,'America/Los_Angeles','drissy',1,1,'yOg7SDMWvuMj','2018-04-30 15:34:51','2018-06-07 14:00:01','6baa0fb6-048b-4a5d-b7d4-53f05075bcb2');
/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocks`
--

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixblocks` VALUES (64,61,NULL,35,5,1,'2018-05-05 14:59:34','2018-05-17 13:03:01','4f749242-824d-4101-8c43-eb92c7a731a4'),(67,61,NULL,35,5,2,'2018-05-05 14:59:34','2018-05-17 13:03:01','c16a53f8-2509-486e-a2a2-bc61a12fae10'),(68,58,NULL,24,4,1,'2018-05-05 15:14:21','2018-05-17 13:02:28','b958d256-6898-4f8f-b9c2-490bdc8c3ba0');
/*!40000 ALTER TABLE `matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocktypes`
--

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixblocktypes` VALUES (4,24,13,'Contact','contact',1,'2018-05-05 14:15:55','2018-05-05 14:15:55','b1236d9c-9004-48dd-a586-d69c689727d7'),(5,35,17,'Menu Item','menuItem',1,'2018-05-05 14:33:17','2018-05-09 10:36:46','7e11aa39-136f-459e-9072-d214c0f8db04'),(6,40,18,'Watermark','watermark',1,'2018-05-05 14:51:26','2018-05-05 14:52:41','def6bad5-adc7-4a26-be2d-06d718a72fbf'),(7,53,28,'Headline','headline',1,'2018-06-06 14:03:34','2018-06-07 06:39:05','85c1c731-253b-4a7a-873d-924f9d746c59'),(8,53,29,'Text','Text',2,'2018-06-06 14:03:35','2018-06-07 06:39:05','02694de0-a7d7-4c2d-952a-b0b75b61e2a4'),(9,53,30,'Image Single','imageSingle',3,'2018-06-06 14:03:35','2018-06-07 06:39:05','e02ed641-9620-4e5f-9f8d-37a239610bd8'),(10,53,32,'Image Carousel','imageCarousel',4,'2018-06-07 06:37:25','2018-06-07 06:39:05','d53d1602-0ed5-4848-bb87-dcf0b8d2c07f'),(11,53,33,'Image Slider','imageSlider',5,'2018-06-07 06:37:25','2018-06-07 06:39:05','9b0b1f13-937c-45a2-813e-d704ddc77106');
/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixcontent_contentbuilder`
--

LOCK TABLES `matrixcontent_contentbuilder` WRITE;
/*!40000 ALTER TABLE `matrixcontent_contentbuilder` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixcontent_contentbuilder` ENABLE KEYS */;
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
INSERT INTO `migrations` VALUES (1,NULL,'app','Install','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','88c73732-c5aa-431a-807e-31390401587f'),(2,NULL,'app','m150403_183908_migrations_table_changes','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','b312441d-959e-4d37-a3e7-73b79df75466'),(3,NULL,'app','m150403_184247_plugins_table_changes','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','7a975de1-5288-42f5-a951-c7c477a7904d'),(4,NULL,'app','m150403_184533_field_version','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','67caa19d-5922-4c61-931f-f5502f75aa42'),(5,NULL,'app','m150403_184729_type_columns','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','9b96a79f-d1e3-42f1-9851-09c9bda1df60'),(6,NULL,'app','m150403_185142_volumes','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','1193541f-88e9-4c92-998a-c0c8dbf77821'),(7,NULL,'app','m150428_231346_userpreferences','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','c9e0ccdd-e952-4359-a611-138b1b9f4e93'),(8,NULL,'app','m150519_150900_fieldversion_conversion','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','143a9edd-fbf7-4364-89d6-c2718226a28b'),(9,NULL,'app','m150617_213829_update_email_settings','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','1f6660bb-ce96-4a22-9b05-dd0863a76745'),(10,NULL,'app','m150721_124739_templatecachequeries','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','8bfd0652-9f5c-4ddf-85f6-c4867a92b18b'),(11,NULL,'app','m150724_140822_adjust_quality_settings','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','e17fd6de-b48a-4913-bfbe-260a262925b3'),(12,NULL,'app','m150815_133521_last_login_attempt_ip','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','5f4eb9c8-4d10-464a-a12b-32ecc3037fd8'),(13,NULL,'app','m151002_095935_volume_cache_settings','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','031bb1df-e845-42a2-a8db-c1e43c70b68b'),(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','6a2c1045-6b85-4b4c-ad5a-5da4c741e338'),(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','af68fb82-cc22-49a4-b280-e977fa76a26f'),(16,NULL,'app','m151209_000000_move_logo','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','0cddcc0b-7ee6-4e09-b539-388905844bbf'),(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','fdbb37f7-4ace-45b8-8115-d1b7c4799f51'),(18,NULL,'app','m151215_000000_rename_asset_permissions','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','6d6ec9f8-a910-451d-ae62-2abdaddc3c3c'),(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','655027ce-4ab7-4d13-9e5e-5093ac8921e8'),(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','eedbc268-cade-4232-b7a7-e0e72e7a19b6'),(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','4e837f13-91e5-4e32-bbf5-f0783c3773ef'),(22,NULL,'app','m160727_194637_column_cleanup','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','66e6f5dc-c5d7-45de-b335-c89da305dc8a'),(23,NULL,'app','m160804_110002_userphotos_to_assets','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','ac25ffec-3a38-4ab4-a2fe-87575d5c1719'),(24,NULL,'app','m160807_144858_sites','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','baac82f5-227f-48f0-a5b2-a1d8e30247ce'),(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','10ac47c0-2600-4357-97c7-2ad8be43153f'),(26,NULL,'app','m160830_000000_asset_index_uri_increase','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','b431f182-d481-40f9-a149-2463d4c6ea1c'),(27,NULL,'app','m160912_230520_require_entry_type_id','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','73c042b5-dff2-488e-b6cd-6c66790d7d60'),(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','bd91c737-c429-4bd1-82a1-5386067a0788'),(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','93844ec8-fd7a-4b21-b2ad-41f92a8152a8'),(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','f5099940-2c28-4f0b-8d11-1fadb205dbfc'),(31,NULL,'app','m160925_113941_route_uri_parts','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','267475b9-9b25-4810-8e27-55e29728dece'),(32,NULL,'app','m161006_205918_schemaVersion_not_null','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','dcc4006d-129a-496e-b7b5-f6adc9d28534'),(33,NULL,'app','m161007_130653_update_email_settings','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','f38d0d31-1f33-437d-a04b-82766cc7be61'),(34,NULL,'app','m161013_175052_newParentId','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','73c1dd65-6060-400f-aa46-2ed91ef99e8e'),(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','aab73c9e-3fbb-4ead-ba1d-56395a71cc3d'),(36,NULL,'app','m161021_182140_rename_get_help_widget','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','289b59af-23a2-4a49-9d5d-e1ba9ac6205f'),(37,NULL,'app','m161025_000000_fix_char_columns','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','25042498-6a98-4b1b-944c-5ad5079119f7'),(38,NULL,'app','m161029_124145_email_message_languages','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','9b423f83-24ec-48aa-a5d6-327b9f63a393'),(39,NULL,'app','m161108_000000_new_version_format','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','8d00132e-1834-4e1e-9fce-eb29d7bd56be'),(40,NULL,'app','m161109_000000_index_shuffle','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','035c5884-035e-43d4-98df-eec2438513c3'),(41,NULL,'app','m161122_185500_no_craft_app','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','a86fc0ab-c50b-42d9-a572-eefa8c2b347c'),(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','acc3bbf8-f3c6-4c6b-a33e-61b4f8dae938'),(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','f6ed4032-b5a8-4844-8e33-14a54546f4dc'),(44,NULL,'app','m170114_161144_udates_permission','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','a5094bfc-645e-47d2-9838-9bdef45efae8'),(45,NULL,'app','m170120_000000_schema_cleanup','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','b4eafdba-b03d-43d0-966a-0dc9db830b9b'),(46,NULL,'app','m170126_000000_assets_focal_point','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','7321567b-085a-4a73-a890-fc4be735e517'),(47,NULL,'app','m170206_142126_system_name','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','d0ea6f99-5870-44ea-a374-2530c33eccb5'),(48,NULL,'app','m170217_044740_category_branch_limits','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','44117d86-97c6-4a69-9428-5c1357cfed36'),(49,NULL,'app','m170217_120224_asset_indexing_columns','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','5b50fbb3-4a92-428d-aa48-185600bd7e0b'),(50,NULL,'app','m170223_224012_plain_text_settings','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','d4ef892a-f95a-4bf8-a162-69e84f465c17'),(51,NULL,'app','m170227_120814_focal_point_percentage','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','ead3a5ca-910b-410e-8244-8cf0566c816f'),(52,NULL,'app','m170228_171113_system_messages','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','2beda057-947a-4cee-aa52-eab3eac95ab0'),(53,NULL,'app','m170303_140500_asset_field_source_settings','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','3059c0f2-d59b-4008-ae11-de00496fcf5b'),(54,NULL,'app','m170306_150500_asset_temporary_uploads','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','33e2cc50-da61-4c1d-8c72-39cb8f2d22a3'),(55,NULL,'app','m170414_162429_rich_text_config_setting','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','65f17743-5dab-47db-8aa3-36fcf78674e6'),(56,NULL,'app','m170523_190652_element_field_layout_ids','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','d8d92c66-2253-4540-ba75-60fc3127b323'),(57,NULL,'app','m170612_000000_route_index_shuffle','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','5af16ac0-ea07-44fb-a2e9-98d978ea1f67'),(58,NULL,'app','m170621_195237_format_plugin_handles','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','ed98b867-de0f-481a-9694-bdaab6524f4e'),(59,NULL,'app','m170630_161028_deprecation_changes','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','421adedc-01c1-4a8a-b3f5-8f19fffcff1d'),(60,NULL,'app','m170703_181539_plugins_table_tweaks','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','8981947a-4bbe-44ed-9778-87759af5778e'),(61,NULL,'app','m170704_134916_sites_tables','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','3dcbe145-4291-46f6-a538-f8c727bd7fd3'),(62,NULL,'app','m170706_183216_rename_sequences','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','f61ace8d-ef82-4f1e-a3d0-fa4a347068df'),(63,NULL,'app','m170707_094758_delete_compiled_traits','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','745de11a-e0d7-4bee-a5b2-0c39e282f94f'),(64,NULL,'app','m170731_190138_drop_asset_packagist','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','6fa95c55-173c-45bb-92c6-e7e10064be72'),(65,NULL,'app','m170810_201318_create_queue_table','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','5298a03b-b4b4-45f0-b6a6-0f7cc90be93a'),(66,NULL,'app','m170816_133741_delete_compiled_behaviors','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','8d02bda8-b64b-40fb-856d-c85ac85bca9a'),(67,NULL,'app','m170821_180624_deprecation_line_nullable','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','67404e85-0a4e-451f-a1ca-faff29bc8baf'),(68,NULL,'app','m170903_192801_longblob_for_queue_jobs','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','e2e4e4fe-91de-4608-8bb8-d23d34e8d172'),(69,NULL,'app','m170914_204621_asset_cache_shuffle','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','ada59ad3-a8c1-4ece-9a38-61176e5db8d2'),(70,NULL,'app','m171011_214115_site_groups','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','83d1ef32-f59b-44fa-a920-961e66ffca8c'),(71,NULL,'app','m171012_151440_primary_site','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','b10672a9-18ca-4d55-bfe1-2d1e8ae96bbb'),(72,NULL,'app','m171013_142500_transform_interlace','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','b9196724-eacd-4aeb-ac55-3a7ae765e52e'),(73,NULL,'app','m171016_092553_drop_position_select','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','f99e6777-a5e9-49e1-b068-d98bed3c18c8'),(74,NULL,'app','m171016_221244_less_strict_translation_method','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','13f00557-25ed-40c1-b955-8c2c2b698bcf'),(75,NULL,'app','m171107_000000_assign_group_permissions','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','b1b1b85a-104a-4349-9381-c5219ac936db'),(76,NULL,'app','m171117_000001_templatecache_index_tune','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','30bc5e2b-c99a-45d8-b006-8d7bc78be178'),(77,NULL,'app','m171126_105927_disabled_plugins','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','226b2988-359d-4554-9c35-a6e4b8adf342'),(78,NULL,'app','m171130_214407_craftidtokens_table','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','8f566d3f-8a88-4617-86e9-3dad89bee2be'),(79,NULL,'app','m171202_004225_update_email_settings','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','fb0fa1de-d149-4f43-8a07-20b25b6a5dff'),(80,NULL,'app','m171204_000001_templatecache_index_tune_deux','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','25bbfdd8-7bca-4d01-8d2f-849d7602e438'),(81,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','69cff4f6-b5f3-4d5a-bbf4-d0a19e5597bd'),(82,NULL,'app','m171218_143135_longtext_query_column','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','f6555cb4-28c1-47bf-8e70-b13ac906c4f0'),(83,NULL,'app','m171231_055546_environment_variables_to_aliases','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','278bc06a-34e5-495a-89e3-f9a132c4b940'),(84,NULL,'app','m180113_153740_drop_users_archived_column','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','8d47db4a-a4bb-483d-82d3-f5213d12438b'),(85,NULL,'app','m180122_213433_propagate_entries_setting','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','b74881da-0345-41ba-92b8-1a67fc439ca4'),(86,NULL,'app','m180124_230459_fix_propagate_entries_values','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','12960f32-9d07-487d-90b3-3d8722326178'),(87,NULL,'app','m180128_235202_set_tag_slugs','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','635f6a79-f693-47f1-9189-0f68415ea6a4'),(88,NULL,'app','m180202_185551_fix_focal_points','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','bbbe179b-7cba-4250-8e0d-4e8e04ac4d53'),(89,NULL,'app','m180217_172123_tiny_ints','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','2a3f26e5-cc61-4d47-a901-b99d94482482'),(90,NULL,'app','m180321_233505_small_ints','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','a16b177c-716e-4df4-a94a-8ac2d372f599'),(91,NULL,'app','m180328_115523_new_license_key_statuses','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','ee91e766-c80c-421a-9e99-151725efbd31'),(92,NULL,'app','m180404_182320_edition_changes','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','592c09ac-f199-40f4-9775-de2e8154fe3c'),(93,NULL,'app','m180411_102218_fix_db_routes','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','2470b266-e1b3-4470-a2f6-c77cc798e512'),(94,NULL,'app','m180416_205628_resourcepaths_table','2018-04-30 15:34:52','2018-04-30 15:34:52','2018-04-30 15:34:52','b2e64934-a8f5-49e0-805d-394da1863393'),(95,NULL,'app','m180418_205713_widget_cleanup','2018-05-01 14:49:08','2018-05-01 14:49:08','2018-05-01 14:49:08','10389c11-50a4-4c9a-b889-361c0d5f1b6c'),(104,37,'plugin','Install','2018-06-04 09:27:17','2018-06-04 09:27:17','2018-06-04 09:27:17','7e51a9d0-4a26-485b-951a-b92c892dbee5'),(105,37,'plugin','m180430_204710_remove_old_plugins','2018-06-04 09:27:17','2018-06-04 09:27:17','2018-06-04 09:27:17','8ea13c49-7a2c-479d-b77e-973c8f3b353c'),(106,40,'plugin','Install','2018-06-04 09:27:17','2018-06-04 09:27:17','2018-06-04 09:27:17','3a3bc453-96c3-4fed-8c2c-09b80f844c5c'),(107,40,'plugin','m180314_002756_base_install','2018-06-04 09:27:17','2018-06-04 09:27:17','2018-06-04 09:27:17','dd35d6e4-f903-471d-b577-f1e3ee791197'),(108,40,'plugin','m180403_002756_field_type','2018-06-04 09:27:17','2018-06-04 09:27:17','2018-06-04 09:27:17','70d103ef-1171-4339-a584-e09e8cca7ca0'),(109,40,'plugin','m180502_202319_remove_field_metabundles','2018-06-04 09:27:17','2018-06-04 09:27:17','2018-06-04 09:27:17','cf7c0ab1-17dd-44b6-bcfb-fedca78c8746');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `plugins` VALUES (7,'fractal','1.0.8','1.0.0',NULL,'unknown',0,NULL,'2018-04-30 15:36:27','2018-04-30 15:36:27','2018-04-30 16:06:21','4a949450-2eec-4a63-bcac-607aa26d26b1'),(25,'async-queue','1.3.2','1.0.0',NULL,'unknown',1,NULL,'2018-06-04 09:27:15','2018-06-04 09:27:15','2018-06-07 14:10:12','21f3b5ae-b608-4d74-9f56-3ee5bc68edb9'),(26,'child-me','1.0.4','1.0.0',NULL,'unknown',1,NULL,'2018-06-04 09:27:15','2018-06-04 09:27:15','2018-06-07 14:10:12','6193dc57-4fb2-4f6e-9f08-920dc65c1d4e'),(27,'cp-field-inspect','1.0.4','1.0.0',NULL,'unknown',1,NULL,'2018-06-04 09:27:15','2018-06-04 09:27:15','2018-06-07 14:10:12','6912364e-4f17-4f0c-ac5a-74f0b71e9a13'),(28,'cp-css','2.1.0','2.0.0',NULL,'unknown',1,NULL,'2018-06-04 09:27:15','2018-06-04 09:27:15','2018-06-07 14:10:12','307631c7-4834-4449-ba8a-e96daba237e8'),(29,'cookies','1.1.9','1.0.0',NULL,'unknown',1,NULL,'2018-06-04 09:27:15','2018-06-04 09:27:15','2018-06-07 14:10:12','deff210d-d607-41ab-8a64-979a16e98f23'),(30,'contact-form','2.1.1','1.0.0',NULL,'unknown',1,NULL,'2018-06-04 09:27:16','2018-06-04 09:27:16','2018-06-07 14:10:12','2b04218b-278c-4bcc-b5ce-7081547f2784'),(31,'craft-gonzo','dev-master','0.0.1',NULL,'unknown',1,NULL,'2018-06-04 09:27:16','2018-06-04 09:27:16','2018-06-07 14:10:12','3d7d9984-dfd4-4f8a-8682-daf8d11adb81'),(32,'environment-label','3.1.4','1.0.0',NULL,'unknown',1,NULL,'2018-06-04 09:27:16','2018-06-04 09:27:16','2018-06-07 14:10:12','a28af36d-9174-47f3-ac5c-0e2552ee72af'),(33,'expanded-singles','1.0.3','1.0.0',NULL,'unknown',1,NULL,'2018-06-04 09:27:16','2018-06-04 09:27:16','2018-06-07 14:10:12','fc2d0227-86b0-440c-a8d4-6b6447f5aa60'),(34,'imager','v2.0.1.1','2.0.0',NULL,'unknown',1,NULL,'2018-06-04 09:27:16','2018-06-04 09:27:16','2018-06-07 14:10:12','c9e0f8ee-d0e9-40d6-8ffa-b7517d47411a'),(35,'minify','1.2.8','1.0.0',NULL,'unknown',1,NULL,'2018-06-04 09:27:16','2018-06-04 09:27:16','2018-06-07 14:10:12','70ee6a54-fb6b-4a86-8687-0f91998c97a4'),(36,'position-fieldtype','1.0.13','1.0.0',NULL,'unknown',1,NULL,'2018-06-04 09:27:17','2018-06-04 09:27:17','2018-06-07 14:10:12','416cd8fe-89d5-466a-860f-d8bc57197333'),(37,'redactor','2.0.0.1','2.0.0',NULL,'unknown',1,NULL,'2018-06-04 09:27:17','2018-06-04 09:27:17','2018-06-07 14:10:12','d9fa719f-6a44-4da9-b8fd-4cca9ee4e086'),(38,'splash','3.0.2','3.0.0',NULL,'unknown',1,NULL,'2018-06-04 09:27:17','2018-06-04 09:27:17','2018-06-07 14:10:12','7282f652-2cd9-4630-a1b5-966d7e507d56'),(39,'typedlinkfield','1.0.8','1.0.0',NULL,'unknown',1,NULL,'2018-06-04 09:27:17','2018-06-04 09:27:17','2018-06-07 14:10:12','f660c9b1-9f3b-4e98-82ef-4bd0db3c0f3c'),(40,'seomatic','3.0.20','3.0.5',NULL,'invalid',1,NULL,'2018-06-04 09:27:17','2018-06-04 09:27:17','2018-06-07 14:10:12','7cf5d983-27cd-4896-9fa2-1c3c23b0f172'),(41,'typogrify','1.1.10','1.0.0',NULL,'unknown',1,NULL,'2018-06-04 09:27:17','2018-06-04 09:27:17','2018-06-07 14:10:12','49b6d40f-c314-4e07-8753-0e16c72a2417');
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
INSERT INTO `resourcepaths` VALUES ('10431919','@app/web/assets/updates/dist'),('10656309','@craft/web/assets/pluginstore/dist'),('1141cf65','@runtime/assets/thumbs/16'),('11bab243','@craft/web/assets/feed/dist'),('11cd811c','@runtime/assets/thumbs/38'),('12a0f80d','@lib/jquery-ui'),('12e05ef7','@craft/web/assets/cp/dist'),('143e938e','@craft/web/assets/dashboard/dist'),('14cf7bbe','@lib/selectize'),('155d32b7','@lib/xregexp'),('174e395','@app/web/assets/login/dist'),('1760deca','@runtime/assets/thumbs/41'),('17c138dd','@runtime/assets/thumbs/13'),('1807d166','@app/web/assets/recententries/dist'),('191e5374','@craft/web/assets/cp/dist'),('198a5993','@lib/garnishjs'),('1a98c5e5','@runtime/assets/thumbs/39'),('1c359a33','@runtime/assets/thumbs/40'),('1e18390f','@runtime/assets/thumbs/20'),('1e72bbc0','@app/web/assets/pluginstore/dist'),('1ea33f34','@lib/xregexp'),('1ed13826','@lib/element-resize-detector'),('1f31763d','@lib/selectize'),('203a365c','@app/web/assets/matrix/dist'),('2059e165','@craft/web/assets/plugins/dist'),('20ce64ae','@lib/velocity'),('2108382d','@runtime/assets/thumbs/35'),('210ce331','@runtime/assets/thumbs/6'),('215c6741','@lib/timepicker'),('216ce8df','@runtime/assets/thumbs/11'),('218252e5','@mmikkel/cpfieldinspect/resources'),('21b0580f','@lib/prismjs'),('21e615c7','@runtime/assets/thumbs/42'),('22a8ae86','@app/web/assets/plugins/dist'),('22c55758','@typedlinkfield/resources'),('23365286','@lib/jquery-touch-events'),('241bf635','@craft/web/assets/tablesettings/dist'),('2438a80b','@craft/web/assets/dbbackup/dist'),('2470b1a3','@runtime/assets/icons'),('24926e44','@lib/picturefill'),('24ea8a3a','@craft/web/assets/matrix/dist'),('24fa2255','@runtime/assets/thumbs/37'),('26a938ca','@craft/web/assets/login/dist'),('26bd9308','@app/web/assets/updateswidget/dist'),('282f3fc9','@app/web/assets/craftsupport/dist'),('290d5e32','@app/web/assets/cp/dist'),('2956a305','@app/web/assets/plugins/dist'),('2a3388fe','@runtime/assets/thumbs/42'),('2a374e15','@lib/d3'),('2c315e43','@craft/web/assets/utilities/dist'),('2defccd8','@craft/web/assets/updates/dist'),('2e827de','@craft/web/assets/craftsupport/dist'),('2eaf8f07','@craft/web/assets/craftsupport/dist'),('2f181468','@app/web/assets/editentry/dist'),('2f84c3f3','@runtime/assets/thumbs/20'),('301a51c3','@vendor/craftcms/redactor/lib/redactor-plugins/fullscreen'),('30f6594b','@app/web/assets/dbbackup/dist'),('314193d3','@bower/jquery/dist'),('32e9cc60','@craft/web/assets/sites/dist'),('3393ab76','@runtime/assets/thumbs/37'),('3498518e','@craft/web/assets/editentry/dist'),('3624c508','@craft/web/assets/recententries/dist'),('3973bfe6','@app/web/assets/sites/dist'),('3c7a6fba','@lib/fileupload'),('3ce9cb46','@lib/jquery.payment'),('3d5b9064','@craft/web/assets/assetindexes/dist'),('3d68c910','@runtime/assets/thumbs/37'),('3ddac88b','@craft/web/assets/recententries/dist'),('3de4dae2','@craft/web/assets/clearcaches/dist'),('3dfd1a9a','@craft/web/assets/feed/dist'),('3ee750d4','@lib/jquery-ui'),('3f5695f5','@nystudio107/seomatic/assetbundles/seomatic/dist'),('3fe78357','@craft/web/assets/updater/dist'),('402ecc40','@lib/jquery.payment'),('4038ce4b','@craft/web/assets/tablesettings/dist'),('40b1563a','@lib/picturefill'),('44190e22','@app/web/assets/matrix/dist'),('44be3c51','@craft/web/assets/dashboard/dist'),('457f5f3f','@lib/timepicker'),('45936071','@lib/prismjs'),('45ea7be8','@lib/d3'),('47156af8','@lib/jquery-touch-events'),('485f5688','@craft/web/assets/editentry/dist'),('49eb4e3d','@runtime/assets/thumbs/36'),('4ae132b0','@runtime/assets/thumbs/14'),('4b3b2c16','@app/web/assets/editentry/dist'),('4b4f5bb9','@lib/picturefill'),('4ceb677b','@lib/jquery-touch-events'),('4d0fe2','@runtime/assets/thumbs/89'),('4d759b7b','@app/web/assets/plugins/dist'),('4d8694d5','@bower/jquery/dist'),('4d9be93a','@app/web/assets/matrixsettings/dist'),('4e14766b','@lib/d3'),('4e5197f9','@lib/element-resize-detector'),('4ed5b0e2','@runtime/assets/thumbs/11'),('4f5112ec','@runtime/assets/thumbs/35'),('5207fd76','@craft/web/assets/recententries/dist'),('522f04c3','@runtime/assets/thumbs/96'),('52421f7e','@runtime/assets/thumbs/3'),('52688801','@craft/web/assets/craftsupport/dist'),('53a75a47','@lib/fileupload'),('54af6eb','@app/web/assets/cp/dist'),('585957c4','@lib/fileupload'),('58ffaf0d','@craft/web/assets/dbbackup/dist'),('5984d5d4','@runtime/assets/thumbs/36'),('59ebfdf4','@lib'),('5a6e3fcc','@craft/web/assets/login/dist'),('5b6975dc','@runtime/assets/thumbs/3'),('5b74df3d','@craft/web/assets/matrixsettings/dist'),('5bc4bb29','@craft/web/assets/updater/dist'),('5c0963a8','@lib/velocity'),('5c2e37d6','@app/web/assets/clearcaches/dist'),('5c6e5f79','@runtime/assets/thumbs/6'),('5cc867a','@runtime/assets/thumbs/15'),('5fb93f22','@craft/web/assets/edituser/dist'),('6063e395','@app/web/assets/dashboard/dist'),('61c13c0c','@bower/jquery/dist'),('62163f20','@lib/element-resize-detector'),('6311b850','@lib/fabric'),('6418fe51','@craft/web/assets/editentry/dist'),('6440ffae','@runtime/assets/thumbs/6'),('6592eb43','@craft/web/assets/generalsettings/dist'),('6731b47a','@app/web/assets/utilities/dist'),('682a7c3e','@craft/web/assets/fields/dist'),('682e46ae','@runtime/assets/thumbs/3'),('68428aba','@craft/web/assets/editcategory/dist'),('686f0299','@mmikkel/cpfieldinspect/resources'),('68efb5d3','@lib/fabric'),('68f99488','@craft/web/assets/dashboard/dist'),('692d121','@lib/datepicker-i18n'),('694fe4dc','@lib/datepicker-i18n'),('6a01fc13','@app/web/assets/deprecationerrors/dist'),('6ad12567','@vendor/yiisoft/yii2/assets'),('6b9dee16','@app/web/assets/dashboard/dist'),('6c696499','@lib/jquery.payment'),('6cbdbf18','@craft/web/assets/updateswidget/dist'),('6cfac058','@app/web/assets/fields/dist'),('6d7db545','@craft/web/assets/feed/dist'),('6e1bda25','@app/web/assets/tablesettings/dist'),('6e67ff0b','@lib/jquery-ui'),('6efeae8a','@runtime/assets/thumbs/12'),('704ecb71','@lib/velocity'),('70ec43c0','@lib/selectize'),('727694ae','@rias/positionfieldtype/assetbundles/positionfieldtype/dist'),('738cc20e','@runtime/assets/thumbs/40'),('74fab25','@vendor/craftcms/redactor/lib/redactor-plugins/video'),('75ac552d','@lib'),('76576c6e','@lib/garnishjs'),('76c36689','@craft/web/assets/cp/dist'),('76d42000','@mmikkel/childme/resources'),('7732bd44','@runtime/assets/thumbs/16'),('7998121c','@runtime/assets/thumbs/13'),('7a80074a','@lib/xregexp'),('7c51bd55','@app/web/assets/feed/dist'),('7d6f6307','@craft/web/assets/updates/dist'),('7da961ed','@lib/garnishjs'),('7fb856f4','@craft/web/assets/pluginstore/dist'),('80227c1e','@runtime/assets/thumbs/35'),('8099c83a','@app/web/assets/updateswidget/dist'),('80f39883','@lib/garnishjs'),('846287f5','@app/web/assets/matrixsettings/dist'),('848cf5b4','@app/web/assets/plugins/dist'),('84bafc52','@rias/positionfieldtype/assetbundles/positionfieldtype/dist'),('856e65c2','@runtime/assets/thumbs/11'),('85b79188','@runtime/assets/thumbs/40'),('85f56978','@app/web/assets/craftsupport/dist'),('867dba57','@craft/web/assets/plugins/dist'),('87a8f936','@lib/element-resize-detector'),('8903790e','@craft/web/assets/updateswidget/dist'),('89e8766','@craft/web/assets/updateswidget/dist'),('8a0b68f8','@craft/web/assets/searchindexes/dist'),('8c8631f0','@lib/timepicker'),('8d47529e','@craft/web/assets/dashboard/dist'),('8d83b7d4','@craft/web/assets/plugins/dist'),('8d9f826','@app/web/assets/fields/dist'),('8dcaecb3','@vendor/craftcms/redactor/lib/redactor'),('8e0b64fb','@app/web/assets/craftsupport/dist'),('8f23985a','@runtime/assets/thumbs/12'),('9012933b','@lib'),('901472c9','@runtime/assets/thumbs/6'),('90274c2b','@craft/web/assets/feed/dist'),('918baf3d','@typedlinkfield/resources'),('928db1f2','@craft/web/assets/matrixsettings/dist'),('933d0665','@lib/jquery-ui'),('937da09f','@craft/web/assets/cp/dist'),('9420f09b','@runtime/assets/thumbs/3'),('955285d6','@lib/selectize'),('95708550','@craft/web/assets/fields/dist'),('95b54cbd','@lib/fabric'),('95d80a61','@runtime/assets/thumbs/40'),('964051ed','@craft/web/assets/edituser/dist'),('96bc6c91','@craft/web/assets/findreplace/dist'),('9820114e','@runtime/assets/thumbs/38'),('98c30be6','@lib/jquery-ui'),('9a0690e2','@craft/web/assets/pluginstore/dist'),('9bd941a8','@craft/web/assets/feed/dist'),('9bfe93b9','@craft/web/assets/recententries/dist'),('9c2c7909','@runtime/assets/thumbs/41'),('9c5d06cd','@runtime/assets/thumbs/16'),('9ca59499','@benf/embeddedassets/resources'),('9d22c6d','@runtime/assets/thumbs/12'),('9ee3d36e','@runtime/assets/thumbs/6'),('9f3ec15c','@lib/xregexp'),('a0b68a13','@lib/datepicker-i18n'),('a0c19929','@lib/timepicker'),('a0e179ed','@runtime/assets/thumbs/41'),('a2c07642','@runtime/assets/thumbs/14'),('a362d964','@runtime/assets/thumbs/38'),('a36eadd9','@app/web/assets/cp/dist'),('a4cc7cec','@craft/web/assets/craftsupport/dist'),('a503aeaa','@lib/fileupload'),('a544d1d7','@craft/web/assets/updateswidget/dist'),('a5900a56','@lib/jquery.payment'),('a734c6a2','@craft/web/assets/login/dist'),('a750b8a7','@app/web/assets/login/dist'),('a7e2b4ea','@app/web/assets/tablesettings/dist'),('a83852c3','@bower/jquery/dist'),('a890a05a','@app/web/assets/cp/dist'),('a8cb5d6d','@app/web/assets/plugins/dist'),('a8cd9830','@runtime/assets/thumbs/42'),('aa4649c9','@runtime/assets/thumbs/42'),('aa73464e','@runtime/assets/thumbs/13'),('aaaab204','@runtime/assets/thumbs/42'),('ab942132','@doublesecretagency/cpcss/resources'),('ac6b858c','@craft/web/assets/generalsettings/dist'),('acaeb524','@app/web/assets/login/dist'),('acf1a4d4','@runtime/assets/thumbs/87'),('add6c3bd','@runtime/assets/thumbs/42'),('ade1909e','@craft/web/assets/editentry/dist'),('ae03ff0f','@ether/splash/resources'),('aec8dab5','@app/web/assets/utilities/dist'),('aec90874','@app/web/assets/edituser/dist'),('aee9013','@craft/web/assets/login/dist'),('af32716f','@craft/web/assets/craftsupport/dist'),('b2c4bc62','@craft/web/assets/deprecationerrors/dist'),('b34e8f05','@lib/d3'),('b3796985','@lib/xregexp'),('b4960dc8','@craft/web/assets/updates/dist'),('b5489f53','@craft/web/assets/utilities/dist'),('b5a8d39a','@app/web/assets/feed/dist'),('b5dd87d7','@app/web/assets/recententries/dist'),('b641383b','@craft/web/assets/pluginstore/dist'),('b6a4b713','@runtime/assets/thumbs/36'),('b7b93b60','@craft/web/assets/recententries/dist'),('b7e31209','@runtime/assets/thumbs/3'),('b856e0f2','@app/web/assets/pluginstore/dist'),('b9152d0f','@lib/selectize'),('b9b7a5be','@lib/velocity'),('ba4f9396','@lib/jquery-touch-events'),('bbb281d6','@runtime/assets/thumbs/39'),('bcd4b7f3','@runtime/assets/thumbs/41'),('bd623725','@craft/web/assets/tablesettings/dist'),('bdebaf54','@lib/picturefill'),('be238a54','@app/web/assets/recententries/dist'),('bf3a0846','@craft/web/assets/cp/dist'),('bf470e2','@craft/web/assets/matrixsettings/dist'),('c094440','@craft/web/assets/fields/dist'),('c108914','@runtime/assets/thumbs/86'),('c12096e9','@app/web/assets/fields/dist'),('c12ca852','@lib/picturefill'),('c1544c2c','@craft/web/assets/matrix/dist'),('c1866e1d','@craft/web/assets/dbbackup/dist'),('c1b33228','@lib/jquery.payment'),('c1e49bc','@craft/web/assets/plugins/dist'),('c2bd7a39','@craft/web/assets/updater/dist'),('c317fedc','@craft/web/assets/login/dist'),('c3c18c94','@app/web/assets/tablesettings/dist'),('c40e9e19','@lib/prismjs'),('c4ea3b53','@runtime/assets/thumbs/96'),('c535e362','@lib/fabric'),('c5f02a8f','@craft/web/assets/fields/dist'),('c647b8a7','@app/web/assets/dashboard/dist'),('c6803c3f','@runtime/assets/thumbs/6'),('c6889490','@lib/jquery-touch-events'),('c7e5673e','@bower/jquery/dist'),('c88d8d5a','@app/web/assets/login/dist'),('c98f9855','@craft/web/assets/utilities/dist'),('c9c2a8e0','@craft/web/assets/editentry/dist'),('ca4d3fab','@lib/jquery.payment'),('caebe2cb','@app/web/assets/utilities/dist'),('cb114911','@craft/web/assets/craftsupport/dist'),('cb539a96','@runtime/assets/thumbs/37'),('cb7e3c66','@craft/web/assets/recententries/dist'),('cc1b6abd','@bower/jquery/dist'),('ccb39824','@app/web/assets/cp/dist'),('ccc8dad','@lib/fabric'),('ccf09a56','@runtime/assets/thumbs/39'),('cd63b64e','@modules/sitemodule/assetbundles/sitemodule/dist'),('ce1b7157','@runtime/assets/thumbs/14'),('cf898803','@lib/d3'),('d073375c','@lib/garnishjs'),('d18bebe4','@app/web/assets/feed/dist'),('d1febfa9','@app/web/assets/recententries/dist'),('d3e3e0cb','@runtime/assets/thumbs/15'),('d5cfff04','@yii/debug/assets'),('d66a9043','@lib/velocity'),('d6cdca2','@lib/datepicker-i18n'),('d6f5ff32','@runtime/assets/thumbs/15'),('d78bd50f','@app/web/assets/pluginstore/dist'),('d91def2e','@runtime/assets/thumbs/36'),('d95a200c','@martinherweg/craftgonzo/assetbundles/gonzo/dist'),('d9c4a9ac','@lib/fileupload'),('da75e667','@app/web/assets/feed/dist'),('dbaf8f2c','@runtime/assets/thumbs/3'),('dc069e2f','@lib/timepicker'),('dd6c0dd1','@runtime/assets/thumbs/38'),('dd949dc0','@lib/velocity'),('de65e6bc','@app/web/assets/assetindexes/dist'),('e041bf8b','@app/web/assets/matrixsettings/dist'),('e1d65106','@app/web/assets/craftsupport/dist'),('e22c46d','@app/web/assets/deprecationerrors/dist'),('e29a6763','@craft/web/assets/dashboard/dist'),('e38bc148','@lib/element-resize-detector'),('e3ce20da','@lib/d3'),('e3f9c65a','@lib/xregexp'),('e5c8308c','@craft/web/assets/utilities/dist'),('e6e17aa7','@app/web/assets/editentry/dist'),('e7a7e6c6','@craft/web/assets/userpermissions/dist'),('e84936c0','@lib/prismjs'),('e875cccb','@lib/element-resize-detector'),('e9646ae0','@craft/web/assets/dashboard/dist'),('e9724bbb','@lib/fabric'),('e99582d0','@lib/selectize'),('e9a08faa','@craft/web/assets/plugins/dist'),('e9c35893','@app/web/assets/matrix/dist'),('eacf3c49','@lib/jquery-touch-events'),('eb2f5eb9','@martinherweg/craftgonzo/assetbundles/gonzo/dist'),('ed13e4f5','@craft/web/assets/matrix/dist'),('ed6b008b','@lib/picturefill'),('ede298fa','@craft/web/assets/tablesettings/dist'),('ee672736','@benf/embeddedassets/resources'),('ee6d8305','@martinherweg/craftgonzo/assetbundles/gonzo/dist'),('ef44fdc7','@app/web/assets/updateswidget/dist'),('efbaa799','@craft/web/assets/cp/dist'),('efedb4e5','@runtime/assets/thumbs/88'),('f03625cc','@lib/datepicker-i18n'),('f0907133','@craft/redactor/assets/field/dist'),('f2a3a630','@mmikkel/childme/resources'),('f2f7b1a7','@runtime/assets/thumbs/38'),('f31b2e31','@runtime/assets/thumbs/15'),('f4047455','@craft/web/assets/feed/dist'),('f41db42d','@craft/web/assets/clearcaches/dist'),('f478c64','@runtime/assets/thumbs/3'),('f4a2feab','@craft/web/assets/assetindexes/dist'),('f5830175','@lib/fileupload'),('f62a16ee','@runtime/assets/thumbs/16'),('f6397dfd','@runtime/assets/thumbs/20'),('f6ae898c','@craft/web/assets/matrixsettings/dist'),('f71e3e1b','@lib/jquery-ui'),('f90f3784','@app/web/assets/dbbackup/dist'),('fbed668','@app/web/assets/dashboard/dist'),('fc349f85','@lib/garnishjs'),('ffa2b989','@bower/bootstrap/dist'),('ffcfa6c6','@lib');
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
INSERT INTO `searchindex` VALUES (1,'username',0,1,' superuser '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(1,'email',0,1,' hi wewereyoung de '),(1,'slug',0,1,''),(2,'slug',0,1,' homepage '),(2,'title',0,1,' home '),(2,'field',3,1,''),(168,'title',0,1,' weitere projekte '),(10,'slug',0,1,' alban '),(10,'title',0,1,' alban '),(64,'field',36,1,' http drissy test '),(64,'field',37,1,' 1 '),(64,'field',38,1,' home '),(64,'slug',0,1,''),(67,'field',36,1,' mailto hi wewereyoung de '),(67,'field',37,1,' 1 '),(67,'field',38,1,''),(67,'slug',0,1,''),(68,'field',25,1,' wewereyoung '),(68,'field',26,1,' pinnasberg '),(68,'field',27,1,' 20359 '),(68,'field',28,1,' hamburg '),(68,'field',29,1,' germany '),(68,'field',30,1,' hi wewereyoung com '),(68,'field',31,1,''),(68,'field',32,1,''),(68,'slug',0,1,''),(49,'field',9,1,' hi '),(49,'slug',0,1,''),(50,'field',9,1,' hi '),(50,'slug',0,1,''),(51,'field',9,1,' hi '),(51,'slug',0,1,''),(52,'field',9,1,' hi '),(52,'slug',0,1,''),(53,'field',9,1,' hi '),(53,'slug',0,1,''),(54,'field',9,1,' hi '),(54,'slug',0,1,''),(67,'field',48,1,''),(64,'field',48,1,' 1 '),(55,'slug',0,1,' commercial '),(55,'title',0,1,' commercial '),(56,'slug',0,1,' crack '),(56,'title',0,1,' crack '),(58,'field',24,1,' hamburg wewereyoung germany hi wewereyoung com 20359 pinnasberg '),(58,'slug',0,1,''),(59,'field',33,1,''),(59,'slug',0,1,''),(60,'field',34,1,''),(60,'slug',0,1,''),(61,'field',35,1,' home 1 http drissy test 1 1 mailto hi wewereyoung de '),(61,'slug',0,1,''),(62,'field',39,1,''),(62,'slug',0,1,''),(63,'field',40,1,''),(63,'slug',0,1,''),(24,'slug',0,1,' wes hicks '),(24,'title',0,1,' wes hicks '),(74,'slug',0,1,' crime '),(74,'title',0,1,' crime '),(168,'slug',0,1,' weitere projekte '),(108,'title',0,1,' shop '),(108,'slug',0,1,' shop '),(77,'slug',0,1,' drama '),(77,'title',0,1,' drama '),(108,'field',50,1,''),(108,'field',51,1,''),(108,'field',52,1,''),(107,'title',0,1,' news '),(107,'slug',0,1,' news '),(205,'field',52,1,''),(205,'field',51,1,''),(205,'slug',0,1,' news artikel 4 '),(96,'title',0,1,' photo 1528280469494 bc0421abebab '),(82,'slug',0,1,' trash '),(82,'title',0,1,' trash '),(83,'slug',0,1,' gamble '),(83,'title',0,1,' gamble '),(96,'kind',0,1,' image '),(96,'slug',0,1,''),(96,'extension',0,1,' jpeg '),(96,'filename',0,1,' photo 1528280469494 bc0421abebab jpeg '),(154,'field',50,1,''),(154,'field',51,1,''),(154,'field',52,1,''),(154,'slug',0,1,' schweiz '),(154,'title',0,1,' schweiz '),(155,'field',50,1,''),(155,'field',51,1,''),(155,'field',52,1,''),(155,'slug',0,1,' afrika '),(155,'title',0,1,' afrika '),(166,'title',0,1,' buro '),(167,'slug',0,1,' gastro '),(107,'field',52,1,''),(107,'field',51,1,''),(107,'field',50,1,''),(152,'field',50,1,''),(152,'field',51,1,''),(92,'field',9,1,''),(92,'slug',0,1,''),(93,'field',9,1,''),(93,'slug',0,1,''),(2,'field',50,1,' asfsafasfsdf '),(2,'field',52,1,' safasdfsdfsdfsdfsdfsdfsdfsdfsdfsdf '),(2,'field',51,1,''),(205,'field',50,1,''),(169,'slug',0,1,' infrastruktur '),(151,'field',52,1,''),(151,'slug',0,1,' uber uns '),(169,'title',0,1,' infrastruktur '),(170,'slug',0,1,' bildung '),(151,'field',50,1,''),(151,'field',51,1,''),(170,'title',0,1,' bildung '),(205,'title',0,1,' news artikel 4 '),(206,'field',52,1,''),(206,'field',53,1,''),(206,'field',6,1,''),(206,'field',50,1,''),(149,'field',50,1,''),(149,'field',51,1,''),(172,'title',0,1,' sanitation hygiene '),(149,'slug',0,1,' datenschutz '),(149,'field',52,1,''),(152,'title',0,1,' wasserwissen '),(149,'title',0,1,' datenschutz '),(172,'slug',0,1,' sanitation hygiene '),(152,'field',52,1,''),(152,'slug',0,1,' wasserwissen '),(151,'title',0,1,' uber uns '),(206,'field',51,1,''),(206,'title',0,1,' news artikel 5 '),(206,'slug',0,1,' news artikel 5 '),(167,'title',0,1,' gastro '),(153,'title',0,1,' was wir machen '),(153,'slug',0,1,' was wir machen '),(153,'field',52,1,''),(153,'field',51,1,''),(153,'field',50,1,''),(114,'field',50,1,''),(114,'field',51,1,''),(114,'field',52,1,''),(114,'slug',0,1,' mitmachen '),(114,'title',0,1,' partner werden '),(115,'field',50,1,''),(115,'field',51,1,''),(115,'field',52,1,''),(115,'slug',0,1,' spenden '),(115,'title',0,1,' spenden '),(116,'field',50,1,''),(116,'field',51,1,''),(116,'field',52,1,''),(116,'slug',0,1,' gonnerclub '),(116,'title',0,1,' gonnerclub '),(117,'field',50,1,''),(117,'field',51,1,''),(117,'field',52,1,''),(117,'slug',0,1,' gastropartner '),(117,'title',0,1,' gastropartner '),(118,'field',50,1,''),(118,'field',51,1,''),(118,'field',52,1,''),(118,'slug',0,1,' buropartner '),(118,'title',0,1,' buropartner '),(119,'field',50,1,''),(119,'field',51,1,''),(119,'field',52,1,''),(119,'slug',0,1,' freunde '),(119,'title',0,1,' freunde '),(120,'field',50,1,''),(120,'field',51,1,''),(120,'field',52,1,''),(120,'slug',0,1,' crowdfunding '),(120,'title',0,1,' crowdfunding '),(207,'field',52,1,''),(207,'field',51,1,''),(174,'field',52,1,''),(174,'slug',0,1,' spenden '),(174,'title',0,1,' spenden '),(207,'field',6,1,''),(207,'field',50,1,''),(174,'field',51,1,''),(148,'title',0,1,' impressum '),(148,'slug',0,1,' impressum '),(160,'slug',0,1,' aufklarung '),(148,'field',50,1,''),(148,'field',51,1,''),(148,'field',52,1,''),(129,'field',8,1,''),(129,'field',6,1,''),(129,'slug',0,1,' aufklarung '),(129,'title',0,1,' aufklarung '),(174,'field',50,1,''),(215,'slug',0,1,' projekt schweiz 2 '),(214,'field',61,1,''),(147,'title',0,1,' unsere partner '),(147,'slug',0,1,' unsere partner '),(214,'slug',0,1,' projekt schweiz 1 '),(133,'field',8,1,''),(133,'field',6,1,''),(133,'slug',0,1,' gastro '),(133,'title',0,1,' gastro '),(214,'title',0,1,' projekt schweiz 1 '),(215,'field',61,1,''),(147,'field',52,1,''),(147,'field',51,1,''),(147,'field',50,1,''),(158,'field',50,1,''),(160,'field',50,1,''),(160,'field',51,1,''),(160,'field',52,1,''),(159,'field',52,1,''),(159,'field',51,1,''),(159,'field',50,1,''),(160,'title',0,1,' aufklarung '),(159,'title',0,1,' sensibilisierung '),(159,'slug',0,1,' sensibilisierung '),(162,'title',0,1,' lander '),(162,'slug',0,1,' lander '),(162,'field',52,1,''),(162,'field',51,1,''),(162,'field',50,1,''),(161,'title',0,1,' leitungswasser fordern '),(161,'slug',0,1,' leitungswasser fordern '),(161,'field',52,1,''),(161,'field',51,1,''),(161,'field',50,1,''),(163,'field',52,1,''),(163,'field',51,1,''),(163,'field',50,1,''),(166,'slug',0,1,' buro '),(208,'slug',0,1,' projekt afrika 1 '),(208,'title',0,1,' projekt afrika 1 '),(164,'title',0,1,' mosambique '),(164,'slug',0,1,' mosambique '),(164,'field',52,1,''),(164,'field',51,1,''),(164,'field',50,1,''),(163,'title',0,1,' sambia '),(163,'slug',0,1,' sambia '),(158,'title',0,1,' tatigkeiten '),(158,'slug',0,1,' tatigkeiten '),(158,'field',52,1,''),(158,'field',51,1,''),(207,'slug',0,1,' news artikel 6 '),(207,'field',53,1,''),(205,'field',6,1,''),(204,'slug',0,1,' news artikel 3 '),(205,'field',53,1,''),(204,'title',0,1,' news artikel 3 '),(204,'field',51,1,''),(204,'field',52,1,''),(204,'field',53,1,''),(204,'field',50,1,''),(204,'field',6,1,''),(203,'title',0,1,' news artikel 2 '),(203,'slug',0,1,' news artikel 2 '),(203,'field',50,1,''),(203,'field',51,1,''),(203,'field',52,1,''),(203,'field',6,1,''),(203,'field',53,1,''),(184,'title',0,1,' buro partner 2 '),(184,'slug',0,1,' buro partner 2 '),(183,'slug',0,1,' buro partner 1 '),(183,'title',0,1,' buro partner 1 '),(185,'slug',0,1,' buro partner 3 '),(185,'title',0,1,' buro partner 3 '),(187,'title',0,1,' buro partner 4 '),(187,'slug',0,1,' buro partner 4 '),(188,'slug',0,1,' buro partner 5 '),(188,'title',0,1,' buro partner 5 '),(189,'slug',0,1,' buro partner 6 '),(189,'title',0,1,' buro partner 6 '),(190,'slug',0,1,' gastro partner 1 '),(190,'title',0,1,' gastro partner 1 '),(191,'slug',0,1,' gastro partner 2 '),(191,'title',0,1,' gastro partner 2 '),(192,'slug',0,1,' gastro partner 3 '),(192,'title',0,1,' gastro partner 3 '),(193,'slug',0,1,' gastro partner 4 '),(193,'title',0,1,' gastro partner 4 '),(194,'slug',0,1,' gastro partner 5 '),(194,'title',0,1,' gastro partner 5 '),(195,'slug',0,1,' gastro partner 6 '),(195,'title',0,1,' gastro partner 6 '),(196,'slug',0,1,' service partner 1 '),(196,'title',0,1,' service partner 1 '),(197,'slug',0,1,' service partner 2 '),(197,'title',0,1,' service partner 2 '),(198,'slug',0,1,' service partner 3 '),(198,'title',0,1,' service partner 3 '),(199,'slug',0,1,' service partner 4 '),(199,'title',0,1,' service partner 4 '),(200,'slug',0,1,' service partner 5 '),(200,'title',0,1,' service partner 5 '),(201,'slug',0,1,' service partner 6 '),(201,'title',0,1,' service partner 6 '),(202,'field',53,1,''),(202,'field',6,1,''),(202,'field',50,1,''),(202,'field',52,1,''),(202,'field',51,1,''),(202,'slug',0,1,' news artikel 1 '),(202,'title',0,1,' news artikel 1 '),(207,'title',0,1,' news artikel 6 '),(209,'slug',0,1,' projekt afrika 2 '),(209,'title',0,1,' projekt afrika 2 '),(210,'slug',0,1,' projekt afrika 3 '),(210,'title',0,1,' projekt afrika 3 '),(211,'slug',0,1,' projekt afrika 4 '),(211,'title',0,1,' projekt afrika 4 '),(212,'slug',0,1,' projekt afrika 5 '),(212,'title',0,1,' projekt afrika 5 '),(213,'slug',0,1,' projekt afrika 6 '),(213,'title',0,1,' projekt afrika 6 '),(215,'title',0,1,' projekt schweiz 2 '),(216,'field',61,1,''),(216,'slug',0,1,' projekt schweiz 3 '),(216,'title',0,1,' projekt schweiz 3 '),(217,'field',61,1,''),(217,'slug',0,1,' projekt schweiz 4 '),(217,'title',0,1,' projekt schweiz 4 '),(218,'field',61,1,''),(218,'slug',0,1,' projekt schweiz 5 '),(218,'title',0,1,' projekt schweiz 5 '),(219,'field',61,1,''),(219,'slug',0,1,' projekt schweiz 6 '),(219,'title',0,1,' projekt schweiz 6 ');
/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections` VALUES (2,NULL,'Home','home','single',1,1,'2018-05-02 13:44:01','2018-06-06 14:31:54','067c114d-4f7a-4716-b308-0dfefa1de9e5'),(7,NULL,'News','news','channel',1,1,'2018-06-05 21:37:22','2018-06-05 21:38:32','4d512d40-5b80-49c4-bd37-8240de387272'),(8,1,'Pages','pages','structure',1,1,'2018-06-06 14:32:06','2018-06-07 13:13:15','dd31bc7d-618b-4c8b-b955-615b311875ec'),(13,NULL,'Partner - Gastro','partnerGastro','channel',1,1,'2018-06-07 10:23:33','2018-06-07 10:23:33','c98fd3ad-9a6f-4064-a638-501921260567'),(14,NULL,'Partner - Service','partnerService','channel',1,1,'2018-06-07 10:24:42','2018-06-07 10:24:42','58ac0e7a-3cf1-4439-8eaa-a6330fd2ba6e'),(15,NULL,'Partner - Büro','partnerBuero','channel',1,1,'2018-06-07 10:25:12','2018-06-07 10:25:12','38919a22-e37e-4244-b285-4e4995f330d7'),(17,NULL,'Projekte - Schweiz','projekteSchweiz','channel',1,1,'2018-06-07 13:12:51','2018-06-07 13:22:46','5697ba67-c06c-4ac2-b673-0f16a13c2b52'),(18,NULL,'Projekte - Afrika','projekteAfrika','channel',1,1,'2018-06-07 13:13:33','2018-06-07 13:22:54','046b1145-7eb8-4ff0-9c4f-a1a73bfada04');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections_sites`
--

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections_sites` VALUES (2,2,1,1,'__home__','index',1,'2018-05-02 13:44:01','2018-06-06 14:31:54','e34b5f15-4657-46f7-949f-41794808245b'),(7,7,1,1,'news/{postDate|date(\"Y\")}/{postDate|date(\"m\")}/{slug}','_entry',1,'2018-06-05 21:37:22','2018-06-05 21:38:32','6535fb61-5275-43a7-b58a-862f6271a050'),(8,8,1,1,'{entry.last().uri}/{parent.uri}/{slug}','_entry',1,'2018-06-06 14:32:06','2018-06-07 13:13:15','8c333b77-ce45-452b-8798-655fa920ce90'),(13,13,1,1,'partner-gastro/{slug}','_entry',1,'2018-06-07 10:23:33','2018-06-07 10:23:33','0dd893ea-5bb4-4a00-a3d1-31f28ae5b1a5'),(14,14,1,1,'partner-service/{slug}','_entry',1,'2018-06-07 10:24:42','2018-06-07 10:24:42','165d1601-563d-4d3e-bd7b-c114bbfc821b'),(15,15,1,1,'partner-buero/{slug}','partner-buero/_entry',1,'2018-06-07 10:25:12','2018-06-07 10:25:12','77927f78-006a-44c9-861d-95e9cbf7c81b'),(17,17,1,1,'{entry.last().uri}/{parent.uri}/{slug}','_entry',1,'2018-06-07 13:12:51','2018-06-07 13:22:46','52b40517-ea02-44fc-a7fd-30b61626325f'),(18,18,1,1,'{entry.last().uri}/{parent.uri}/{slug}','_entry',1,'2018-06-07 13:13:33','2018-06-07 13:22:54','7a5dd6f2-174d-419e-96de-6d19cf293751');
/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `seomatic_metabundles`
--

LOCK TABLES `seomatic_metabundles` WRITE;
/*!40000 ALTER TABLE `seomatic_metabundles` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `seomatic_metabundles` VALUES (1,'2018-06-04 09:27:17','2018-06-04 09:27:17','59035b0e-02a2-4845-b4dc-82161cf107d4','1.0.28','__GLOBAL_BUNDLE__',1,'__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__','',1,'[]','2018-06-04 09:27:17','{\"language\":null,\"mainEntityOfPage\":\"WebSite\",\"seoTitle\":\"\",\"siteNamePosition\":\"before\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{{ craft.app.request.pathInfo }}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"none\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"none\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"drissy\",\"identity\":{\"siteType\":\"Organization\",\"siteSubType\":\"LocalBusiness\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"\",\"genericAlternateName\":\"\",\"genericDescription\":\"\",\"genericUrl\":\"\",\"genericImage\":\"\",\"genericImageWidth\":\"\",\"genericImageHeight\":\"\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"\",\"genericAddressRegion\":\"\",\"genericPostalCode\":\"\",\"genericAddressCountry\":\"\",\"genericGeoLatitude\":\"\",\"genericGeoLongitude\":\"\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"\",\"organizationFoundingDate\":\"\",\"organizationFoundingLocation\":\"\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"creator\":{\"siteType\":\"Organization\",\"siteSubType\":\"LocalBusiness\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"\",\"genericAlternateName\":\"\",\"genericDescription\":\"\",\"genericUrl\":\"\",\"genericImage\":\"\",\"genericImageWidth\":\"\",\"genericImageHeight\":\"\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"\",\"genericAddressRegion\":\"\",\"genericPostalCode\":\"\",\"genericAddressCountry\":\"\",\"genericGeoLatitude\":\"\",\"genericGeoLongitude\":\"\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"\",\"organizationFoundingDate\":\"\",\"organizationFoundingLocation\":\"\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":{\"twitter\":{\"siteName\":\"Twitter\",\"handle\":\"twitter\",\"url\":\"\"},\"facebook\":{\"siteName\":\"Facebook\",\"handle\":\"facebook\",\"url\":\"\"},\"wikipedia\":{\"siteName\":\"Wikipedia\",\"handle\":\"wikipedia\",\"url\":\"\"},\"linkedin\":{\"siteName\":\"LinkedIn\",\"handle\":\"linkedin\",\"url\":\"\"},\"googleplus\":{\"siteName\":\"Google+\",\"handle\":\"googleplus\",\"url\":\"\"},\"youtube\":{\"siteName\":\"YouTube\",\"handle\":\"youtube\",\"url\":\"\"},\"instagram\":{\"siteName\":\"Instagram\",\"handle\":\"instagram\",\"url\":\"\"},\"pinterest\":{\"siteName\":\"Pinterest\",\"handle\":\"pinterest\",\"url\":\"\"},\"github\":{\"siteName\":\"GitHub\",\"handle\":\"github\",\"url\":\"\"},\"vimeo\":{\"siteName\":\"Vimeo\",\"handle\":\"vimeo\",\"url\":\"\"}},\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\"}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":{\"generator\":{\"charset\":\"\",\"content\":\"SEOmatic\",\"httpEquiv\":\"\",\"name\":\"generator\",\"property\":null,\"include\":true,\"key\":\"generator\",\"environment\":null,\"dependencies\":null},\"keywords\":{\"charset\":\"\",\"content\":\"{seomatic.meta.seoKeywords}\",\"httpEquiv\":\"\",\"name\":\"keywords\",\"property\":null,\"include\":true,\"key\":\"keywords\",\"environment\":null,\"dependencies\":null},\"description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.seoDescription}\",\"httpEquiv\":\"\",\"name\":\"description\",\"property\":null,\"include\":true,\"key\":\"description\",\"environment\":null,\"dependencies\":null},\"referrer\":{\"charset\":\"\",\"content\":\"no-referrer-when-downgrade\",\"httpEquiv\":\"\",\"name\":\"referrer\",\"property\":null,\"include\":true,\"key\":\"referrer\",\"environment\":null,\"dependencies\":null},\"robots\":{\"charset\":\"\",\"content\":\"none\",\"httpEquiv\":\"\",\"name\":\"robots\",\"property\":null,\"include\":true,\"key\":\"robots\",\"environment\":{\"live\":{\"content\":\"{seomatic.meta.robots}\"},\"staging\":{\"content\":\"none\"},\"local\":{\"content\":\"none\"}},\"dependencies\":null}},\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaTagContaineropengraph\":{\"data\":{\"fb:profile_id\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookProfileId}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:profile_id\",\"include\":true,\"key\":\"fb:profile_id\",\"environment\":null,\"dependencies\":null},\"fb:app_id\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookAppId}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:app_id\",\"include\":true,\"key\":\"fb:app_id\",\"environment\":null,\"dependencies\":null},\"og:locale\":{\"charset\":\"\",\"content\":\"{{ craft.app.language }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale\",\"include\":true,\"key\":\"og:locale\",\"environment\":null,\"dependencies\":null},\"og:locale:alternate\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale:alternate\",\"include\":true,\"key\":\"og:locale:alternate\",\"environment\":null,\"dependencies\":null},\"og:type\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogType}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:type\",\"include\":true,\"key\":\"og:type\",\"environment\":null,\"dependencies\":null},\"og:url\":{\"charset\":\"\",\"content\":\"{seomatic.meta.canonicalUrl}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:url\",\"include\":true,\"key\":\"og:url\",\"environment\":null,\"dependencies\":null},\"og:title\":{\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.ogSiteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"charset\":\"\",\"content\":\"{seomatic.meta.ogTitle}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:title\",\"include\":true,\"key\":\"og:title\",\"environment\":null,\"dependencies\":null},\"og:description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogDescription}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:description\",\"include\":true,\"key\":\"og:description\",\"environment\":null,\"dependencies\":null},\"og:image\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImage}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image\",\"include\":true,\"key\":\"og:image\",\"environment\":null,\"dependencies\":null},\"og:image:alt\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageDescription}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:alt\",\"include\":true,\"key\":\"og:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]}},\"og:see_also\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:see_also\",\"include\":true,\"key\":\"og:see_also\",\"environment\":null,\"dependencies\":null}},\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[]},\"MetaTagContainertwitter\":{\"data\":{\"twitter:card\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterCard}\",\"httpEquiv\":\"\",\"name\":\"twitter:card\",\"property\":null,\"include\":true,\"key\":\"twitter:card\",\"environment\":null,\"dependencies\":null},\"twitter:site\":{\"charset\":\"\",\"content\":\"@{seomatic.site.twitterHandle}\",\"httpEquiv\":\"\",\"name\":\"twitter:site\",\"property\":null,\"include\":true,\"key\":\"twitter:site\",\"environment\":null,\"dependencies\":{\"site\":[\"twitterHandle\"]}},\"twitter:creator\":{\"charset\":\"\",\"content\":\"@{seomatic.meta.twitterCreator}\",\"httpEquiv\":\"\",\"name\":\"twitter:creator\",\"property\":null,\"include\":true,\"key\":\"twitter:creator\",\"environment\":null,\"dependencies\":{\"meta\":[\"twitterCreator\"]}},\"twitter:title\":{\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.twitterSiteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"charset\":\"\",\"content\":\"{seomatic.meta.twitterTitle}\",\"httpEquiv\":\"\",\"name\":\"twitter:title\",\"property\":null,\"include\":true,\"key\":\"twitter:title\",\"environment\":null,\"dependencies\":null},\"twitter:description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterDescription}\",\"httpEquiv\":\"\",\"name\":\"twitter:description\",\"property\":null,\"include\":true,\"key\":\"twitter:description\",\"environment\":null,\"dependencies\":null},\"twitter:image\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImage}\",\"httpEquiv\":\"\",\"name\":\"twitter:image\",\"property\":null,\"include\":true,\"key\":\"twitter:image\",\"environment\":null,\"dependencies\":null},\"twitter:image:alt\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageDescription}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:alt\",\"property\":null,\"include\":true,\"key\":\"twitter:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]}}},\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":{\"site\":[\"twitterHandle\"]}},\"MetaTagContainermiscellaneous\":{\"data\":{\"google-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.googleSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"google-site-verification\",\"property\":null,\"include\":true,\"key\":\"google-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"googleSiteVerification\"]}},\"bing-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.bingSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"msvalidate.01\",\"property\":null,\"include\":true,\"key\":\"bing-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"bingSiteVerification\"]}},\"pinterest-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.pinterestSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"p:domain_verify\",\"property\":null,\"include\":true,\"key\":\"pinterest-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"pinterestSiteVerification\"]}}},\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[]},\"MetaLinkContainergeneral\":{\"data\":{\"canonical\":{\"crossorigin\":\"\",\"href\":\"{seomatic.meta.canonicalUrl}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"canonical\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"canonical\",\"environment\":null,\"dependencies\":null},\"home\":{\"crossorigin\":\"\",\"href\":\"{{ siteUrl }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"home\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"home\",\"environment\":null,\"dependencies\":null},\"author\":{\"crossorigin\":\"\",\"href\":\"{{ url(\\\"/humans.txt\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"author\",\"sizes\":\"\",\"type\":\"text/plain\",\"include\":true,\"key\":\"author\",\"environment\":null,\"dependencies\":{\"frontend_template\":[\"humans\"]}},\"publisher\":{\"crossorigin\":\"\",\"href\":\"{seomatic.site.googlePublisherLink}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"publisher\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"publisher\",\"environment\":null,\"dependencies\":{\"site\":[\"googlePublisherLink\"]}}},\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaScriptContainergeneral\":{\"data\":{\"googleAnalytics\":{\"name\":\"Google Analytics\",\"description\":\"Google Analytics gives you the digital analytics tools you need to analyze data from all touchpoints in one place, for a deeper understanding of the customer experience. You can then share the insights that matter with your whole organization. [Learn More](https://www.google.com/analytics/analytics/)\",\"templatePath\":\"_frontend/scripts/googleAnalytics.twig\",\"templateString\":\"{% if trackingId.value is defined and trackingId.value %}\\n(function(i,s,o,g,r,a,m){i[\'GoogleAnalyticsObject\']=r;i[r]=i[r]||function(){\\n(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),\\nm=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)\\n})(window,document,\'script\',\'{{ analyticsUrl.value }}\',\'ga\');\\nga(\'create\', \'{{ trackingId.value |raw }}\', \'auto\'{% if linker.value %}, {allowLinker: true}{% endif %});\\n{% if ipAnonymization.value %}\\nga(\'set\', \'anonymizeIp\', true);\\n{% endif %}\\n{% if displayFeatures.value %}\\nga(\'require\', \'displayfeatures\');\\n{% endif %}\\n{% if ecommerce.value %}\\nga(\'require\', \'ecommerce\');\\n{% endif %}\\n{% if enhancedEcommerce.value %}\\nga(\'require\', \'ec\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linkid\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linker\');\\n{% endif %}\\n{% if sendPageView.value %}\\nga(\'send\', \'pageview\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyPosition\":2,\"vars\":{\"trackingId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Google Analytics PageView\",\"instructions\":\"Controls whether the Google Analytics script automatically sends a PageView to Google Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"When a customer of Analytics requests IP address anonymization, Analytics anonymizes the address as soon as technically feasible at the earliest possible stage of the collection network.\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Display Features\",\"instructions\":\"The display features plugin for analytics.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/display-features)\",\"type\":\"bool\",\"value\":false},\"ecommerce\":{\"title\":\"Ecommerce\",\"instructions\":\"Ecommerce tracking allows you to measure the number of transactions and revenue that your website generates. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedEcommerce\":{\"title\":\"Enhanced Ecommerce\",\"instructions\":\"The enhanced ecommerce plug-in for analytics.js enables the measurement of user interactions with products on ecommerce websites across the user\'s shopping experience, including: product impressions, product clicks, viewing product details, adding a product to a shopping cart, initiating the checkout process, transactions, and refunds. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Enhanced Link Attribution\",\"instructions\":\"Enhanced Link Attribution improves the accuracy of your In-Page Analytics report by automatically differentiating between multiple links to the same URL on a single page by using link element IDs. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"linker\":{\"title\":\"Linker\",\"instructions\":\"The linker plugin simplifies the process of implementing cross-domain tracking as described in the Cross-domain Tracking guide for analytics.js. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/linker)\",\"type\":\"bool\",\"value\":false},\"analyticsUrl\":{\"title\":\"Google Analytics Script URL\",\"instructions\":\"The URL to the Google Analytics tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"//www.google-analytics.com/analytics.js\"}},\"include\":false,\"key\":\"googleAnalytics\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"gtag\":{\"name\":\"Google gtag.js\",\"description\":\"The global site tag (gtag.js) is a JavaScript tagging framework and API that allows you to send event data to AdWords, DoubleClick, and Google Analytics. Instead of having to manage multiple tags for different products, you can use gtag.js and more easily benefit from the latest tracking features and integrations as they become available. [Learn More](https://developers.google.com/gtagjs/)\",\"templatePath\":\"_frontend/scripts/gtagHead.twig\",\"templateString\":\"{% set gtagProperty = googleAnalyticsId.value ?? googleAdWordsId.value ?? dcFloodlightId.value ?? null %}\\n{% if gtagProperty %}\\nwindow.dataLayer = window.dataLayer || [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\nfunction gtag(){dataLayer.push(arguments)};\\ngtag(\'js\', new Date());\\n{% if googleAnalyticsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{sendPageView.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'anonymize_ip\': #{ipAnonymization.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'link_attribution\': #{enhancedLinkAttribution.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'allow_display_features\': #{displayFeatures.value ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAnalyticsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if googleAdWordsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{sendPageView.value ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAdWordsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if dcFloodlightId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{sendPageView.value ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ dcFloodlightId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/gtagBody.twig\",\"bodyPosition\":2,\"vars\":{\"googleAnalyticsId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"googleAdWordsId\":{\"title\":\"AdWords Conversion ID\",\"instructions\":\"Only enter the ID, e.g.: `AW-XXXXXXXX`, not the entire script code. [Learn More](https://developers.google.com/adwords-remarketing-tag/)\",\"type\":\"string\",\"value\":\"\"},\"dcFloodlightId\":{\"title\":\"DoubleClick Floodlight ID\",\"instructions\":\"Only enter the ID, e.g.: `DC-XXXXXXXX`, not the entire script code. [Learn More](https://support.google.com/dcm/partner/answer/7568534)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send PageView\",\"instructions\":\"Controls whether the `gtag.js` script automatically sends a PageView to Google Analytics, AdWords, and DoubleClick Floodlight when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"In some cases, you might need to anonymize the IP addresses of hits sent to Google Analytics. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/ip-anonymization)\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Google Analytics Display Features\",\"instructions\":\"The display features plugin for gtag.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/display-features)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Google Analytics Enhanced Link Attribution\",\"instructions\":\"Enhanced link attribution improves click track reporting by automatically differentiating between multiple link clicks that have the same URL on a given page. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"gtagScriptUrl\":{\"title\":\"Google gtag.js Script URL\",\"instructions\":\"The URL to the Google gtag.js tracking script. Normally this should not be changed, unless you locally cache it. The JavaScript `dataLayer` will automatically be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"//www.googletagmanager.com/gtag/js\"}},\"include\":false,\"key\":\"gtag\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"googleTagManager\":{\"name\":\"Google Tag Manager\",\"description\":\"Google Tag Manager is a tag management system that allows you to quickly and easily update tags and code snippets on your website. Once the Tag Manager snippet has been added to your website or mobile app, you can configure tags via a web-based user interface without having to alter and deploy additional code. [Learn More](https://support.google.com/tagmanager/answer/6102821?hl=en)\",\"templatePath\":\"_frontend/scripts/googleTagManagerHead.twig\",\"templateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value %}\\n{{ dataLayerVariableName.value }} = [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\n(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({\'gtm.start\':\\nnew Date().getTime(),event:\'gtm.js\'});var f=d.getElementsByTagName(s)[0],\\nj=d.createElement(s),dl=l!=\'dataLayer\'?\'&l=\'+l:\'\';j.async=true;j.src=\\n\'{{ googleTagManagerUrl.value }}?id=\'+i+dl;f.parentNode.insertBefore(j,f);\\n})(window,document,\'script\',\'{{ dataLayerVariableName.value }}\',\'{{ googleTagManagerId.value }}\');\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/googleTagManagerBody.twig\",\"bodyPosition\":2,\"vars\":{\"googleTagManagerId\":{\"title\":\"Google Tag Manager ID\",\"instructions\":\"Only enter the ID, e.g.: `GTM-XXXXXX`, not the entire script code. [Learn More](https://developers.google.com/tag-manager/quickstart)\",\"type\":\"string\",\"value\":\"\"},\"dataLayerVariableName\":{\"title\":\"DataLayer Variable Name\",\"instructions\":\"The name to use for the JavaScript DataLayer variable. The value of this variable will be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"dl\"},\"googleTagManagerUrl\":{\"title\":\"Google Tag Manager Script URL\",\"instructions\":\"The URL to the Google Tag Manager script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"//www.googletagmanager.com/gtm.js\"},\"googleTagManagerNoScriptUrl\":{\"title\":\"Google Tag Manager Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Google Tag Manager `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"//www.googletagmanager.com/ns.html\"}},\"include\":false,\"key\":\"googleTagManager\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"facebookPixel\":{\"name\":\"Facebook Pixel\",\"description\":\"The Facebook pixel is an analytics tool that helps you measure the effectiveness of your advertising. You can use the Facebook pixel to understand the actions people are taking on your website and reach audiences you care about. [Learn More](https://www.facebook.com/business/help/651294705016616)\",\"templatePath\":\"_frontend/scripts/facebookPixelHead.twig\",\"templateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?\\nn.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;\\nn.push=n;n.loaded=!0;n.version=\'2.0\';n.queue=[];t=b.createElement(e);t.async=!0;\\nt.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,\\ndocument,\'script\',\'{{ facebookPixelUrl.value }}\');\\nfbq(\'init\', \'{{ facebookPixelId.value }}\');\\n{% if sendPageView.value %}\\nfbq(\'track\', \'PageView\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/facebookPixelBody.twig\",\"bodyPosition\":2,\"vars\":{\"facebookPixelId\":{\"title\":\"Facebook Pixel ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://developers.facebook.com/docs/facebook-pixel/api-reference)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Facebook Pixel PageView\",\"instructions\":\"Controls whether the Facebook Pixel script automatically sends a PageView to Facebook Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"facebookPixelUrl\":{\"title\":\"Facebook Pixel Script URL\",\"instructions\":\"The URL to the Facebook Pixel script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"//connect.facebook.net/en_US/fbevents.js\"},\"facebookPixelNoScriptUrl\":{\"title\":\"Facebook Pixel Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Facebook Pixel `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"//www.facebook.com/tr\"}},\"include\":false,\"key\":\"facebookPixel\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null}},\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"issn\":null,\"about\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":null,\"creator\":{\"id\":\"{seomatic.site.creator.genericUrl}#creator\"},\"dateCreated\":null,\"dateModified\":null,\"datePublished\":null,\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"exampleOfWork\":null,\"expires\":null,\"fileFormat\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":null,\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"material\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":null,\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sourceOrganization\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.site.siteLinksQueryInput}\"},\"sameAs\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null},\"identity\":{\"actionableFeedbackPolicy\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{seomatic.site.identity.genericStreetAddress}\",\"addressLocality\":\"{seomatic.site.identity.genericAddressLocality}\",\"addressRegion\":\"{seomatic.site.identity.genericAddressRegion}\",\"postalCode\":\"{seomatic.site.identity.genericPostalCode}\",\"addressCountry\":\"{seomatic.site.identity.genericAddressCountry}\"},\"aggregateRating\":null,\"alumni\":null,\"areaServed\":null,\"award\":null,\"brand\":null,\"contactPoint\":null,\"correctionsPolicy\":null,\"department\":null,\"dissolutionDate\":null,\"diversityPolicy\":null,\"duns\":\"{seomatic.site.identity.organizationDuns}\",\"email\":\"{seomatic.site.identity.genericEmail}\",\"employee\":null,\"ethicsPolicy\":null,\"event\":null,\"faxNumber\":null,\"founder\":\"{seomatic.site.identity.organizationFounder}\",\"foundingDate\":\"{seomatic.site.identity.organizationFoundingDate}\",\"foundingLocation\":\"{seomatic.site.identity.organizationFoundingLocation}\",\"funder\":null,\"globalLocationNumber\":null,\"hasOfferCatalog\":null,\"hasPOS\":null,\"isicV4\":null,\"legalName\":null,\"leiCode\":null,\"location\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.identity.genericImage}\",\"width\":\"{seomatic.site.identity.genericImageWidth}\",\"height\":\"{seomatic.site.identity.genericImageHeight}\"},\"makesOffer\":null,\"member\":null,\"memberOf\":null,\"naics\":null,\"numberOfEmployees\":null,\"owns\":null,\"parentOrganization\":null,\"publishingPrinciples\":null,\"review\":null,\"seeks\":null,\"sponsor\":null,\"subOrganization\":null,\"taxID\":null,\"telephone\":\"{seomatic.site.identity.genericTelephone}\",\"unnamedSourcesPolicy\":null,\"vatID\":null,\"additionalType\":null,\"alternateName\":\"{seomatic.site.identity.genericAlternateName}\",\"description\":\"{seomatic.site.identity.genericDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.identity.genericImage}\",\"width\":\"{seomatic.site.identity.genericImageWidth}\",\"height\":\"{seomatic.site.identity.genericImageHeight}\"},\"mainEntityOfPage\":null,\"name\":\"{seomatic.site.identity.genericName}\",\"potentialAction\":null,\"sameAs\":null,\"url\":\"{seomatic.site.identity.genericUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.site.identity.computedType}\",\"id\":\"{seomatic.site.identity.genericUrl}#identity\",\"include\":true,\"key\":\"identity\",\"environment\":null,\"dependencies\":null},\"creator\":{\"actionableFeedbackPolicy\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{seomatic.site.creator.genericStreetAddress}\",\"addressLocality\":\"{seomatic.site.creator.genericAddressLocality}\",\"addressRegion\":\"{seomatic.site.creator.genericAddressRegion}\",\"postalCode\":\"{seomatic.site.creator.genericPostalCode}\",\"addressCountry\":\"{seomatic.site.creator.genericAddressCountry}\"},\"aggregateRating\":null,\"alumni\":null,\"areaServed\":null,\"award\":null,\"brand\":null,\"contactPoint\":null,\"correctionsPolicy\":null,\"department\":null,\"dissolutionDate\":null,\"diversityPolicy\":null,\"duns\":\"{seomatic.site.creator.organizationDuns}\",\"email\":\"{seomatic.site.creator.genericEmail}\",\"employee\":null,\"ethicsPolicy\":null,\"event\":null,\"faxNumber\":null,\"founder\":\"{seomatic.site.creator.organizationFounder}\",\"foundingDate\":\"{seomatic.site.creator.organizationFoundingDate}\",\"foundingLocation\":\"{seomatic.site.creator.organizationFoundingLocation}\",\"funder\":null,\"globalLocationNumber\":null,\"hasOfferCatalog\":null,\"hasPOS\":null,\"isicV4\":null,\"legalName\":null,\"leiCode\":null,\"location\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.creator.genericImage}\",\"width\":\"{seomatic.site.creator.genericImageWidth}\",\"height\":\"{seomatic.site.creator.genericImageHeight}\"},\"makesOffer\":null,\"member\":null,\"memberOf\":null,\"naics\":null,\"numberOfEmployees\":null,\"owns\":null,\"parentOrganization\":null,\"publishingPrinciples\":null,\"review\":null,\"seeks\":null,\"sponsor\":null,\"subOrganization\":null,\"taxID\":null,\"telephone\":\"{seomatic.site.creator.genericTelephone}\",\"unnamedSourcesPolicy\":null,\"vatID\":null,\"additionalType\":null,\"alternateName\":\"{seomatic.site.creator.genericAlternateName}\",\"description\":\"{seomatic.site.creator.genericDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.creator.genericImage}\",\"width\":\"{seomatic.site.creator.genericImageWidth}\",\"height\":\"{seomatic.site.creator.genericImageHeight}\"},\"mainEntityOfPage\":null,\"name\":\"{seomatic.site.creator.genericName}\",\"potentialAction\":null,\"sameAs\":null,\"url\":\"{seomatic.site.creator.genericUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.site.creator.computedType}\",\"id\":\"{seomatic.site.creator.genericUrl}#creator\",\"include\":true,\"key\":\"creator\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]}}','[]','{\"data\":{\"humans\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"/* TEAM */\\n\\nCreator: {{ seomatic.site.creator.genericName ?? \\\"n/a\\\" }}\\nURL: {{ seomatic.site.creator.genericUrl ?? \\\"n/a\\\" }}\\nDescription: {{ seomatic.site.creator.genericDescription ?? \\\"n/a\\\" }}\\n\\n/* THANKS */\\n\\nCraftCMS - https://craftcms.com\\nPixel & Tonic - https://pixelandtonic.com\\n\\n/* SITE */\\n\\nStandards: HTML5, CSS3\\nComponents: Craft CMS 3, Yii2, PHP, JavaScript, SEOmatic\\n\",\"siteId\":null,\"include\":true,\"handle\":\"humans\",\"path\":\"humans.txt\",\"template\":\"_frontend/pages/humans.twig\",\"controller\":\"frontend-template\",\"action\":\"humans\"},\"robots\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# robots.txt for {{ siteUrl }}\\n\\nSitemap: {{ seomatic.helper.sitemapIndexForSiteId() }}\\n{% switch seomatic.config.environment %}\\n\\n{% case \\\"live\\\" %}\\n\\n# live - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\n\\n{% case \\\"staging\\\" %}\\n\\n# staging - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% case \\\"local\\\" %}\\n\\n# local - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% default %}\\n\\n# default - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\n\\n{% endswitch %}\\n\",\"siteId\":null,\"include\":true,\"handle\":\"robots\",\"path\":\"robots.txt\",\"template\":\"_frontend/pages/robots.twig\",\"controller\":\"frontend-template\",\"action\":\"robots\"}},\"name\":\"Frontend Templates\",\"description\":\"Templates that are rendered on the frontend\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":\"SeomaticEditableTemplate\",\"include\":true,\"dependencies\":null}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebSite\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"fromCustom\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"fromCustom\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"fromCustom\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(4,'2018-06-04 09:27:17','2018-06-06 14:31:54','0ded9097-f24f-44ac-8f1b-2063cf354917','1.0.25','section',2,'Homepage','homepage','single','index',1,'{\"1\":{\"id\":\"2\",\"sectionId\":\"2\",\"siteId\":\"1\",\"enabledByDefault\":\"1\",\"hasUrls\":\"1\",\"uriFormat\":\"__home__\",\"template\":\"index\",\"language\":\"en-us\"}}','2018-06-02 11:36:07','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{entry.title}\",\"siteNamePosition\":\"before\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{entry.url}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"none\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"none\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"drissy\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\"}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[]},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[]},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[]},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":\"{entry.postDate |atom}\",\"creator\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"dateCreated\":false,\"dateModified\":\"{entry.dateUpdated |atom}\",\"datePublished\":\"{entry.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"exampleOfWork\":null,\"expires\":null,\"fileFormat\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"material\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sourceOrganization\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.site.siteLinksQueryInput}\"},\"sameAs\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(6,'2018-06-05 21:37:22','2018-06-05 21:38:33','45899915-47e2-4e6d-b43a-417ed395c28e','1.0.25','section',7,'News','news','channel','_entry',1,'{\"1\":{\"id\":7,\"sectionId\":null,\"siteId\":\"1\",\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"news/{slug}\",\"template\":\"_entry\",\"language\":\"en-us\"}}','2018-06-05 21:37:22','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{entry.title}\",\"siteNamePosition\":\"before\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{entry.url}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"none\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"none\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"drissy\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\"}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[]},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[]},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[]},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":\"{entry.postDate |atom}\",\"creator\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"dateCreated\":false,\"dateModified\":\"{entry.dateUpdated |atom}\",\"datePublished\":\"{entry.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"exampleOfWork\":null,\"expires\":null,\"fileFormat\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"material\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sourceOrganization\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.site.siteLinksQueryInput}\"},\"sameAs\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(7,'2018-06-06 14:32:06','2018-06-07 13:13:15','b0bf206a-6fec-4938-b983-222912581e35','1.0.25','section',8,'Pages','pages','channel','_entry',1,'{\"1\":{\"id\":8,\"sectionId\":null,\"siteId\":\"1\",\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"{slug}\",\"template\":\"_entry\",\"language\":\"en-us\"}}','2018-06-06 14:32:06','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{entry.title}\",\"siteNamePosition\":\"before\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{entry.url}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"none\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"none\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"drissy\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\"}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[]},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[]},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[]},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":\"{entry.postDate |atom}\",\"creator\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"dateCreated\":false,\"dateModified\":\"{entry.dateUpdated |atom}\",\"datePublished\":\"{entry.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"exampleOfWork\":null,\"expires\":null,\"fileFormat\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"material\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sourceOrganization\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.site.siteLinksQueryInput}\"},\"sameAs\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(12,'2018-06-07 10:23:33','2018-06-07 10:23:33','9cc394fa-7273-4470-8309-7338341e7706','1.0.25','section',13,'Partner - Gastro','partnerGastro','channel','_entry',1,'{\"1\":{\"id\":13,\"sectionId\":null,\"siteId\":\"1\",\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"partner-gastro/{slug}\",\"template\":\"_entry\",\"language\":\"en-us\"}}','2018-06-07 10:23:33','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{entry.title}\",\"siteNamePosition\":\"before\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{entry.url}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"none\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"none\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"drissy\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\"}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[]},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[]},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[]},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":\"{entry.postDate |atom}\",\"creator\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"dateCreated\":false,\"dateModified\":\"{entry.dateUpdated |atom}\",\"datePublished\":\"{entry.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"exampleOfWork\":null,\"expires\":null,\"fileFormat\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"material\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sourceOrganization\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.site.siteLinksQueryInput}\"},\"sameAs\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(13,'2018-06-07 10:24:42','2018-06-07 10:24:43','c7fb0947-b50e-4f0d-b8d2-3ca7c6191b14','1.0.25','section',14,'Partner - Service','partnerService','channel','_entry',1,'{\"1\":{\"id\":14,\"sectionId\":null,\"siteId\":\"1\",\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"partner-service/{slug}\",\"template\":\"_entry\",\"language\":\"en-us\"}}','2018-06-07 10:24:43','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{entry.title}\",\"siteNamePosition\":\"before\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{entry.url}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"none\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"none\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"drissy\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\"}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[]},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[]},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[]},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":\"{entry.postDate |atom}\",\"creator\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"dateCreated\":false,\"dateModified\":\"{entry.dateUpdated |atom}\",\"datePublished\":\"{entry.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"exampleOfWork\":null,\"expires\":null,\"fileFormat\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"material\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sourceOrganization\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.site.siteLinksQueryInput}\"},\"sameAs\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(14,'2018-06-07 10:25:12','2018-06-07 10:25:12','cd0e6114-ac26-4ae9-9f0d-549bd5bfca35','1.0.25','section',15,'Partner - Büro','partnerBuero','channel','partner-buero/_entry',1,'{\"1\":{\"id\":15,\"sectionId\":null,\"siteId\":\"1\",\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"partner-buero/{slug}\",\"template\":\"partner-buero/_entry\",\"language\":\"en-us\"}}','2018-06-07 10:25:12','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{entry.title}\",\"siteNamePosition\":\"before\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{entry.url}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"none\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"none\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"drissy\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\"}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[]},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[]},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[]},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":\"{entry.postDate |atom}\",\"creator\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"dateCreated\":false,\"dateModified\":\"{entry.dateUpdated |atom}\",\"datePublished\":\"{entry.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"exampleOfWork\":null,\"expires\":null,\"fileFormat\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"material\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sourceOrganization\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.site.siteLinksQueryInput}\"},\"sameAs\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(16,'2018-06-07 13:12:51','2018-06-07 13:22:46','6aa889ca-8a78-4d68-9ffd-6fb77fb6cc55','1.0.25','section',17,'Projekte - Schweiz','projekteSchweiz','channel','projekte-schweiz/_entry',1,'{\"1\":{\"id\":17,\"sectionId\":null,\"siteId\":\"1\",\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"{% if level == 1 %}{section.handle}{% else %}{parent.uri}{% endif %}/{slug}\",\"template\":\"projekte-schweiz/_entry\",\"language\":\"en-us\"}}','2018-06-07 13:12:51','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{entry.title}\",\"siteNamePosition\":\"before\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{entry.url}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"none\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"none\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"drissy\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\"}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[]},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[]},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[]},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":\"{entry.postDate |atom}\",\"creator\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"dateCreated\":false,\"dateModified\":\"{entry.dateUpdated |atom}\",\"datePublished\":\"{entry.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"exampleOfWork\":null,\"expires\":null,\"fileFormat\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"material\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sourceOrganization\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.site.siteLinksQueryInput}\"},\"sameAs\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(17,'2018-06-07 13:13:33','2018-06-07 13:22:54','51fb1fea-af08-44a1-add2-c8dd0a49d910','1.0.25','section',18,'Projekte - Afrika','projekteAfrika','channel','projekte-afrika/_entry',1,'{\"1\":{\"id\":18,\"sectionId\":null,\"siteId\":\"1\",\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"{entry.last().uri}/{parent.uri}/{slug}\",\"template\":\"projekte-afrika/_entry\",\"language\":\"en-us\"}}','2018-06-07 13:13:33','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{entry.title}\",\"siteNamePosition\":\"before\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{entry.url}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"none\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"none\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"drissy\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\"}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[]},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[]},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[]},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":\"{entry.postDate |atom}\",\"creator\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"dateCreated\":false,\"dateModified\":\"{entry.dateUpdated |atom}\",\"datePublished\":\"{entry.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"exampleOfWork\":null,\"expires\":null,\"fileFormat\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"material\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sourceOrganization\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.site.siteLinksQueryInput}\"},\"sameAs\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(18,'2018-06-07 13:25:20','2018-06-07 13:25:38','47f95dbc-9509-48fa-8e15-c3e084611ddb','1.0.22','categorygroup',1,'ProjektTyp','projekttyp','category','projekttyp/_category',1,'{\"1\":{\"id\":1,\"groupId\":null,\"siteId\":\"1\",\"hasUrls\":true,\"uriFormat\":\"projekttyp/{slug}\",\"template\":\"projekttyp/_category\",\"language\":\"en-us\"}}','2018-06-07 13:25:20','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{category.title}\",\"siteNamePosition\":\"before\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{category.url}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"none\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"none\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"drissy\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\"}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[]},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[]},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[]},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":\"{category.postDate |atom}\",\"creator\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"dateCreated\":false,\"dateModified\":\"{category.dateUpdated |atom}\",\"datePublished\":\"{category.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"exampleOfWork\":null,\"expires\":null,\"fileFormat\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"material\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sourceOrganization\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.site.siteLinksQueryInput}\"},\"sameAs\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}');
/*!40000 ALTER TABLE `seomatic_metabundles` ENABLE KEYS */;
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
INSERT INTO `structureelements` VALUES (1,1,NULL,1,1,52,0,'2018-06-06 14:34:06','2018-06-07 13:36:35','56668bb7-3856-4b3d-bb7f-8918d36347a5'),(8,1,107,1,28,29,1,'2018-06-07 08:12:35','2018-06-07 13:36:06','e43987d2-da88-4af7-9b4f-24b82d9f2b91'),(9,1,108,1,30,31,1,'2018-06-07 08:12:47','2018-06-07 13:36:06','8c9acd6c-4312-45a8-ae35-38bcc1ae30b1'),(15,1,114,1,32,45,1,'2018-06-07 08:19:45','2018-06-07 13:36:06','1519b1bc-a6bd-4066-90b3-86096cbc0634'),(16,1,115,1,33,34,2,'2018-06-07 08:20:01','2018-06-07 13:36:06','ea5c1ab6-7fdf-483e-bb7d-9c9bc5a1561d'),(17,1,116,1,35,36,2,'2018-06-07 08:20:11','2018-06-07 13:36:06','46b417f9-6baf-4d5f-b554-02f5fd289407'),(18,1,117,1,37,38,2,'2018-06-07 08:20:20','2018-06-07 13:36:06','b2edab87-ab00-483d-8b63-d0cd7a1fecdf'),(19,1,118,1,39,40,2,'2018-06-07 08:20:30','2018-06-07 13:36:06','ba335861-5ec8-4c17-9fd4-e7584f49b0a2'),(20,1,119,1,41,42,2,'2018-06-07 08:20:44','2018-06-07 13:36:06','2fc13db4-8f33-479c-8bc0-8d3b9538a7c1'),(21,1,120,1,43,44,2,'2018-06-07 08:20:54','2018-06-07 13:36:06','32b8cd53-b53c-407c-a94f-0673314fde9b'),(46,1,147,1,22,23,1,'2018-06-07 12:55:54','2018-06-07 13:36:06','e7cc7e1c-8789-4c82-bddd-672858173354'),(47,1,148,1,48,49,1,'2018-06-07 12:59:44','2018-06-07 13:36:35','fb78ca70-6e7e-4a7c-8d2f-89e2efc02113'),(48,1,149,1,50,51,1,'2018-06-07 12:59:56','2018-06-07 13:36:35','1ffe0559-5289-4c49-9885-a73b3136f017'),(50,1,151,1,24,25,1,'2018-06-07 13:00:29','2018-06-07 13:36:06','ee300322-eaba-404c-be1a-61e084b84284'),(51,1,152,1,26,27,1,'2018-06-07 13:00:52','2018-06-07 13:36:06','1870a5f8-194c-4a7f-a9ea-c5050df98bc4'),(52,1,153,1,2,21,1,'2018-06-07 13:03:04','2018-06-07 13:35:31','796dfff2-e416-4d37-943b-12cd9a8f33da'),(53,1,154,1,3,12,2,'2018-06-07 13:03:47','2018-06-07 13:35:31','78efac72-3356-404a-9205-da35c1d2c4cf'),(54,1,155,1,13,20,2,'2018-06-07 13:04:07','2018-06-07 13:35:31','99c930a2-e02d-4ae6-ac3a-5d434af3d28e'),(58,1,158,1,4,11,3,'2018-06-07 13:09:59','2018-06-07 13:35:31','e49d3533-bff5-4347-a693-3a1f6f8d1227'),(59,1,159,1,5,6,4,'2018-06-07 13:10:25','2018-06-07 13:35:31','0e7a329f-e2dc-4645-b596-13237871a778'),(60,1,160,1,7,8,4,'2018-06-07 13:14:04','2018-06-07 13:35:31','f388502b-0c3a-4b8a-bdeb-dac5415fb2d9'),(61,1,161,1,9,10,4,'2018-06-07 13:14:16','2018-06-07 13:35:31','9b69cacb-28ac-49c3-bc81-2c0978061a6f'),(62,1,162,1,14,19,3,'2018-06-07 13:14:44','2018-06-07 13:35:31','8e4b198e-71a2-40e3-8abe-1a915043b2b9'),(63,1,163,1,15,16,4,'2018-06-07 13:14:51','2018-06-07 13:35:31','7311c6bd-d4e6-4fc4-bf44-7f0dadf5d64d'),(64,1,164,1,17,18,4,'2018-06-07 13:15:03','2018-06-07 13:35:31','222a9fdb-4584-41b1-be4b-3fa5573c82bc'),(65,4,NULL,65,1,14,0,'2018-06-07 13:25:45','2018-06-07 13:27:13','6eb53518-a2c0-4ecb-b57b-02ed14eeac9f'),(66,4,166,65,2,3,1,'2018-06-07 13:25:45','2018-06-07 13:25:45','48683fe7-4e1b-4718-af6b-fd21cb599660'),(67,4,167,65,4,5,1,'2018-06-07 13:25:51','2018-06-07 13:25:51','bcbce4c2-d93f-4545-9101-29ac1b73422e'),(68,4,168,65,6,7,1,'2018-06-07 13:26:06','2018-06-07 13:26:06','73be52cf-6820-48a8-9c93-87b98ccef85f'),(69,4,169,65,8,9,1,'2018-06-07 13:26:13','2018-06-07 13:26:13','c1a3f753-ad9f-4c0d-9f38-1f73fdd4b35b'),(70,4,170,65,10,11,1,'2018-06-07 13:26:17','2018-06-07 13:26:17','7f00324b-7967-4e28-983c-16f057273a51'),(72,4,172,65,12,13,1,'2018-06-07 13:27:13','2018-06-07 13:27:13','4e16f999-b23d-4ade-baae-29766d64e19a'),(73,1,174,1,46,47,1,'2018-06-07 13:36:21','2018-06-07 13:36:35','f85c87e5-3b5c-479b-9df7-fb67de28928f');
/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structures`
--

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `structures` VALUES (1,4,'2018-06-06 14:32:36','2018-06-07 13:13:15','71e95978-e800-42bf-8f0d-9af09da369bb'),(4,NULL,'2018-06-07 13:25:20','2018-06-07 13:25:38','ac4b495e-6746-488e-bff6-12b1ef308c92');
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
INSERT INTO `users` VALUES (1,'superuser',NULL,'','','hi@wewereyoung.de','$2y$13$LFVSr0iRiuEm6TqfqhSNgu1b4sUG1NayepfOM7bolIz0nPTnLIVAO',1,0,0,0,'2018-06-07 14:09:56','127.0.0.1',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2018-06-02 11:49:32','2018-04-30 15:34:52','2018-06-07 14:09:56','30729f57-88c5-43b0-a651-b2b37bb3b4bd');
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
-- Dumping routines for database 'wfw'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-06-07 16:28:07
