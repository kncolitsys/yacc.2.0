<cfcomponent extends="transfer.com.TransferDecorator">

	<!---*****************************************************--->
	<!---getSection   --->
	<!---Gets the sections assoicated with this page. --->
	<!---*****************************************************--->
	<cffunction access="public" name="getSectionArray" output="false" returntype="array" hint="Gets the sections assoicated with this page." >
		<cfset var resultArray = ArrayNew(1) />
		<cfset var transfer = GetTransfer() />
		<cfset var props = structNew() />
		<cfset var sectionQuery ="" />
		<cfset var section ="" />
		
		<!--- So why do this, and not rely on a oneTomany mapping? Cause it was throwing an error on update, about there being more than one path.
		So I did this, and it appears to work.  --->
		
		<cfset sectionQuery = transfer.listByProperty("page.section", "path",getTransferObject().getPath() )>
		
		
		<cfloop query="sectionQuery">
			<cfset props = structNew() />
			<cfset props.path = sectionQuery.path[sectionQuery.currentRow] />
			<cfset props.id = sectionQuery.id[sectionQuery.currentRow] />
			<cfset ArrayAppend(resultArray, transfer.get("page.section", props)) />
		</cfloop>
		

		<cfreturn resultArray />
	</cffunction>
	
	<cffunction name="setTemplate" access="public" returntype="void" default="void" hint="Mutator for property Template" output="false">
		<cfargument name="Template" type="string" required="true" hint="The TemplatePath to set password to">
		<cfset variables.instance.Template = arguments.Template />
		
	</cffunction>
	
	<cffunction name="getTemplate" access="public" returntype="string" default="void" hint="Accessor for Template" output="false">
		
		<cfreturn instance.Template />
	</cffunction>


	<cffunction name="determineTemplatePath" access="public" returntype="string" default="void" hint="Accessor for TemplatePath" output="false">
		
		<cfset var layout = getTransferObject().GetLayout() />
		<cfset var template = getTemplate() />
		
		
		
		<cfreturn "#template##layout#.cfm" />
	</cffunction>

</cfcomponent>

	