<cfcomponent >

	<!---*****************************************************--->
	<!---init--->
	<!---This is the pseudo constructor that allows us to play little object games.--->
	<!---*****************************************************--->
	<cffunction access="public" name="init" output="FALSE" returntype="any" hint="This is the pseudo constructor that allows us to play little object games." > 
		<cfargument name="transfer" type="any" required="yes" hint="The tranfser factor for the application. " />
		<cfargument name="defaults" type="any" required="yes" hint="A defaults config object." />
		<cfargument name="settings" type="any" required="yes" hint="The settings for the application. " />

		<cfset variables.transfer = arguments.transfer />
		<cfset variables.defaultLayout = arguments.defaults.getLayout() />
		<cfset variables.defaultID = arguments.defaults.getID() />
		<cfset variables.settings = arguments.settings />
		
		<cfreturn This />
	</cffunction>


	<!---*****************************************************--->
	<!---make   --->
	<!---Makes a page in the database and filesystem.  --->
	<!---*****************************************************--->
	<cffunction access="public" name="make" output="false" returntype="void" hint="Makes a page in the database and filesystem. " >
		<cfargument name="page" type="string" required="yes" hint="The cgi path of the page to create." />
		<cfargument name="user" type="any" required="yes" hint="The user object to associate with page." />
		<cfargument name="id" type="string" default="#variables.defaultID#" hint="The id of the section to create by default on this page." />
		<cfargument name="layout" type="string" default="#variables.defaultLayout#" hint="The id of the section to create by default on this page." />
		<cfargument name="skipFile" type="boolean" default="FALSE" hint="Whether or not to skip file creation. " />
		<cfargument name="skipDatabase" type="boolean" default="FALSE" hint="Whether or not to skip creating the item in the database." />
		
		<cfset var contents = '<cf_section id="#arguments.id#" />' />
		<cfset var file = ExpandPath(arguments.page) />
		<cfset var pageObj = "" />
		
		<cfif not arguments.skipFile>
			<cfset FileWrite(file, contents) />
		</cfif>
		
		<cfif not arguments.skipDatabase>
			<cfset pageObj = variables.transfer.new("page.page") />
			<cfset pageObj.setPath(arguments.page) />
			<cfset pageObj.setLayout(arguments.layout) />
			<cfset pageObj.setUpdatedBy(arguments.user) />
			<cfset pageObj.setUpdatedOn(Now()) />
			<cfset variables.transfer.save(pageObj) />
		</cfif>
		
	
	</cffunction>


	<!---*****************************************************--->
	<!---get   --->
	<!---Gets a page object fom the database. --->
	<!---*****************************************************--->
	<cffunction access="public" name="get" output="false" returntype="any" hint="Gets a page object fom the database." >
		<cfargument name="page" type="string" required="yes" hint="the cgi path of the page to retrieve." />
		
		
		
		<cfset var pageObj = variables.transfer.get("page.page", arguments.page) />
		<cfif len(pageObj.getLayout()) lt 1>
			<cfset pageObj.setLayout(variables.defaultLayout) />
		</cfif>
		
		
		<cfset pageObj.setTemplate(settings.gettemplatepath()) />
		
		<cfreturn pageObj />
		
		
		
	</cffunction>



	<!---*****************************************************--->
	<!---delete   --->
	<!---Removes a page from both the database, and the file system.  --->
	<!---*****************************************************--->
	<cffunction access="public" name="delete" output="false" returntype="void" hint="Removes a page from both the database, and the file system. " >
		<cfargument name="page" type="string" required="yes" hint="The page to delete." />
		
		<cfset var file = ExpandPath(arguments.page) />
		<cfset var pageObj = get(arguments.page) />
		<cfset var sections = pageObj.getsectionArray() />
		<cfset var i = 0 />
		
		<cfloop index="i" from="1" to="#ArrayLen(sections)#">
			<cfset variables.transfer.delete(sections[i]) />
		</cfloop>
			
		<cfset variables.transfer.delete(pageObj) />
		<cfif FileExists(file)>
			<cfset fileDelete(file) />
		</cfif>
	
		
	</cffunction>




</cfcomponent>