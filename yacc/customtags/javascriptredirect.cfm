<!---    javascriptredirect.cfm

CREATED				: Terrence Ryan
DESCRIPTION			: A redirect that uses javascript instead of cflocation.
					  It doesn't screw up session variables.
CHANGE LOG			: A list of all the changes made to this boilerplate.
					  Delete all reference to these before code review.


---->
<cfprocessingdirective suppresswhitespace="yes">
<!--- Handle logins. --->
<cfif session.userObj.get("loggedin") and structKeyExists(url, "login")>

	<cfset appendString = ReplaceNoCAse(cgi.query_string,"login=true", "", "ALL") />
<cfelse>
	<!--- Handle logouts. --->
	<cfif not session.userObj.get("loggedin") and structKeyExists(url, "logout") >
		<cfset appendString = ReplaceNoCase(cgi.query_string,"logout", "", "ALL") />
	<cfelse>
		<cfset appendString = cgi.query_string />
	</cfif>
</cfif>


<!--- Only add the question mark if it is needed --->
<cfif len(appendString) gt 0>
	<cfset appendString = "?" & appendString />
</cfif>

<cfif not compareNoCase(application.host,application.hostSecure)>
	<cfoutput>
		<script language="JavaScript">
			window.location='http://#application.host##cgi.SCRIPT_NAME##appendString#';
		</script>
		If you have javascript disabled, please click to continue.<br>
		<a href="http://#application.host##cgi.SCRIPT_NAME##appendString#">http://#application.host##cgi.SCRIPT_NAME##appendString#</a><br>
	</cfoutput>
<cfelse>
	<cfoutput>
		<script language="JavaScript">
			window.location='http://#application.host##cgi.SCRIPT_NAME#?#session.URLToken#&amp;#appendString#';
		</script>
		If you have javascript disabled, please click to continue.<br>
		<a href="http://#application.host##cgi.SCRIPT_NAME#?#session.URLToken#&amp;#appendString#">http://#application.host##cgi.SCRIPT_NAME#?#session.URLToken#&amp;#appendString#</a><br>
	</cfoutput>
</cfif>
</cfprocessingdirective>
<cfexit method="exittag" />