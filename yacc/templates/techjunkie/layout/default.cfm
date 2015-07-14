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
<cfoutput><link rel="stylesheet" href="#application.settings.getyaccpath()#/templates/techjunkie/css/TechJunkie.css" type="text/css" /></cfoutput>


</head>

<body>
<!-- wrap starts here -->
<div id="wrap">

	<!--header -->
	<div id="header">			
		<cf_nugget id="header" />		
		<cf_nugget id="search" />	
	<!--header ends-->					
	</div>
		
	<!-- navigation starts-->	
	<div  id="nav">
		<cf_nugget id="nav" />
	<!-- navigation ends-->	
	</div>					
			
	<!-- content-wrap starts -->
	<div id="content-wrap">
	<div id="main">
<cfelse>
   	</div>
		<div id="sidebar">
			<cf_nugget id="sidebar" />
			<cf_nugget id="links" />	
			<cf_nugget id="sponsors" />	
			<cf_nugget id="sidesearch" />	
			<cf_nugget id="wisewords" />	
			<cf_nugget id="styleshout" />		
		<!-- sidebar ends -->		
		</div>		
		
	<!-- content-wrap ends-->	
	</div>
		
	<!-- footer starts -->		
	<div id="footer-wrap"><div id="footer-content">
	
		<div id="footer-columns">	
			<div class="col3">
				<cf_nugget id="footer1" />
			</div>

			<div class="col3-center">
				<cf_nugget id="footer2" />
			</div>

			<div class="col3">
				<cf_nugget id="footer3" />
			</div>
		<!-- footer-columns ends -->
		</div>	
	
		<div id="footer-bottom">
			<cf_nugget id="copyright" />
			<cf_adminoption />
		</div>	

<!-- footer ends-->
</div></div>

<!-- wrap ends here -->
</div>

</body>
</html>

</cfif>

</cfprocessingdirective>
