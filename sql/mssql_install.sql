
CREATE TABLE [nugget](
	[id] [varchar] (32) ,
	[content] [text] ,
	[updatedOn] [datetime] ,
	[updatedBy] [int] 
	,CONSTRAINT [PK_nugget] PRIMARY KEY CLUSTERED 
	(
		[id] ASC
	)
)

CREATE TABLE [page](
	[path] [varchar] (512) ,
	[title] [varchar] (512) NOT NULL ,
	[layout] [varchar] (255) ,
	[updatedOn] [datetime] ,
	[updatedBy] [int] 
	,CONSTRAINT [PK_page] PRIMARY KEY CLUSTERED 
	(
		[path] ASC
	)
)

CREATE TABLE [person](
	[userID] [int] IDENTITY(1,1) ,
	[username] [varchar] (45) ,
	[password] [char] (128) ,
	[firstName] [varchar] (45) ,
	[lastName] [varchar] (45) ,
	[email] [varchar] (255) ,
	[isAdmin] [BIT] ,
	[currentToken] [varchar] (255) NOT NULL 
	,CONSTRAINT [PK_person] PRIMARY KEY CLUSTERED 
	(
		[userID] ASC
	)
)

CREATE TABLE [section](
	[path] [varchar] (512) ,
	[id] [varchar] (32) ,
	[content] [text] ,
	[updatedOn] [datetime] ,
	[updatedBy] [int] 
	,CONSTRAINT [PK_section] PRIMARY KEY CLUSTERED 
	(
		[path] ASC,

		[id] ASC
	)
)


INSERT INTO [nugget] ([content],[id],[updatedby],[updatedon]) 
VALUES('<p>Testing nugget editng</p>','test','1','2008-06-10 16:24:27.0')

