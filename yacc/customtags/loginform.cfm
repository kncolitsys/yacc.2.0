<!---    loginfrom.cfm

CREATED				: Terrence Ryan
DESCRIPTION			: A page that displays a login form. Used in conjustion with security.cfc in the application.cfc.
CHANGE LOG			: A list of all the changes made to this boilerplate.
					  Delete all reference to these before code review.


---->

<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.rootUrl" type="string" default="#application.settings.geturl()#" />
<cfparam name="attributes.message" type="string" default="" />

<cfif len(attributes.message) eq 0>
	<cfset loginError = FALSE />
<cfelse>
	<cfset loginError = TRUE />
</cfif>

<cfif application.yaccsettings.getforceHTTPSonLogin()>
	<cfset urlToPost = "https://" & application.settings.gethostsecure() & cgi.script_name & "?" & cgi.query_string />
<cfelse>
	<cfset urlToPost = "http://" & application.settings.gethostsecure() & cgi.script_name & "?" & cgi.query_string />
</cfif>




<cfsavecontent variable="javascriptToInject">
<script type="text/javascript" language="javascript">

window.onload = (function (old) {
  return function () {
    if (typeof old == 'function') old();
    if(document.getElementById("username"));
    document.getElementById("username").focus();
  };
})(window.onload);

</script>
</cfsavecontent>

<cfhtmlhead text="#javascriptToInject#">

<cfoutput>



<br /><br />
<form action="#urlToPost#" method="post" id="loginform">
	
	<fieldset >
		<cfif loginError>
			<p class="error">#attributes.message#</p>
		<cfelse>
			<p>Please enter your username and password.</p>
		</cfif>
		<label for="username">Username:</label>
		<input type="text" id="username" name="username" /><br />

		<label for="password">Password:</label>
		<input type="password" id="password" name="password" /><br />
		<input type="submit" name="signin" value="Sign In" class="submit" /><br />
	</fieldset>	
</form>

</cfoutput>
</cfprocessingdirective>

<cfexit method="exittag" />