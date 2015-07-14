<cfcomponent >

<!---*****************************************************--->
<!---init--->
<!---This is the pseudo constructor that allows us to play little object games.--->
<!---*****************************************************--->
<cffunction access="public" name="init" output="FALSE" returntype="any" hint="This is the pseudo constructor that allows us to play little object games." > 
		
	<cfset variables.internal = StructNew() />
	<cfset variables.internal.initialized = FALSE />
	<cfset variables.internal.dirty = FALSE />
	<cfset variables.internal.daoed = FALSE />
		
	<cfreturn This />
</cffunction>

<cffunction access="public" name="attachDAO" output="false" returntype="void" hint="Associates a DAO with the item for updates." >
	<cfargument name="dao" type="any" required="yes" hint="The DAO needed for updates.">
	<cfset variables.internal.dao = arguments.dao />	
	<cfset variables.internal.daoed = TRUE />
</cffunction>

<cffunction access="public" name="attachQuery" output="false" returntype="void" hint="Associates a DAO with the item for updates." >
	<cfargument name="query" type="query" required="yes" hint="The query to turn into an IBO." />
	
	<cfset variables.internal.query = Duplicate(arguments.query) />
	<cfset variables.internal.original = Duplicate(arguments.query) />
	<cfset variables.internal.currentRow = 1 />
	<cfset variables.internal.updateQueue = structNew() />
	<cfset variables.internal.initialized = TRUE />
</cffunction>


<!--- Query position functions --->
<cffunction access="public" name="next" output="false" returntype="void" hint="Increments to the next record in the query." >
	<cfset testInitialized() />

	<cfif variables.internal.currentRow lt variables.internal.query.recordCount>
		<cfset variables.internal.currentRow = variables.internal.currentRow + 1 />
	</cfif>

</cffunction>

<cffunction access="public" name="prev" output="false" returntype="void" hint="Decrements to the previous record in the query." >
	<cfset testInitialized() />

	<cfif variables.internal.currentRow gt  1>
		<cfset variables.internal.currentRow = variables.internal.currentRow - 1 />
	</cfif>

</cffunction>

<cffunction access="public" name="currentrow" output="false" returntype="numeric" hint="Returns the current row from the query. " >
	<cfset testInitialized() />
	<cfreturn variables.internal.currentRow />
</cffunction>

<cffunction access="public" name="recordcount" output="false" returntype="numeric" hint="Returns the recordcount from the query. " >
	<cfset testInitialized() />
	<cfreturn variables.internal.query.recordCount />
</cffunction>

<cffunction access="public" name="first" output="false" returntype="void" hint="Decrements to the first record in the query." >
	<cfset testInitialized() />
	<cfset variables.internal.currentRow = 1 />
</cffunction>

<cffunction access="public" name="last" output="false" returntype="void" hint="Increments to the last record in the query." >
	<cfset testInitialized() />
	<cfset variables.internal.currentRow = variables.internal.query.recordCount />

</cffunction>

<cffunction access="public" name="isDone" output="false" returntype="boolean" hint="Determines if you are at the last position in the object." >
	<cfset testInitialized() />
	<cfreturn variables.internal.currentRow eq variables.internal.query.recordCount />
	
	
</cffunction>

<cffunction access="public" name="isInit" output="false" returntype="boolean" hint="Reports if object has been inititialized." >
	<cfreturn variables.internal.initialized />
</cffunction>

<cffunction access="public" name="isDAOed" output="false" returntype="boolean" hint="Reports if object has been given a dao." >
	<cfreturn variables.internal.daoed />
</cffunction>

<cffunction access="public" name="isDirty" output="false" returntype="boolean" hint="Reports if object has been changed but not commited." >
	<cfreturn variables.internal.dirty />
</cffunction>

<cffunction access="public" name="get" output="false" returntype="any" hint="The default get operation. " >
	<cfargument name="attribute" type="string" required="yes" default="" hint="The attribute to retrieve." />
	
	<cfset var result = "" />
	
	<cfset testInitialized() />
	
	<cfif structKeyExists(this, "get#attribute#")>
		<cfinvoke method="get#attribute#" returnvariable="result" />
		<cfelse>
		<cfset result = variables.internal.query[attribute][variables.internal.currentRow] />
	</cfif>

	<cfreturn result />
</cffunction>

