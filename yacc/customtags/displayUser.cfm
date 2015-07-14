<!---    displayUser.cfm

AUTHOR				: tpryan
CREATED				: 6/17/2008 5:56:08 PM
DESCRIPTION			: displays the details about a user. 
---->

<cfprocessingdirective suppresswhitespace="yes">
	<cfparam name="attributes.user" type="any" />
	<cfparam name="attributes.showRead" type="boolean" default="true" />
	<cfparam name="attributes.showEdit" type="boolean" default="true" />
	<cfparam name="attributes.showDelete" type="boolean" default="true" />
	<cfparam name="attributes.showList" type="boolean" default="true" />
	<cfparam name="attributes.showAdd" type="boolean" default="true" />
	
	<cfset user = attributes.user />

<cfoutput>
	<div class="user">
		<h3 class="name">#user.getDisplayName()#</h3>
		<cf_toolbarUser user="#user#" showList="#attributes.showList#" showAdd="#attributes.showAdd#" showRead="#attributes.showRead#" showEdit="#attributes.showEdit#" showDelete="#attributes.showDelete#"/>
		<table>
			<tr><th>First Name:</th><td>#user.getFirstName()#</td></tr>
			<tr><th>Last Name:</th><td>#user.getLastName()#</td></tr>
			<tr><th>Username:</th><td>#user.getUserName()#</td></tr>
			<tr><th>Email:</th><td>#user.getEmail()#</td></tr>
			<tr><th>Is Admin:</th><td>#YesNoFormat(user.getIsAdmin())#</td></tr>
			
		</table>
	</div>
	
</cfoutput>
</cfprocessingdirective>
<!--- In case you call as a tag  --->
<cfexit method="exittag" />