<!---    adminoption.cfm

AUTHOR				: tpryan
CREATED				: 6/11/2008 5:45:20 PM
DESCRIPTION			: Provides user option to login or out of page.
---->

<cfset displayAnything = true />

<cfprocessingdirective suppresswhitespace="yes">

<cfif structKeyExists(session, 'user')>
	<cfset loggedin = session.user.getloggedIn() />
<cfelse>
	<cfset displayAnything = false />
	<cfset loggedin = false />
</cfif>

<cfif displayAnything>
	<cfif loggedin>
		<p>
			<a href="?logout">Logout</a> | 
			<a href="?deletepage" onclick="if (confirm('Are you sure?')) return true; else  return false" >Delete Page</a> | 
			<a href="?editPage">Edit Page Settings</a> |
			<a href="?editSite">Edit Site Settings</a>
		</p>
	<cfelse>
		<p><a href="?login">Login</a></p>

	</cfif>
</cfif>

</cfprocessingdirective>
<!--- In case you call as a tag  --->
<cfexit method="exittag" />