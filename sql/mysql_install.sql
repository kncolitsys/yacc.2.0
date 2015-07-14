-- MySQL dump 10.11
--
-- Host: localhost    Database: yacc
-- ------------------------------------------------------
-- Server version	5.0.45-community-nt-log

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
-- Current Database: `yacc`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `yacc` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `yacc`;

--
-- Table structure for table `nugget`
--

DROP TABLE IF EXISTS `nugget`;
CREATE TABLE `nugget` (
  `id` varchar(32) NOT NULL,
  `content` text NOT NULL,
  `updatedOn` datetime NOT NULL,
  `updatedBy` int(10) unsigned NOT NULL,
  PRIMARY KEY  USING BTREE (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `nugget`
--

LOCK TABLES `nugget` WRITE;
/*!40000 ALTER TABLE `nugget` DISABLE KEYS */;
INSERT INTO `nugget` VALUES ('test','<p>Testing nugget editng</p>','2008-06-10 16:24:27',1),('header','<h1 id=\"logo-text\"><a href=\"index.cfm\" title=\"\">YACC</a></h1>\n<p id=\"slogan\">Easy ColdFusion CMS</p>','2008-06-10 23:53:38',1),('search','<form id=\"quick-search\" action=\"index.html\" method=\"get\" >\n			<p>\n			<label for=\"qsearch\">Search:</label>\n			<input class=\"tbox\" id=\"qsearch\" type=\"text\" name=\"qsearch\" value=\"Search...\" title=\"Start typing and hit ENTER\" />\n			<input class=\"btn\" alt=\"Search\" type=\"image\" name=\"searchsubmit\" title=\"Search\" src=\"images/search.gif\" />\n			</p>\n		</form>	','2008-06-10 23:35:51',1),('footer','</body>\r\n</html>','2008-06-10 16:33:47',1),('nav','<ul>\n    <li id=\"current\"><a href=\"index.cfm\">Home</a></li>\n    <li><a href=\"contact.cfm\">Contact</a></li>\n    <li><a href=\"services.cfm\">Services</a></li>\n    <li><a href=\"support.cfm\">Support</a></li>\n    <li><a href=\"about.cfm\">About</a></li>\n</ul>','2008-06-25 22:37:14',1),('sidebar','<h3>OS Projects Used in YACC</h3>\n<ul class=\"sidemenu\">\n    <li><a href=\"http://www.transfer-orm.com/\">Transfer ORM</a></li>\n    <li><a href=\"http://www.coldspringframework.org/\">Coldspring Framework</a></li>\n\n    <li><a href=\"http://betterxml.riaforge.org/\">Better XML</a></li>\n</ul>','2008-06-25 22:36:08',1),('links','<h3>Links</h3>\n<ul class=\"sidemenu\">\n    <li><a href=\"http://www.adobe.com/products/coldfusion/\">Adobe ColdFusion</a></li>\n    <li><a href=\"http://www.riaforge.org/\">RIAForge</a></li>\n    <li><a href=\"http://yacc.riaforge.org/\">YACC</a></li>\n   \n</ul>','2008-06-25 22:35:27',1),('sponsors','<h3>Sponsors</h3>\n			<ul class=\"sidemenu\">\n				<li><a href=\"http://www.4templates.com/?aff=ealigam\">4templates <br /><span>Low Cost Hi-Quality Templates</span></a></li>\n				<li><a href=\"http://store.templatemonster.com?aff=ealigam\">TemplateMonster <br /><span>Delivering the Best Templates on the Net!</span></a></li>\n				<li><a href=\"http://tinyurl.com/3cgv2m\">Text Link Ads <br /><span>Monetized your website</span></a></li>\n				<li><a href=\"http://www.fotolia.com/partner/114283\">Fotolia <br /><span>Free stock images or from $1</span></a> </li>\n				<li><a href=\"http://www.dreamstime.com/res338619\">Dreamstime <br /><span>Lowest Price for High Quality Stock Photos</span></a></li>\n				<li><a href=\"http://www.dreamhost.com/r.cgi?287326\">Dreamhost <br /><span>Premium webhosting</span></a></li>\n			</ul>','2008-06-10 23:40:48',1),('sidesearch','<h3>Search Box</h3>	\n			<form class=\"searchform\" action=\"index.html\" method=\"get\">\n				<p>\n				<input name=\"search_query\" class=\"textbox\" type=\"text\" />\n  				<input name=\"search\" class=\"button\" value=\"Search\" type=\"submit\" />\n				</p>			\n			</form>	','2008-06-10 23:44:30',1),('wisewords','<h3>Wise Words</h3>\n			<p>&quot;When I have fully decided that a result \n			is worth getting I go ahead of it and \n			make trial after trial until it comes.&quot; </p>\n					\n			<p class=\"align-right\">- Thomas A. Edison</p>','2008-06-10 23:45:37',1),('styleshout','<h3>Support Styleshout</h3> 			<p>Currently, all of the templates for YACC come from <a href=\"http://www.styleshout.com/\">Styleshout</a>. They do great work over there. Please consider them for your web design work. </p>','2008-06-18 23:49:29',1),('footer1','<h3>Tincidunt</h3>\n				<ul>\n					<li><a href=\"index.html\">consequat molestie</a></li>\n					<li><a href=\"index.html\">sem justo</a></li>\n					<li><a href=\"index.html\">semper</a></li>\n					<li><a href=\"index.html\">magna sed purus</a></li>\n					<li><a href=\"index.html\">tincidunt</a></li>\n				</ul>','2008-06-10 23:49:11',1),('footer2','<h3>Sed purus</h3>\n				<ul>\n					<li><a href=\"index.html\">consequat molestie</a></li>\n					<li><a href=\"index.html\">sem justo</a></li>\n					<li><a href=\"index.html\">semper</a></li>\n					<li><a href=\"index.html\">magna sed purus</a></li>\n					<li><a href=\"index.html\">tincidunt</a></li>\n				</ul>','2008-06-10 23:49:34',1),('footer3','<h3>Praesent</h3>\n				<ul>\n					<li><a href=\"index.html\">consequat molestie</a></li>\n					<li><a href=\"index.html\">sem justo</a></li>\n					<li><a href=\"index.html\">semper</a></li>\n					<li><a href=\"index.html\">magna sed purus</a></li>\n					<li><a href=\"index.html\">tincidunt</a></li>					\n				</ul>','2008-06-10 23:50:20',1),('copyright','<p>&copy; 2006 <strong>Terrence Ryan</strong> |  			Design by: <a href=\"http://www.styleshout.com/\">styleshout</a> |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  			Valid <a href=\"http://validator.w3.org/check?uri=referer\">XHTML</a> |  			<a href=\"http://jigsaw.w3.org/css-validator/check/referer\">CSS</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                  			    		       			 			<a href=\"index.html\">Home</a> |     		<a href=\"index.html\">Sitemap</a> |  	   	<a href=\"index.html\">RSS Feed</a></p>','2008-06-11 21:00:08',1),('header-links','<p>\n			<a href=\"index.html\">Home</a> | \n			<a href=\"index.html\">Contact</a> | \n			<a href=\"index.html\">Site Map</a>			\n		</p>	','2008-06-12 18:02:00',1),('header-photo','<h1 id=\"logo-text\"><a href=\"index.cfm\" title=\"\">YACC</a></h1>\n<h2 id=\"slogan\">Yet Another ColdFusion CMS</h2>','2008-06-14 00:55:41',1),('header-text','<h3>About YACC</h3> <p><i>Why another ColdFusion CMS?</i><br /> I needed my own CMS and couldn\'t find one that I need - for a few reasons:&nbsp;</p> <ol> <li>A few other CMS\'s were too complicated for what I need.</li> <li>Other CMS\'s that were simple enough, made it hard to mix cms\'ed content and programmed content.</li> <li>Other CMS\'s that were simple enough, made it hard to reuse pieces of content.</li> </ol> <p>YACC is a low to middle level CMS that:</p> <ul> <li>is easy to use</li> <li>allows mixing of cms\'ed and programmatic pieces</li> <li>allows mixing of sections (unique to a page) and nuggets (globally available.)</li> </ul><p>&nbsp;</p>','2008-06-25 22:44:24',1),('menu','<ul>\n	<li class=\"first\"><a href=\"\">Home</a></li>\n	<li><a href=\"\">Archives</a></li>\n	<li><a href=\"\">Links</a></li>\n	<li><a href=\"\">Resources</a></li>\n	<li><a href=\"\">Contact</a></li>\n</ul>','2008-06-17 16:21:04',1),('logo-slogan','<h1 id=\"logo\"><a title=\"\" href=\"index.html\">YA<span class=\"orange\">CC</span></a></h1>\n<h2 id=\"slogan\">Yet Another ColdFusion CMS</h2>','2008-06-17 16:37:06',1),('partners','<h2>Site Partners</h2>\n			<ul class=\"columns\">				\n				<li class=\"top\"><a href=\"http://www.dreamhost.com/r.cgi?287326\"><strong>Dreamhost</strong> - Excellent Webhosting at $7.95/mo</a></li>\n				<li><a href=\"http://www.4templates.com/?aff=ealigam\"><strong>4templates</strong> - Low Cost Hi-Quality Templates</a></li>\n				<li><a href=\"http://store.templatemonster.com/?aff=ealigam\"><strong>TemplateMonster</strong> - Best templates on the net!</a></li>	\n				<li><a href=\"http://www.fotolia.com/partner/114283\"><strong>Fotolia</strong> - Free stock images or from $1</a></li>						\n				<li><a href=\"http://www.dreamstime.com/res338619\"><strong>Dreamstime</strong> - Hi-Resolution Stock Images for Free!</a></li>\n			</ul>		','2008-06-17 16:37:59',1),('404','<h1>404</h1><p>The page you seek is not here. <br /> Don\'t dispair, there are many other pages out there. <br /> I\'m sure the next one won\'t break your heart like this one.</p>','2008-06-25 22:45:25',1);
/*!40000 ALTER TABLE `nugget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page`
--

DROP TABLE IF EXISTS `page`;
CREATE TABLE `page` (
  `path` varchar(512) NOT NULL,
  `title` varchar(512) default NULL,
  `layout` varchar(255) NOT NULL,
  `updatedOn` datetime NOT NULL,
  `updatedBy` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`path`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `page`
--

LOCK TABLES `page` WRITE;
/*!40000 ALTER TABLE `page` DISABLE KEYS */;
INSERT INTO `page` VALUES ('/yacctemplate/index.cfm','Main - YACCTemplate','default','2008-06-18 17:16:08',1),('/yacctemplate/404.cfm',NULL,'default','2008-06-14 01:12:00',1),('/yacctemplate/test.cfm',NULL,'default','2008-06-16 15:16:52',1);
/*!40000 ALTER TABLE `page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
CREATE TABLE `person` (
  `userID` int(10) unsigned NOT NULL auto_increment,
  `username` varchar(45) NOT NULL,
  `password` char(128) NOT NULL,
  `firstName` varchar(45) NOT NULL,
  `lastName` varchar(45) NOT NULL,
  `email` varchar(255) NOT NULL,
  `isAdmin` tinyint(1) NOT NULL,
  `currentToken` varchar(255) default NULL,
  PRIMARY KEY  (`userID`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (1,'admin','E9E633097AB9CEB3E48EC3F70EE2BEBA41D05D5420EFEE5DA85F97D97005727587FDA33EF4FF2322088F4C79E8133CC9CD9F3512F4D3A303CBDB5BC585415A00','Administrator','Easycfcms','admin@domain.com',1,'bJ3s69TpDt8ExA8vwe/SBP9NyXun3/8OSMBinlcWR/A='),(2,'testuser','E9E633097AB9CEB3E48EC3F70EE2BEBA41D05D5420EFEE5DA85F97D97005727587FDA33EF4FF2322088F4C79E8133CC9CD9F3512F4D3A303CBDB5BC585415A00','Test','User','test@domain.com',0,'bJ3s69TpDt8ExA8vwezfBPxLyXmq3/oNSMBii1YIWuuEF7w=');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `section`
--

DROP TABLE IF EXISTS `section`;
CREATE TABLE `section` (
  `path` varchar(512) NOT NULL,
  `id` varchar(32) NOT NULL,
  `content` text NOT NULL,
  `updatedOn` datetime NOT NULL,
  `updatedBy` int(10) unsigned NOT NULL,
  PRIMARY KEY  USING BTREE (`path`,`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `section`
--

LOCK TABLES `section` WRITE;
/*!40000 ALTER TABLE `section` DISABLE KEYS */;
INSERT INTO `section` VALUES ('/yacctemplate/index.cfm','yacccontents','<h2>Welcome</h2><p>Please behave yourself. This is the main section of the index page.</p>','2008-06-16 12:09:17',1);
/*!40000 ALTER TABLE `section` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2008-06-26  3:20:14
