<!---    section.cfm

AUTHOR				: tpryan
CREATED				: 6/9/2008 11:13:43 PM
DESCRIPTION			: Displays and allows editing of a section from the database.
---->

<cfprocessingdirective suppresswhitespace="yes">

<cfparam name="attributes.id" type="string" />
<cfparam name="url.id" type="string" default="" />	
<cfparam name="url.displayEdit" type="boolean" default="false" />
<cfparam name="url.type" type="string" default="" />	


<cfset key = StructNew() />
<cfset key.path = cgi.script_name />
<cfset key.id = attributes.id />
<cfset section = application.transfer.get("page.section", key) />	

<cfset isAdmin = session.user.getisAdmin() />

<cfif url.displayEdit and compareNoCase(url.id,attributes.id) eq 0 AND compareNoCase(url.type,"section") eq 0>
	<cfset IsEditMode = TRUE />
	<cfset class = "editmode" />
<cfelse>
	<cfset IsEditMode = FALSE />
	<cfset class = "" />
</cfif>

<cfif isEditMode and isAdmin>
	<cfif structKeyExists(form, "update")>
		<cfset section.setPath(form.path) />
		<cfset section.setID(form.id) />
		<cfset section.setUpdatedBy(session.user) />
		<cfset section.setUpdatedOn(Now()) />
		<cfset section.setContent(form.content) />
		<cfset application.transfer.save(section)>
	</cfif>

</cfif>

<cf_sectionDisplay section="#section#" class="#class#" />

<cfif isAdmin>
	<cfsavecontent variable="csstoinject">
		<style type="text/css">
			.admineditsection{
				font-size: .8em;
				padding: 0;
				margin: 0;
				background-color: #00FF00;
				display: inline;
				position: relative;
				
			}
			.admineditsection a{
				color: #FFFFFF;
			}
		</style>
	</cfsavecontent>
	<cfhtmlhead text="#csstoinject#" />


	<cfif IsEditMode>
		
		<cfif not section.getIsPersisted()>
			<cfset section.SetPath(key.path) />
			<cfset section.SetID(key.id) />
			<cfset section.SetUpdatedBy(session.user) />
			<cfset section.SetUpdatedOn(Now()) />
		</cfif>
		
		
		<cfoutput><div class="admineditsection">(<a href="#key.path#" style="color: ##FFFFFF;">Back to View</a>)</div></cfoutput>
		<cf_sectionEdit section="#section#" />
		
	<cfelse>
		<cfoutput><div class="admineditsection">(<a href="#key.path#?displayEdit=true&amp;id=#attributes.id#&type=section" style="color: ##FFFFFF;">Edit #attributes.id#</a>)</div></cfoutput>
	</cfif>

</cfif>


</cfprocessingdirective>
<!--- In case you call as a tag  --->
<cfexit method="exittag" />