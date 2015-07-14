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
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<cfoutput><link rel="stylesheet" href="#application.settings.getyaccpath()#/templates/marketplace/css/MarketPlace.css" type="text/css" /></cfoutput>

<title><cfoutput>#attributes.title#</cfoutput></title>
</head>
<body>
<!-- wrap starts here -->
<div id="wrap">
	<!--header -->
	<div id="header">			
		<div id="header-links">
		<cf_nugget id="header-links" />
		</div>		
	<!--header ends-->					
	</div>
		
	<div id="header-photo">
		<cf_nugget id="header-photo" />
	</div>		
			
	<!-- navigation starts-->	
	<div  id="nav">
		<cf_nugget id="nav" />
	<!-- navigation ends-->	
	</div>					
			
	<!-- content-wrap starts -->
	<div id="content-wrap" class="three-col"  >	
		<div id="sidebar">
			<cf_nugget id="sidesearch" />
			<cf_nugget id="sidebar" />
			<cf_nugget id="links" />	
			<cf_nugget id="sponsors" />	
			<cf_nugget id="wisewords" />
		<!-- sidebar ends -->		
		</div>
		
		<div id="rightcolumn">
			<cf_nugget id="styleshout" />	
			<cf_nugget id="header-text" />
		</div>
		<div id="main">
<cfelse>
   	</div>
	<!-- content-wrap ends-->	
	</div>
		
	<!-- footer starts -->			
	<div id="footer-wrap"><div id="footer">				
		<cf_nugget id="copyright" />
		<cf_adminoption />
	</div></div>
	<!-- footer ends-->	
	
<!-- wrap ends here -->
</div>
</body>
</html>
</cfif>

</cfprocessingdirective>
