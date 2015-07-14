<cfcomponent extends="transfer.com.TransferDecorator">

	<cffunction name="configure" access="private" returntype="void" output="false">
		<cfset setLoggedIn(FALSE) />
	</cffunction>

	<cffunction name="setYaccsettings" access="public" returntype="void" output="false">
		<cfargument name="Yaccsettings" type="any" required="true">
		<cfset variables.instance.YaccSettings = arguments.YaccSettings />
	</cffunction>
	
	<cffunction name="setCurrentToken" access="public" returntype="void" default="void" hint="Mutator for property Current Token" output="false">
		
		
		<cfset var localtoken = Now() &  "|" & getTransferObject().getUsername() />
		<cfset var secret = instance.YaccSettings.getCookieSecret() />
		<cfset localtoken = encrypt(localtoken, secret, "CFMX_COMPAT", "Base64") />
		
		
		<cfset getTransferObject().setCurrentToken(localtoken) /> 
	</cffunction>
	
	<!---*****************************************************--->
	<!---authCurrentToken   --->
	<!---Authenticates the current token. --->
	<!---*****************************************************--->
	<cffunction access="public" name="authCurrentToken" output="false" returntype="boolean" hint="Authenticates the current token." >
		<cfargument name="token" type="string" required="yes" hint="The token to verify." />
		
		
		<cfset var tokenStruct = decryptToken(arguments.token) />
		<cfset var dateToCheck = "" />
		<cfset var auth = FALSE />
		<cfset var actualUsername = getTransferObject().getUsername() />
		<cfset var actualToken = getTransferObject().getCurrentToken() />
		<cfset var expUnit = instance.yaccsettings.getcookieExpirationUnit() />
		<cfset var expCount = instance.yaccsettings.getcookieExpirationCount() />
		
		<cfif len(arguments.token) lt 1>
			<cfreturn auth />
		</cfif>
		
		<cfif CompareNoCase(actualToken, arguments.token) neq 0>
			<cfreturn auth />
		</cfif>
		
		<cfset dateToCheck = DateAdd(expUnit, expCount, tokenStruct.date) />

		

		<cfif len(arguments.token) gt 0 AND 
			  CompareNoCase(tokenStruct.username, actualUsername) eq 0 AND
			  DateCompare(dateToCheck, now()) eq 1>
			<cfset auth = true />
		</cfif> 
		
		<cfreturn auth />
	</cffunction>
	
	
	
	

	<cffunction name="setpassword" access="public" returntype="void" default="void" hint="Mutator for property password" output="false">
		<cfargument name="password" type="string" required="true" hint="The value to set password to">
		<cfset var localPassword = hash(arguments.password,"SHA-512") />
		<cfset getTransferObject().setPassword(localPassword) />
	</cffunction>
	
	<cffunction name="getDisplayName" access="public" returntype="string" default="void" hint="Accessor for displayName" output="false">
		
		<cfreturn getTransferObject().getFirstName() & " " & getTransferObject().getLastName() />
	</cffunction>
	
	<cffunction name="auth" access="public" output="false" returntype="string" hint="Authenticates a user against the database." >
		<cfargument name="username" type="string" required="yes" hint="The username to auth. " />
		<cfargument name="password" type="string" required="true" hint="The password to try. " />
		
		<cfset var actual = StructNew() />
		<cfset var attempted = StructNew() />
		
		<cfset actual.username = getTransferObject().getUsername() />
		<cfset actual.password = getTransferObject().getPassword() />
		
		<cfset attempted.username = arguments.username />
		<cfset attempted.password = hash(arguments.password,"SHA-512") />
		
		<cfif compareNoCase(actual.username,attempted.username) eq 0 AND 
				compareNoCase(actual.password,attempted.password) eq 0 >
			<cfreturn TRUE />
		<cfelse>
			<cfreturn FALSE />
		</cfif>
			
	</cffunction>

	<cffunction name="setLoggedIn" access="public" returntype="void" output="false">
		<cfargument name="LoggedIn" type="boolean" required="true">
		<cfset variables.instance.LoggedIn = arguments.LoggedIn >
	</cffunction>

	<cffunction name="getLoggedIn" access="public" returntype="boolean" output="false">
		<cfreturn instance.LoggedIn />
	</cffunction>
	
	<!---*****************************************************--->
	<!---decryptToken   --->
	<!---Decrypts the cookie token in use for the application.  --->
	<!---*****************************************************--->
	<cffunction access="private" name="decryptToken" output="false" returntype="struct" hint="Decrypts the cookie token in use for the application. " >
		<cfargument name="token" type="string" required="yes" hint="The cookie token String." />
		
		<cfset var results = structNew() />
		<cfset var secret = instance.yaccsettings.getCookieSecret() />
		<cfset var tokenDecrypt = decrypt(arguments.Token, secret, "CFMX_COMPAT", "Base64")>
		
		<cfset results.date= GetToken(tokenDecrypt, 1, "|") />
		<cfset results.username = GetToken(tokenDecrypt, 2, "|") />
	
		<cfreturn results />
	</cffunction>

</cfcomponent>