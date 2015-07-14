<!---    editUser.cfm

AUTHOR				: tpryan
CREATED				: 6/17/2008 11:20:45 PM
DESCRIPTION			: Displays an interface to edit user. 
---->

<cfprocessingdirective suppresswhitespace="yes">
	<cfparam name="attributes.user" type="any" />
	<cfparam name="attributes.showRead" type="boolean" default="true" />
	<cfparam name="attributes.showEdit" type="boolean" default="true" />
	<cfparam name="attributes.showDelete" type="boolean" default="true" />
	<cfparam name="attributes.showList" type="boolean" default="true" />
	<cfparam name="attributes.showAdd" type="boolean" default="true" />
	<cfparam name="attributes.message" type="string" default="" />
	
	<cfset user = attributes.user />
	
	<cfif CompareNoCase(attributes.message, "updated") eq 0>
		<cfset message = "User has been updated." />
	<cfelseif CompareNoCase(attributes.message, "mismatch") eq 0>
		<cfset message = "Password does not match confirmation." />	
	<cfelse>
		<cfset message = ""/>
	</cfif>


	<cfoutput>
		<cf_toolbarUser user="#user#" showList="#attributes.showList#" showAdd="#attributes.showAdd#" showRead="#attributes.showRead#" showEdit="#attributes.showEdit#" showDelete="#attributes.showDelete#"/>
		
		<form action="?method=edit_process&amp;userID=#user.getuserID()#" method="post" id="user">
			<cfif len(message) gt 0>
			<p class="alert">#message#</p>
			</cfif>
			<fieldset>
			<label for="firstname">First Name:</label>
			<input name="firstname" id="firstname" value="#user.getFirstName()#" /><br />
			<label for="lastname">Last Name:</label>
			<input name="lastname" id="lastname" value="#user.getLastName()#" /><br />
			<label for="username">Username:</label>
			<input name="username" id="username" value="#user.getUserName()#" /><br />
			
			<label for="password">Password:</label>
			<input name="password" id="password" value="" type="password" /><br />
			
			<label for="confirm">Confirm Password:</label>
			<input name="confirm" id="confirm" value="" type="password" /><br />
			
			
			<label for="email">Email:</label>
			<input name="email" id="email" value="#user.getEmail()#" /><br />
			<label for="isadmin">Is Admin:</label>
			<label for="isadminyes">
				<input name="isadmin" id="isadminyes" value="1" type="radio" class="radio" <cfif user.getIsAdmin()> checked="checked" </cfif> /> Yes
			</label>
			<label for="isadminno">
				<input name="isadmin" id="isadminno" value="0" type="radio" class="radio" <cfif not user.getIsAdmin()> checked="checked" </cfif> /> No
			</label>
			
			<input name="submit" type="submit" class="submit" value="Save">
			</fieldset>
		</form>

	</cfoutput>

</cfprocessingdirective>
<!--- In case you call as a tag  --->
<cfexit method="exittag" />