<!---    toolbarUser.cfm

AUTHOR				: tpryan
CREATED				: 6/17/2008 11:10:03 PM
DESCRIPTION			: The user toolbar for the user admin options. 
---->

<cfprocessingdirective suppresswhitespace="yes">
	<cfparam name="attributes.showList" type="boolean" default="true" />
	<cfparam name="attributes.showAdd" type="boolean" default="true" />
	<cfparam name="attributes.showRead" type="boolean" default="true" />
	<cfparam name="attributes.showEdit" type="boolean" default="true" />
	<cfparam name="attributes.showDelete" type="boolean" default="true" />
	<cfparam name="attributes.user" type="any" default="" />
	
	<cfset user = attributes.user />
	<cfoutput>
	<p>	
		<cfif attributes.showList><a href="?method=list">List</a> | </cfif>
		<cfif attributes.showAdd><a href="?method=edit">Add</a> | </cfif>
		<cfif attributes.showRead><a href="?method=read&amp;userid=#user.getuserID()#">Read</a> | </cfif>
		<cfif attributes.showEdit><a href="?method=edit&amp;userid=#user.getuserID()#">Edit</a> | </cfif>
		<cfif attributes.showDelete><a href="?method=delete_process&amp;userid=#user.getuserID()#" onclick="if (confirm('Are you sure?')) return true; else return false">Delete</a> </cfif>
	</p>
	</cfoutput>

</cfprocessingdirective>
<!--- In case you call as a tag  --->
<cfexit method="exittag" />