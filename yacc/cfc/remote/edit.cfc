<cfcomponent >

	<cffunction access="remote" name="nugget" output="false" returntype="void" hint="Allows editing of nuggets." >
		<cfargument name="id" type="string" required="yes" hint="The Id of the nugget." />
		<cfargument name="content" type="string" required="yes" hint="The Id of the nugget." />
	
		<cfset var nugget = application.transfer.get("page.nugget", arguments.id) />
		<cfset nugget.setID(arguments.id) />
		<cfset nugget.setUpdatedBy(session.user) />
		<cfset nugget.setUpdatedOn(Now()) />
		<cfset nugget.setContent(arguments.content) />
		<cfset application.transfer.save(nugget)>
	
	</cffunction>
	
	<cffunction access="remote" name="page" output="false" returntype="void" hint="Allows editing of pages." >
		<cfargument name="path" type="string" required="yes" hint="The path of the page." />
		<cfargument name="title" type="string" required="yes" hint="The title of the page." />
		<cfargument name="layout" type="string" required="yes" hint="The yalout of the page." />
	
		<cfset var page = application.transfer.get("page.page", arguments.path) />
		<cfset page.setTitle(arguments.title) />
		<cfset page.setUpdatedBy(session.user) />
		<cfset page.setUpdatedOn(Now()) />
		<cfset page.setLayout(arguments.layout) />
		<cfset application.transfer.save(page)>
	
	</cffunction>
	
	<cffunction access="remote" name="section" output="false" returntype="void" hint="Allows editing of section." >
		<cfargument name="path" type="string" required="yes" hint="The path of the section." />
		<cfargument name="id" type="string" required="yes" hint="The Id of the section." />
		<cfargument name="content" type="string" required="yes" hint="The Id of the section." />
	
		<cfset var section ="" />
		<cfset var key = StructNew() />
		<cfset key.path = arguments.path />
		<cfset key.id = arguments.id />
		<cfset section = application.transfer.get("page.section", key) />	
			
		<cfset section.setID(arguments.id) />
		<cfset section.setPath(arguments.path) />
		<cfset section.setUpdatedBy(session.user) />
		<cfset section.setUpdatedOn(Now()) />
		<cfset section.setContent(arguments.content) />
		<cfset application.transfer.save(section)>
	
	</cffunction>
	
	<cffunction access="remote" name="site" output="false" returntype="void" hint="Allows editing of a site." >
		<cfargument name="template" type="string" required="yes" hint="The path of the section." />
		
		<cfset var configDir = ExpandPath(application.settings.getPath()) & "/config/coldspring.xml.cfm" />
		<cfset var configXML = CreateObject("component", "betterXMLEditor").init(configDir) />
		
		<cfset application.settings.setTemplate(arguments.template) />
		<cfset configXML.update("//entry[@key='template']/value", arguments.template) />
		
		<cfset configXML.write(configDir)>
		
	
	
	</cffunction>

</cfcomponent>