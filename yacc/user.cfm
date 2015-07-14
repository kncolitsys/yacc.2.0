<cfparam name="url.method" type="string" default="list" />
<cfparam name="url.userID" type="numeric" default="0" />
<cfparam name="url.message" type="string" default="" />

<cfswitch expression="#url.method#">
	<cfcase value="list">
		<h2>Users</h2>
		<cfif CompareNoCase(url.message, "deleted") eq 0>
			<cfset message = "User has been deleted." />
		<cfelse>
			<cfset message = ""/>
		</cfif>
		
		<cfif len(message) gt 0>
			<cfoutput><p class="alert">#message#</p></cfoutput>
		</cfif>
		<cfset users = application.userService.list() />
		<cf_toolbarUser showList="FALSE" showAdd="TRUE" showRead="FALSE" showEdit="FALSE" showDelete="FALSE"/>
		<cfloop index="i" from="1" to="#users.RecordCount()#">
			<cf_displayUser user="#users#" showlist="FALSE" showAdd="FALSE" />
			
			<cfset users.next() />
		</cfloop>
		
	</cfcase>
	
	<cfcase value="read">
		<h2>Read User</h2>
		<cfset user = application.userService.get(url.userID) />
		<cf_displayUser user="#user#" showRead="FALSE" />
	</cfcase>

	<cfcase value="edit">
		<h2>Edit User</h2>
		<cfset user = application.userService.get(url.userID) />
		<cf_editUser user="#user#" showEdit="FALSE" message="#url.message#" />
	</cfcase>
	
	<cfcase value="delete_process">
		<cfset user = application.userService.get(url.userID) />
		<cfset application.userService.delete(user) />
		<cflocation url="?method=list&message=deleted" addtoken="FALSE" />
	</cfcase>
	
	<cfcase value="edit_process">
		<cfset user = application.userService.get(url.userID) />
		
		<cfif len(form.password) gt 0 or len(form.confirm) gt 0>
			<cfif CompareNoCase(form.password, form.confirm) eq 0>
				<cfset user.setPassword(form.password) />
			<cfelse>
				<cflocation url="?method=edit&userID=#user.getUserID()#&message=mismatch" addtoken="FALSE" />
			</cfif>
		
		</cfif> 
		
		<cfset user.setFirstName(form.firstName) />
		<cfset user.setLastName(form.lastName) />
		<cfset user.setUserName(form.userName) />
		<cfset user.setEmail(form.Email) />
		<cfset user.setIsAdmin(form.isAdmin) />
		<cfset application.userService.update(user) />
		
		<cflocation url="?method=edit&userID=#user.getUserID()#&message=updated" addtoken="FALSE" />
	</cfcase>

</cfswitch>