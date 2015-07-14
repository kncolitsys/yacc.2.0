<cfcomponent output="false">
	
	<cfset this.name = "yacc" />
	<cfset this.applicationTimeout = createTimeSpan(0,2,0,0) />
	<cfset this.sessionManagement = true />
	<cfset this.sessionTimeout = createTimeSpan(0,0,20,0) />
	<cfset this.setClientCookies = true />
	<cfset this.welcomeFileList = "">
	<cfset this.mappings = structNew()>
	<cfset this.mappings[this.name] = getDirectoryFromPath(getCurrentTemplatePath())>
	<cfset this.customtagpaths = "#getDirectoryFromPath(getCurrentTemplatePath())#customtags"/>

	<!--- *********************************************************** --->
	<!--- onRequestStart                                              --->
	<!--- Automatically fires when an application is started.         --->
	<!--- *********************************************************** --->
	<cffunction name="onApplicationStart" returnType="boolean" output="false">
		
		<cfinclude template="config/createObjects.cfm" />
		<cfinclude template="config/scheduledTasks.cfm" />
		
		<cfreturn true>
	</cffunction>
	
	<!--- *********************************************************** --->
	<!--- onRequestStart                                              --->
	<!--- Automatically fires when an application is ended.           --->
	<!--- *********************************************************** --->
	<cffunction name="onApplicationEnd" returnType="void" output="false">
		<cfargument name="applicationScope" required="true">
	</cffunction>

	<!--- *********************************************************** --->
	<!--- onMissingTemplate                                           --->
	<!--- Fired when user requests a CFM that doesn't exist.          --->
	<!--- *********************************************************** --->
	<cffunction name="onMissingTemplate" returnType="boolean" output="true">
		<cfargument name="targetpage" required="true" type="string">
		
		<cflocation url="/yacc/404.cfm?targetpage=#arguments.targetpage#" addtoken="false" />
		
		
		<cfreturn true>
	</cffunction>

	<!--- *********************************************************** --->
	<!--- onRequestStart                                              --->
	<!--- Automatically fires when a request is started.              --->
	<!--- *********************************************************** --->
	<cffunction name="onRequestStart" returnType="boolean" output="true">
		<cfargument name="thePage" type="string" required="true">
		
		<cfif listlast(arguments.thePage,".") is "cfc">
			<cfset StructDelete(this, "onRequest") />
			<cfset StructDelete(variables,"onRequest")/>
		</cfif>
		
		<cfif structKeyExists(url,"reset_app")>
			<cfset onApplicationStart() />
		</cfif>
		
		<cfif structKeyExists(application, "debug")>
			<cfsetting showdebugoutput="#application.debug.getShow()#">
		</cfif>
		
		<cfif structKeyExists(url,"logout")>
			<cfset application.login.handleLogout(this) />
		</cfif>
		
		<cfset application.login.handleLogin() />
		
		
		
		<cf_header showNav="#session.user.getLoggedIn()#" />


		
		
		<cfreturn true>
	</cffunction>
	

	
	<!--- *********************************************************** --->
	<!--- onRequestEnd                                                --->
	<!--- Automatically fires when a request is ended  .              --->
	<!--- *********************************************************** --->
	<cffunction name="onRequestEnd" returnType="void" output="true">
		<cfargument name="thePage" type="string" required="true">
		
		<cf_footer showNav="#session.user.getLoggedIn()#" />


		
	</cffunction>

	<!--- *********************************************************** --->
	<!--- onError                                                     --->
	<!--- Overriding error handler for entire application.            --->
	<!--- *********************************************************** --->
	<cffunction name="onError" output="true" hint="Overriding error handler for entire application.">
		<cfargument name="Exception" required="yes" />
		<cfargument name="EventName" type="string" required="yes" />

		<!--- The next series of exceptions prevent cflocation and cfabort from casuing issues. --->
		<cfif isdefined("exception.rootcause.type") and FindNoCase("coldfusion.runtime.AbortException",exception.rootcause.type)>
			<cfreturn />
		</cfif>

		<cfif IsDefined("arguments.exception.rootCause") AND arguments.exception.rootCause eq "coldfusion.runtime.AbortException">
			<cfreturn />
		</cfif>

		<cfif isdefined("Exception.type") and FindNoCase("coldfusion.runtime.AbortException", Exception.type)>
			<cfreturn />
		</cfif>

		<!--- Prevents the login in check in OnRequestStart from throwing an error. --->
		<cfif isdefined("exception.rootcause.message") and FindNoCase("NotLoggedIn",exception.rootcause.message)>
			<cfreturn />
		</cfif>
		<!--- Prevents the login in check in OnRequestStart from throwing an error. --->
		<cfif isdefined("exception.message") and FindNoCase("NotLoggedIn",exception.message)>
			<cfreturn />
		</cfif>

		
		<!--- If the application is in debugging mode, don't bother emailing the error. --->
		<cfif structKeyExists(application,  "debug") AND not isSimpleValue(application.debug) AND not application.debug.getShow()>
			<!--- Handles Error Processing --->
			<!--- Emails the error message. --->
			<cfinvoke method="onErrorEmail">
				<cfinvokeargument name="exception"  value="#arguments.exception#"/>
				<cfinvokeargument name="emailFrom"  value="#application.yaccsettings.getadminemail()#"/>
				<cfinvokeargument name="emailTo"  value="#application.yaccsettings.getadminemail()#"/>
			</cfinvoke>
		</cfif>

		<!--- Rethrow the error to the cferror in the top of the application.cfc  --->
		<!--- <cfthrow object="#arguments.exception#"> --->
		
		<cfif structKeyExists(application, "debug") AND not isSimpleValue(application.debug) and application.debug.getShow()>
			<cfoutput>#generateErrorDebugging(arguments.exception)#</cfoutput>
		<cfelse>
			<!--- <cflocation url="error.cfm" addtoken="FALSE"/> --->
			
			<cfdump var="#arguments.exception#">
		</cfif>

		<cfreturn />
	</cffunction>

	<!--- *********************************************************** --->
	<!--- onSessionStart                                              --->
	<!--- Automatically fires when a session is started  .            --->
	<!--- *********************************************************** --->
	<cffunction name="onSessionStart" returnType="void" output="false">
		<cfset session.user = application.userService.get(0) />
	</cffunction>

	<!--- *********************************************************** --->
	<!--- onSessionEnd                                                --->
	<!--- Automatically fires when a session is ended  .              --->
	<!--- *********************************************************** --->
	<cffunction name="onSessionEnd" returnType="void" output="false">
		<cfargument name="sessionScope" type="struct" required="true">
		<cfargument name="appScope" type="struct" required="false">
	</cffunction>

	<!--- *********************************************************** --->
	<!--- generateErrorDebugging                                      --->
	<!--- Generates the full debugging of a application error.        --->
	<!--- *********************************************************** --->
	<cffunction name="generateErrorDebugging" access="public" output="false" returntype="string" hint="Generates the full debugging of a application error.">
		<cfargument name="exception" required="no" hint="The exception object generated by the error." />
		<cfset var results= "" />

		<cfsavecontent variable="results">
		<cfoutput>
		<h1>Error Message</h1>
		<cfif isdefined("arguments.exception")>
		<table>
		<tr><td valign="top"><strong>Date/Time:</strong></td><td>#Now()#</td></tr>
		<tr><td valign="top"><strong>Error:</strong></td><td>#Exception.message#</td></tr>
		<tr><td valign="top"><strong>Detail:</strong></td><td>#Exception.Detail#</td></tr>
		<tr><td valign="top"><strong>Page:</strong></td><td>#cgi.script_name#</td></tr>
		</table>
		<br><br>
		
		<cfdump var="#arguments.exception#">
		</cfif>

		<cfif structKeyExists(application, "debug") and not isSimpleValue(application.debug)>
			<!--- Optional:  this code dumps the session structure of the user who encountered the error to assist you in your bug hunt. --->
			<cfif isdefined("arguments.exception") and application.debug.get('exception')>
				<h1>Exception</h1>
				<cfdump var="#exception#" />
			</cfif>
	
			<cfif isdefined("application") and application.debug.get('application')>
				<h1>Application</h1>
				<cfdump var="#application#" />
			</cfif>
	
			<cfif isdefined("session") and application.debug.get('session')>
				<h1>Session</h1>
				<cfdump var="#session#" />
			</cfif>
	
			<cfif isdefined("cgi") and application.debug.get('cgi')>
				<h1>CGI</h1>
				<cfdump var="#cgi#" />
			</cfif>
	
			<cfif isdefined("url") and application.debug.get('url')>
				<h1>URL</h1>
				<cfdump var="#url#" />
			</cfif>
	
			<cfif isdefined("server") and application.debug.get('server')>
				<h1>Server</h1>
				<cfdump var="#server#" />
			</cfif>
	
			<cfif isdefined("form") and application.debug.get('form')>
				<h1>Form</h1>
				<!--- Please take care to not reveal password information --->
				<!--- Do not allow cfmail to send out passwords.  --->
				<cfif isdefined("form.password")>
					<cfset form.password="*****************" />
				</cfif>
	
				<cfdump var="#form#" />
			</cfif>
		</cfif>
		</cfoutput>
		</cfsavecontent>

		<cfreturn results />
	</cffunction>

	<!--- *********************************************************** --->
	<!--- onErrorEmail                                                --->
	<!--- Emails the administrator                                    --->
	<!--- *********************************************************** --->
	<cffunction name="onErrorEmail" output="false" returntype="void" hint="Creates an email message based on an error, and sends it to the input[email]">
		<cfargument name="exception" required="yes" hint="The exception object generated by the error." />
		<cfargument name="emailFrom" type="string" required="yes" hint="The email to which to send the error information." />
		<cfargument name="emailTo" type="string" required="yes" hint="The email from which to send the error information." />

		<CFMAIL type="html" to="#arguments.emailTo#" from="#arguments.emailFrom#" subject="Error - Yacc">
			#generateErrorDebugging(arguments.exception)#
		</cfmail>

	</cffunction>


	

	
	
	

</cfcomponent>