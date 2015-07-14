
<cfset coldspringXML = XMLParse(GetDirectoryFromPath(GetCurrentTemplatePath()) & "/coldspring.xml.cfm")/>




<!--- Create Coldspring Instance --->
<cfset application.cs = createObject("component","coldspring.beans.DefaultXmlBeanFactory").init()/>
<cfset application.cs.loadBeansFromXmlFile(GetDirectoryFromPath(GetBaseTemplatePath()) & "/config/coldspring.xml.cfm",true) />

<!--- Create Application Objects. --->
<cfset application.defaults = application.cs.getBean('defaults') />
<cfset application.debug = application.cs.getBean('debug') />
<cfset application.transfer = application.cs.getBean('Transfer') />

<cfset application.userService = application.cs.getBean('userService') />



<cfif CompareNoCase(application.applicationname, "yacc") neq 0>
	<cfset application.settings = application.cs.getBean('settings') />
	
	<cfset application.pageService = application.cs.getBean('pageService') />
	
	<cfset templatePath = application.settings.getYaccpath() & "/templates/" />
	
	<!--- Did this to handle injecting directory information into site config.  --->
	<cfset LayoutPath = templatePath & application.settings.getTemplate() &  "/layout/" />
	<cfset LayoutPathAbs = ExpandPath(LayoutPath)>
	<cfdirectory directory="#LayoutPathAbs#" action="list" name="layoutQuery" filter="*.cfm" />
	<cfset layouts = ReplaceNoCase(ValueList(layoutQuery.name), ".cfm", "", "ALL") />
	
	<cfset application.settings.setTemplatePath(LayoutPath) />
	<cfset application.settings.setLayouts(layouts) />
		
<cfelse>	
	<cfset application.settings = application.cs.getBean('yaccsettings') />
	<cfset templatePath = application.settings.getYaccpath() & "/templates/" />
</cfif>


<cfset application.yaccsettings = application.cs.getBean('yaccsettings') />


<cfset templatePathAbs = ExpandPath(templatePath)>
<cfdirectory directory="#templatePathAbs#" action="list" name="templateQuery" type="dir" />

<cfquery dbtype="query" name="templateQuery">
	SELECT 	name
	FROM 	templateQuery
	WHERE 	name != <cfqueryparam cfsqltype="cf_sql_varchar" value=".svn" />
</cfquery>
<cfset templates = ReplaceNoCase(ValueList(templateQuery.name), ".cfm", "", "ALL") />


<cfset application.yaccsettings.setTemplates(templates) />


<cfset application.login = application.cs.getBean('login') />