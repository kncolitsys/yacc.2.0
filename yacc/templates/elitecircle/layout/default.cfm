<!---    layout.cfm

AUTHOR				: tpryan
CREATED				: 6/10/2008 5:19:48 PM
DESCRIPTION			: Contains the layout for the entire site. 
---->

<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.title" type="string" default="YACC" />
<cfif thisTag.ExecutionMode is 'start'>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title><cfoutput>#attributes.title#</cfoutput></title>
<meta http-equiv="content-type" content="application/xhtml+xml; charset=UTF-8" />

<cfoutput><link rel="stylesheet" href="#application.settings.getyaccpath()#/templates/elitecircle/css/EliteCircle.css" type="text/css" /></cfoutput>

</head>

<body>
	
	<!-- header starts here -->
	<div id="header-wrap"><div id="header-content">	
		
		<cf_nugget id="logo-slogan" />	
		
		<div id="header-links">
			<cf_nugget id="header-links" />
		</div>
		
		<!-- Menu Tabs -->
		<cf_nugget id="nav" />		
	
	</div></div>
				
	<!-- content-wrap starts here -->
	<div id="content-wrap"><div id="content">	 
	
	<div id="main">
<cfelse>
	</div>
   <div id="sidebar">	
		
				<cf_nugget id="sidesearch" />		
			
				<cf_nugget id="sidebar" />	
						
				<cf_nugget id="sponsors" />	
			
			
			
			
			
			
				<cf_nugget id="wisewords" />	
						
				<cf_nugget id="styleshout" />	
								
		</div>			
	
	<!-- content-wrap ends here -->		
	</div></div>

	<!-- footer starts here -->	
	<div id="footer-wrap"><div id="footer-content">
	
		<div class="col float-left space-sep">
			<cf_nugget id="partners" />	
				
		</div>
		
		<div class="col float-left">
			<cf_nugget id="links" />	
		</div>		
	
		<div class="col2 float-right">
			<cf_nugget id="copyright" />
			<cf_adminoption />
		</div>
		
		<br class="clear" />
	
	</div></div>
	<!-- footer ends here -->

</body>
</html>

</cfif>

</cfprocessingdirective>
