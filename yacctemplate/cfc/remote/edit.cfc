<cfcomponent extends="yacc.cfc.remote.edit">

	<cffunction access="remote" name="nugget" output="false" returntype="void" hint="Allows editing of nuggets." >
		<cfargument name="id" type="string" required="yes" hint="The Id of the nugget." />
		<cfargument name="content" type="string" required="yes" hint="The Id of the nugget." />
	
		<cfset Super.nugget(id=arguments.id, content=arguments.content) />
	
	</cffunction>
	
	<cffunction access="remote" name="page" output="false" returntype="void" hint="Allows editing of pages." >
		<cfargument name="path" type="string" required="yes" hint="The path of the page." />
		<cfargument name="title" type="string" required="yes" hint="The title of the page." />
		<cfargument name="layout" type="string" required="yes" hint="The yalout of the page." />
	
		<cfset Super.page(path=arguments.path, title=arguments.title, layout=arguments.layout) />
	
	</cffunction>
	
	<cffunction access="remote" name="section" output="false" returntype="void" hint="Allows editing of section." >
		<cfargument name="path" type="string" required="yes" hint="The path of the section." />
		<cfargument name="id" type="string" required="yes" hint="The Id of the section." />
		<cfargument name="content" type="string" required="yes" hint="The Id of the section." />
	
		<cfset Super.section(path=arguments.path, id=arguments.id, content=arguments.content) />
	
	</cffunction>

	<cffunction access="remote" name="site" output="false" returntype="void" hint="Allows editing of a site." >
		<cfargument name="template" type="string" required="yes" hint="The path of the section." />
		
		<cfset Super.site(template=arguments.template) />

	
	</cffunction>


</cfcomponent>