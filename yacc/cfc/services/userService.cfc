<cfcomponent>

	<!---*****************************************************--->
	<!---init--->
	<!---This is the pseudo constructor that allows us to play little object games.--->
	<!---*****************************************************--->
	<cffunction access="public" name="init" output="FALSE" returntype="any" hint="This is the pseudo constructor that allows us to play little object games." > 
		<cfargument name="transfer" type="any" required="yes" hint="The tranfser factor for the application. " />
		<cfargument name="yaccsettings" type="any" required="yes" hint="The yaccsettings factor for the application. " />
		
		<cfset variables.transfer = arguments.transfer />
		<cfset variables.yaccsettings = arguments.yaccsettings />
		
		<cfreturn This />
	</cffunction>

	<!---*****************************************************--->
	<!---list   --->
	<!---Gets an IBO that represents all of the users in the site. --->
	<!---*****************************************************--->
	<cffunction access="public" name="list" output="false" returntype="any" hint="Gets an IBO that represents all of the users in the site." >
		<cfargument name="property" type="string" default="" hint="Use to fire off a listByProperty under the covers." />
		<cfargument name="propertyMap" type="struct" default="#structNew()#" hint="Use to fire off a listByPropertyMap under the covers." />
		<cfargument name="orderProperty" type="string" default="" hint="The property to order results by." />
		<cfargument name="ASC" type="boolean" default="true" hint="Order Ascending (asc)." />
		<cfargument name="useAliases" type="boolean" default="TRUE" hint="Whether to return values set in transfer properties or values from the database." />
	
		<cfset var IBO = createObject("component", "yacc.cfc.IBO").init() />
		<cfset var resultsQuery = "" />
		
		<cfif ArrayLen(structKeyArray(arguments.propertyMap)) gt 1>
			<cfset resultsQuery = variables.transfer.listByPropertyMap('user.user', arguments.propertymap, arguments.orderProperty, arguments.asc, arguments.useAliases) />	
		<cfelseif len(arguments.property) gt 0>
			<cfset resultsQuery = variables.transfer.listByProperty('user.user', arguments.property, arguments.orderProperty, arguments.asc, arguments.useAliases) />	
		<cfelse>
			<cfset resultsQuery = variables.transfer.list('user.user', arguments.orderProperty, arguments.asc, arguments.useAliases) />	
		</cfif>
		
		<cfquery dbtype="query" name="resultsQuery">
			SELECT *, firstname + ' ' + lastname as displayName
			FROM	resultsQuery
		</cfquery>
	
		<cfset IBO.attachQuery(resultsQuery) />
	
		<cfreturn IBO />
	</cffunction>
	
	<!---*****************************************************--->
	<!---get   --->
	<!---Returns a transfer user object.  --->
	<!---*****************************************************--->
	<cffunction access="public" name="get" output="false" returntype="any" hint="Returns a transfer user object. " >
		<cfargument name="id" type="any" required="true" hint="The userID of the user to retrieve." />
	
		<cfset var user = "">	
	
		<cfif IsNumeric(arguments.id)>
			<cfset user = variables.transfer.get('user.user', arguments.id) />
		<cfelse>
			<cfset user = variables.transfer.readByProperty('user.user',"username",arguments.id) />
		</cfif>
		
		<cfset user.SetYaccSettings(variables.yaccsettings) />
	
		<cfreturn user />
	</cffunction>
	
	<!---*****************************************************--->
	<!---update   --->
	<!---Updates the user object.  
		 Not sure if I should ot it this way, 
		 but in theory, I can ditch transfer if I need to.
		 Actually, later I want to add notification of new accounts.
		 This is the way to accomplish that.
		 
		 --->
	<!---*****************************************************--->
	<cffunction access="public" name="update" output="false" returntype="void" hint="Updates the user object." >
		<cfargument name="user" type="any" required="yes" hint="A user object." />
	
		<cfset variables.transfer.save(arguments.user) />
		
	</cffunction>
	
	<!---*****************************************************--->
	<!---delete   --->
	<!---Deletes a user --->
	<!---*****************************************************--->
	<cffunction access="public" name="delete" output="false" returntype="string" hint="Deletes a user" >
		<cfargument name="user" type="any" required="yes" hint="A user object." />
		<cfset variables.transfer.delete(arguments.user) />
	</cffunction>

</cfcomponent>
