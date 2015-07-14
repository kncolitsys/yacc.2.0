<!---    nav.cfm

AUTHOR				: tpryan
CREATED				: 6/18/2008 0:50:30 AM
DESCRIPTION			: Present the navigation of the site.
---->

<cfprocessingdirective suppresswhitespace="yes">

			<h1>Admin Options</h1>
			<ul id="nav" class="sidemenu">
				<li><a href="index.cfm" title="Main Page">Main</a></li>
				<li><a href="user.cfm" title="Administer Users">Users</a></li>
				<li><a href="?logout" title="Logout">Logout</a></li>
			</ul>

	
	
	</cfprocessingdirective>
	<!--- In case you call as a tag  --->
	<cfexit method="exittag" />