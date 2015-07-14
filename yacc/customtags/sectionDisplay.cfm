<!---    sectionDisplay.cfm

AUTHOR				: tpryan
CREATED				: 6/9/2008 11:17:03 PM
DESCRIPTION			: Displays section information from the database.
---->

<cfprocessingdirective suppresswhitespace="yes">

<cfparam name="attributes.section" type="any" />
<cfparam name="attributes.class" type="string" default=""/>

<cfset section = attributes.section />

<cfsavecontent variable="csstoinject">
	<style type="text/css">
		.editmode{
			border: 1px solid #CCCCCC;
			background-color: #fffaf0;
		}
	</style>
</cfsavecontent>
<cfhtmlhead text="#csstoinject#" />


<cfoutput>
<div id="#section.getID()#" class="#attributes.class#">#section.getContent()#</div>
</cfoutput>
	
	
</cfprocessingdirective>
<!--- In case you call as a tag  --->
<cfexit method="exittag" />