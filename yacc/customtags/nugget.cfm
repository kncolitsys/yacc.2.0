<!---    nugget.cfm

AUTHOR				: tpryan
CREATED				: 6/9/2008 11:03:09 PM
DESCRIPTION			: Displays and allows editing of a nugget from the database.
---->

<cfprocessingdirective suppresswhitespace="yes">

<cfparam name="attributes.id" type="string" />
<cfparam name="url.id" type="string" default="" />	
<cfparam name="url.displayEdit" type="boolean" default="false" />
<cfparam name="url.type" type="string" default="" />	

<cfset nugget = application.transfer.get("page.nugget", attributes.id) />
<cfset isAdmin = session.user.getisAdmin() />


<cfif url.displayEdit and compareNoCase(url.id,attributes.id) eq 0 AND compareNoCase(url.type,"nugget") eq 0>
	<cfset IsEditMode = TRUE />
	<cfset class = "editmode" />
<cfelse>
	<cfset IsEditMode = FALSE />
	<cfset class = "" />
</cfif>




<cf_nuggetDisplay nugget="#nugget#" />


<cfif isAdmin>
	<cfsavecontent variable="csstoinject">
		<style type="text/css">
			.admineditnugget{
				font-size: .8em;
				padding: 0;
				margin: 0;
				background-color: #000000;
				display: inline;
				position: relative;
				
			}
			.admineditnugget a, .admineditnugget a:visited{
				color: #FFFFFF;
			}
			
			.admineditnugget a:hover, .admineditnugget a:active{
				color: #FAF8CC;
			}
		</style>
	</cfsavecontent>
	<cfhtmlhead text="#csstoinject#" />


	<cfif IsEditMode>
		
		<cfif not nugget.getIsPersisted()>
			<cfset nugget.SetID(attributes.id) />
			<cfset nugget.SetUpdatedBy(session.user) />
			<cfset nugget.SetUpdatedOn(Now()) />
		</cfif>
		
		
		<cfoutput><div class="admineditnugget">(<a href="#cgi.script_name#" style="color: ##FFFFFF;">Back to View</a>)</div></cfoutput>
		<cf_nuggetEdit nugget="#nugget#" />
		
	<cfelse>
		<cfoutput><div class="admineditnugget">(<a href="#cgi.script_name#?displayEdit=true&amp;id=#attributes.id#&type=nugget" style="color: ##FFFFFF;">Edit #attributes.id#</a>)</div></cfoutput>
	</cfif>

</cfif>





</cfprocessingdirective>
<!--- In case you call as a tag  --->
<cfexit method="exittag" />