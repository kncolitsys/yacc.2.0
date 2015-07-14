<cfcomponent >

	<!---*****************************************************--->
	<!---init--->
	<!---This is the pseudo constructor that allows us to play little object games.--->
	<!---*****************************************************--->
	<cffunction access="public" name="init" output="FALSE" returntype="any" hint="This is the pseudo constructor that allows us to play little object games." > 
		<cfreturn This />
	</cffunction>


	<!--- *********************************************************** --->
	<!--- handleLogin                                                 --->
	<!--- Handles logging in a user.                                  --->
	<!--- *********************************************************** --->
	<cffunction access="public" name="handleLogin" output="true" returntype="void" hint="Handles logging in a user.">
		
		<cfset var security = "" />
		<cfset var auth = FALSE />
		<cfset var username = "" />
		<cfset var message = "" />
		<cfset var user = "">
	
		<cfif not session.user.getloggedIn()>
		
				<cfif structKeyExists(cookie, "yacctoken") and structKeyExists(cookie, "yaccusername") and len(cookie.yacctoken) gt 0>
					<!--- Check Cookie Code --->
					<cfset user = application.userService.get(cookie.yaccusername) /> 	
					<cfset auth = user.authCurrentToken(cookie.yacctoken) />
				</cfif>					
				
				<cfif not auth and structKeyExists(form, "signin")>
					<!--- Process form login --->
					<cfset user = application.userService.get(form.username) /> 
					<cfset auth = user.auth(form.username,form.password) />
					
					<cfif not auth>
						<cfset message = "Authentication Failed">
					</cfif>
					
				</cfif>
			
				<cfif not auth>
					<!--- Display form login --->	
					<cf_header />
					<cf_loginform message="#message#" />
					<cf_footer />
					
					<cfabort>
				</cfif>	
			
				<!--- Handle persisting logged in back to the user object. --->
				<cfif auth>
					<cflock scope="session" timeout="1">
						<cfset session.user = user />
						<cfset session.user.setLoggedIn(TRUE) />
						<cfset session.user.SetYaccSettings(application.yaccsettings) />
						<cfset session.user.setCurrentToken() />
						<cfset application.transfer.save(session.user) />
					</cflock>
					<cfcookie name="yaccusername" value="#session.user.getUserName()#">
					<cfcookie name="yacctoken" value="#session.user.getCurrentToken()#">
				
				</cfif>	
	
			
		</cfif>		

		

	</cffunction>

	<!--- *********************************************************** --->
	<!--- handlelogout                                                 --->
	<!--- Handles logging out a user.                                  --->
	<!--- *********************************************************** --->
	<cffunction access="public" name="handlelogout" output="true" returntype="void" hint="Handles logging out a user.">
		<cfargument name="application" type="any" required="yes" hint="The application object for the site." />

		<cfset structDelete(cookie, "yaccusername") />
		<cfset structDelete(cookie, "yacctoken") />

		<cflock scope="session" timeout="1">
			<cfset arguments.application.onSessionStart() />
		</cflock>
		

	</cffunction>


</cfcomponent>