INSERT INTO [nugget] ([content],[id],[updatedby],[updatedon]) 
VALUES('<h1 id="logo-text"><a href="index.cfm" title="">YACC</a></h1>
<p id="slogan">Easy ColdFusion CMS</p>','header','1','2008-06-10 23:53:38.0')

INSERT INTO [nugget] ([content],[id],[updatedby],[updatedon]) 
VALUES('<form id="quick-search" action="index.html" method="get" >
			<p>
			<label for="qsearch">Search:</label>
			<input class="tbox" id="qsearch" type="text" name="qsearch" value="Search..." title="Start typing and hit ENTER" />
			<input class="btn" alt="Search" type="image" name="searchsubmit" title="Search" src="images/search.gif" />
			</p>
		</form>	','search','1','2008-06-10 23:35:51.0')

INSERT INTO [nugget] ([content],[id],[updatedby],[updatedon]) 
VALUES('</body>
</html>','footer','1','2008-06-10 16:33:47.0')

INSERT INTO [nugget] ([content],[id],[updatedby],[updatedon]) 
VALUES('<ul>
    <li id="current"><a href="index.cfm">Home</a></li>
    <li><a href="contact.cfm">Contact</a></li>
    <li><a href="services.cfm">Services</a></li>
    <li><a href="support.cfm">Support</a></li>
    <li><a href="about.cfm">About</a></li>
</ul>','nav','1','2008-06-25 22:37:14.0')

INSERT INTO [nugget] ([content],[id],[updatedby],[updatedon]) 
VALUES('<h3>OS Projects Used in YACC</h3>
<ul class="sidemenu">
    <li><a href="http://www.transfer-orm.com/">Transfer ORM</a></li>
    <li><a href="http://www.coldspringframework.org/">Coldspring Framework</a></li>

    <li><a href="http://betterxml.riaforge.org/">Better XML</a></li>
</ul>','sidebar','1','2008-06-25 22:36:08.0')

INSERT INTO [nugget] ([content],[id],[updatedby],[updatedon]) 
VALUES('<h3>Links</h3>
<ul class="sidemenu">
    <li><a href="http://www.adobe.com/products/coldfusion/">Adobe ColdFusion</a></li>
    <li><a href="http://www.riaforge.org/">RIAForge</a></li>
    <li><a href="http://yacc.riaforge.org/">YACC</a></li>
   
</ul>','links','1','2008-06-25 22:35:27.0')

INSERT INTO [nugget] ([content],[id],[updatedby],[updatedon]) 
VALUES('<h3>Sponsors</h3>
			<ul class="sidemenu">
				<li><a href="http://www.4templates.com/?aff=ealigam">4templates <br /><span>Low Cost Hi-Quality Templates</span></a></li>
				<li><a href="http://store.templatemonster.com?aff=ealigam">TemplateMonster <br /><span>Delivering the Best Templates on the Net!</span></a></li>
				<li><a href="http://tinyurl.com/3cgv2m">Text Link Ads <br /><span>Monetized your website</span></a></li>
				<li><a href="http://www.fotolia.com/partner/114283">Fotolia <br /><span>Free stock images or from $1</span></a> </li>
				<li><a href="http://www.dreamstime.com/res338619">Dreamstime <br /><span>Lowest Price for High Quality Stock Photos</span></a></li>
				<li><a href="http://www.dreamhost.com/r.cgi?287326">Dreamhost <br /><span>Premium webhosting</span></a></li>
			</ul>','sponsors','1','2008-06-10 23:40:48.0')

INSERT INTO [nugget] ([content],[id],[updatedby],[updatedon]) 
VALUES('<h3>Search Box</h3>	
			<form class="searchform" action="index.html" method="get">
				<p>
				<input name="search_query" class="textbox" type="text" />
  				<input name="search" class="button" value="Search" type="submit" />
				</p>			
			</form>	','sidesearch','1','2008-06-10 23:44:30.0')

INSERT INTO [nugget] ([content],[id],[updatedby],[updatedon]) 
VALUES('<h3>Wise Words</h3>
			<p>&quot;When I have fully decided that a result 
			is worth getting I go ahead of it and 
			make trial after trial until it comes.&quot; </p>
					
			<p class="align-right">- Thomas A. Edison</p>','wisewords','1','2008-06-10 23:45:37.0')

INSERT INTO [nugget] ([content],[id],[updatedby],[updatedon]) 
VALUES('<h3>Support Styleshout</h3> 			<p>Currently, all of the templates for YACC come from <a href="http://www.styleshout.com/">Styleshout</a>. They do great work over there. Please consider them for your web design work. </p>','styleshout','1','2008-06-18 23:49:29.0')

INSERT INTO [nugget] ([content],[id],[updatedby],[updatedon]) 
VALUES('<h3>Tincidunt</h3>
				<ul>
					<li><a href="index.html">consequat molestie</a></li>
					<li><a href="index.html">sem justo</a></li>
					<li><a href="index.html">semper</a></li>
					<li><a href="index.html">magna sed purus</a></li>
					<li><a href="index.html">tincidunt</a></li>
				</ul>','footer1','1','2008-06-10 23:49:11.0')

INSERT INTO [nugget] ([content],[id],[updatedby],[updatedon]) 
VALUES('<h3>Sed purus</h3>
				<ul>
					<li><a href="index.html">consequat molestie</a></li>
					<li><a href="index.html">sem justo</a></li>
					<li><a href="index.html">semper</a></li>
					<li><a href="index.html">magna sed purus</a></li>
					<li><a href="index.html">tincidunt</a></li>
				</ul>','footer2','1','2008-06-10 23:49:34.0')

INSERT INTO [nugget] ([content],[id],[updatedby],[updatedon]) 
VALUES('<h3>Praesent</h3>
				<ul>
					<li><a href="index.html">consequat molestie</a></li>
					<li><a href="index.html">sem justo</a></li>
					<li><a href="index.html">semper</a></li>
					<li><a href="index.html">magna sed purus</a></li>
					<li><a href="index.html">tincidunt</a></li>					
				</ul>','footer3','1','2008-06-10 23:50:20.0')

INSERT INTO [nugget] ([content],[id],[updatedby],[updatedon]) 
VALUES('<p>&copy; 2006 <strong>Terrence Ryan</strong> |  			Design by: <a href="http://www.styleshout.com/">styleshout</a> |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  			Valid <a href="http://validator.w3.org/check?uri=referer">XHTML</a> |  			<a href="http://jigsaw.w3.org/css-validator/check/referer">CSS</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                  			    		       			 			<a href="index.html">Home</a> |     		<a href="index.html">Sitemap</a> |  	   	<a href="index.html">RSS Feed</a></p>','copyright','1','2008-06-11 21:00:08.0')

INSERT INTO [nugget] ([content],[id],[updatedby],[updatedon]) 
VALUES('<p>
			<a href="index.html">Home</a> | 
			<a href="index.html">Contact</a> | 
			<a href="index.html">Site Map</a>			
		</p>	','header-links','1','2008-06-12 18:02:00.0')

INSERT INTO [nugget] ([content],[id],[updatedby],[updatedon]) 
VALUES('<h1 id="logo-text"><a href="index.cfm" title="">YACC</a></h1>
<h2 id="slogan">Yet Another ColdFusion CMS</h2>','header-photo','1','2008-06-14 00:55:41.0')

INSERT INTO [nugget] ([content],[id],[updatedby],[updatedon]) 
VALUES('<h3>About YACC</h3> <p><i>Why another ColdFusion CMS?</i><br /> I needed my own CMS and couldn''t find one that I need - for a few reasons:&nbsp;</p> <ol> <li>A few other CMS''s were too complicated for what I need.</li> <li>Other CMS''s that were simple enough, made it hard to mix cms''ed content and programmed content.</li> <li>Other CMS''s that were simple enough, made it hard to reuse pieces of content.</li> </ol> <p>YACC is a low to middle level CMS that:</p> <ul> <li>is easy to use</li> <li>allows mixing of cms''ed and programmatic pieces</li> <li>allows mixing of sections (unique to a page) and nuggets (globally available.)</li> </ul><p>&nbsp;</p>','header-text','1','2008-06-25 22:44:24.0')

INSERT INTO [nugget] ([content],[id],[updatedby],[updatedon]) 
VALUES('<ul>
	<li class="first"><a href="">Home</a></li>
	<li><a href="">Archives</a></li>
	<li><a href="">Links</a></li>
	<li><a href="">Resources</a></li>
	<li><a href="">Contact</a></li>
</ul>','menu','1','2008-06-17 16:21:04.0')

INSERT INTO [nugget] ([content],[id],[updatedby],[updatedon]) 
VALUES('<h1 id="logo"><a title="" href="index.html">YA<span class="orange">CC</span></a></h1>
<h2 id="slogan">Yet Another ColdFusion CMS</h2>','logo-slogan','1','2008-06-17 16:37:06.0')

INSERT INTO [nugget] ([content],[id],[updatedby],[updatedon]) 
VALUES('<h2>Site Partners</h2>
			<ul class="columns">				
				<li class="top"><a href="http://www.dreamhost.com/r.cgi?287326"><strong>Dreamhost</strong> - Excellent Webhosting at $7.95/mo</a></li>
				<li><a href="http://www.4templates.com/?aff=ealigam"><strong>4templates</strong> - Low Cost Hi-Quality Templates</a></li>
				<li><a href="http://store.templatemonster.com/?aff=ealigam"><strong>TemplateMonster</strong> - Best templates on the net!</a></li>	
				<li><a href="http://www.fotolia.com/partner/114283"><strong>Fotolia</strong> - Free stock images or from $1</a></li>						
				<li><a href="http://www.dreamstime.com/res338619"><strong>Dreamstime</strong> - Hi-Resolution Stock Images for Free!</a></li>
			</ul>		','partners','1','2008-06-17 16:37:59.0')

INSERT INTO [nugget] ([content],[id],[updatedby],[updatedon]) 
VALUES('<h1>404</h1><p>The page you seek is not here. <br /> Don''t dispair, there are many other pages out there. <br /> I''m sure the next one won''t break your heart like this one.</p>','404','1','2008-06-25 22:45:25.0')

GO 


INSERT INTO [page] ([layout],[path],[title],[updatedby],[updatedon]) 
VALUES('default','/yacctemplate/index.cfm','Main - YACCTemplate','1','2008-06-18 17:16:08.0')

INSERT INTO [page] ([layout],[path],[title],[updatedby],[updatedon]) 
VALUES('default','/yacctemplate/404.cfm','','1','2008-06-14 01:12:00.0')

INSERT INTO [page] ([layout],[path],[title],[updatedby],[updatedon]) 
VALUES('default','/yacctemplate/test.cfm','','1','2008-06-16 15:16:52.0')

GO 


SET IDENTITY_INSERT [person] ON 
INSERT INTO [person] ([currenttoken],[email],[firstname],[isadmin],[lastname],[password],[userid],[username]) 
VALUES('bJ3s69TpDt8ExA8vwe/SBP9NyXun3/8OSMBinlcWR/A=','admin@domain.com','Administrator','1','Easycfcms','E9E633097AB9CEB3E48EC3F70EE2BEBA41D05D5420EFEE5DA85F97D97005727587FDA33EF4FF2322088F4C79E8133CC9CD9F3512F4D3A303CBDB5BC585415A00','1','admin')

INSERT INTO [person] ([currenttoken],[email],[firstname],[isadmin],[lastname],[password],[userid],[username]) 
VALUES('bJ3s69TpDt8ExA8vwezfBPxLyXmq3/oNSMBii1YIWuuEF7w=','test@domain.com','Test','0','User','E9E633097AB9CEB3E48EC3F70EE2BEBA41D05D5420EFEE5DA85F97D97005727587FDA33EF4FF2322088F4C79E8133CC9CD9F3512F4D3A303CBDB5BC585415A00','2','testuser')

SET IDENTITY_INSERT [person] OFF 
GO 


INSERT INTO [section] ([content],[id],[path],[updatedby],[updatedon]) 
VALUES('<h2>Welcome</h2><p>Please behave yourself. This is the main section of the index page.</p>','yacccontents','/yacctemplate/index.cfm','1','2008-06-16 12:09:17.0')

GO 


