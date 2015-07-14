<!---    header.cfm

AUTHOR				: tpryan
CREATED				: 2/21/2008 1:34:14 PM
DESCRIPTION			: the header for the site.
---->

<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.title" type="string" default="" />
<cfparam name="attributes.header" type="string" default="" />
<cfparam name="attributes.showNav" type="boolean" default="FALSE" />	


<cfif len(attributes.title) eq 0 >
	<cfset attributes.title = application.settings.getCMSTitle() />
</cfif>

<cfif len(attributes.header) eq 0>
	<cfset attributes.header = application.settings.getCMSTitle() />
</cfif>

<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>#application.settings.getcmstitle()#</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<link rel="stylesheet" href="#application.settings.getYaccPath()#/static/css/Blue.css" type="text/css" media="screen" />

</cfoutput>
</head>


<body>
<!-- wrap starts here -->
<div id="wrap"> 

	<div id="header">	
			
		<h1 id="logo">YA<span class="blue">CC</span></h1>
		<h2 id="slogan">Yet Another ColdFusion CMS</h2>	
		
		<!--- <form method="post" class="searchform" action="#">
			<p><input type="text" name="search_query" class="textbox" />
  			<input type="submit" name="search" class="button" value="Search" /></p>
		</form> --->
		
	</div>		

	<div id="menu">
		
	</div>


	<div id="sidebar">
			<cfif attributes.showNav>
			<cf_nav />
		</cfif>
				
				
				
			</div>		
	
	<div id="main"> 



</cfprocessingdirective>
<!--- In case you call as a tag  --->
<cfexit method="exittag" />