<cffunction access="public" name="display" output="false" returntype="any" hint="The default display operation. " >
	<cfargument name="attribute" type="string" required="yes" default="" hint="The attribute to retrieve." />
	
	<cfset var result = "" />
	
	<cfset testInitialized() />
	
	<cfif structKeyExists(this, "display#attribute#")>
		<cfinvoke method="display#attribute#" returnvariable="result" />
		<cfelse>
		<cfset result = get(attribute) />
	</cfif>

	<cfreturn result />
</cffunction>

<cffunction access="public" name="set" output="false" returntype="string" hint="Sets a value on the IBO." >
	<cfargument name="attribute" type="string" required="yes" hint="The attribute to set." />
	<cfargument name="value" type="any" required="yes" hint="The value to set." />
	
	<cfset testInitialized() />
	
	<cfset variables.internal.updateQueue[variables.internal.currentRow][arguments.attribute] = arguments.value />
	
	<cfset variables.internal.query[arguments.attribute][variables.internal.currentRow] = arguments.value />
	
	<cfif not variables.internal.dirty>
		<cfset variables.internal.dirty = TRUE />
	</cfif>
</cffunction>

<cffunction access="public" name="commit" output="false" returntype="string" hint="Persists changes back to database. " >
	<cfset var modArray = StructKeyArray(variables.internal.updateQueue) />
	<cfset var i = 0 />
	<cfset var columnList =Lcase(variables.internal.query.columnList) />
	<cfset var collection = StructNew()>
	<cfset var column = "" />
	
	<cfset testInitialized() />
	
	<cfset testDAOed() />
	
	<cfloop index="i" from="1" to="#arrayLen(modArray)#">
		<cfset column = "" />
		<cfset collection = StructNew() />
		<cfloop list="#columnList#" index="column">
			<cfif structKeyExists(variables.internal.updateQueue[modArray[i]], column)>
				<cfset collection[column] = variables.internal.updateQueue[modArray[i]][column] />
			<cfelse>
				<cfset collection[column] = variables.internal.query[column][i] />
			</cfif>
			
		</cfloop>
		
		<cftry>
		<cfinvoke component="#variables.internal.dao#" method="update" argumentcollection="#collection#" />
			<cfcatch>
				<cfdump var="#collection#">
				<cfdump var="#cfcatch#">
				<cfabort>
				
			</cfcatch>
		</cftry>
		
		
		
	</cfloop>
	<cfset makeClean() />

</cffunction>

<cffunction access="public" name="revert" output="false" returntype="void" hint="Reverts the Query back to it's original state, throwing away any changes since the last commit." >
	<cfset variables.internal.query = variables.internal.original  />
	<cfset makeClean() />
</cffunction>

<cffunction access="public" name="onMissingMethod">
	<cfargument name="missingMethodName" />
	<cfargument name="missingMethodArguments" />
      
	<cfset var attribute = "" />
	
	<cfif CompareNoCase(left(arguments.missingMethodName, 3),"get") eq 0>
		<cfset attribute = Right(arguments.missingMethodName, len(arguments.missingMethodName)-3 ) />
		<cfreturn get(attribute) />
	<cfelseif CompareNoCase(left(arguments.missingMethodName, 7),"display") eq 0>	
		<cfset attribute = Right(arguments.missingMethodName, len(arguments.missingMethodName)-7 ) />
		<cfreturn get(attribute) />
	<cfelseif CompareNoCase(left(arguments.missingMethodName, 3),"set") eq 0>	
		<cfset attribute = Right(arguments.missingMethodName, len(arguments.missingMethodName)-3 ) />
		
		
		<cfreturn set(attribute, arguments.missingMethodArguments[1]) />	
	</cfif>
     
   
</cffunction>

<cffunction access="public" name="debug" output="false" returntype="struct" hint="Returns the internal state of the application. " >
	<cfreturn variables.internal />
</cffunction>

<cffunction access="private" name="makeClean" output="false" returntype="void" hint="Marks the object as clean." >
	<cfset variables.internal.updateQueue = StructNew() />
	<cfset variables.internal.dirty = FALSE />
</cffunction>

<cffunction access="private" name="testInitialized" output="false" returntype="void" hint="Ensures the IBO is initialized." >
	<cfif not variables.internal.initialized>
		<cfthrow message="IBO not initialized" detail="The IBO must be passed an query via the attachQuery method before this method can be called." />
	</cfif>

</cffunction>

<cffunction access="private" name="testDAOed" output="false" returntype="void" hint="Ensures the IBO has a DAO." >
	<cfif not structKeyExists(variables.internal, "dao")>
		<cfthrow message="DAO Required for this method" detail="The IBO must be passed a DAO via the attachDAO method before this method can be called." />
	</cfif>

</cffunction>

</cfcomponent>