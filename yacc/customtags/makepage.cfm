<!---    makepage.cfm

AUTHOR				: tpryan
CREATED				: 6/11/2008 11:53:34 PM
DESCRIPTION			: Give people the option to make this page.
---->

<cfprocessingdirective suppresswhitespace="yes">

<cfparam name="attributes.page" type="string"  />

<cfset page = application.pageService.get(attributes.page) />


<cfif structKeyExists(url, "makepage")>
	<cfset application.pageService.make(page=attributes.page, user=session.user) />
	<cflocation url="#attributes.page#" addtoken="false" />
</cfif>

<cfif structKeyExists(url, "remakepage")>
	<cfset application.pageService.make(page=attributes.page, user=session.user, skipDatabase=TRUE) />
	<cflocation url="#attributes.page#" addtoken="false" />
</cfif>

<cfif structKeyExists(url, "startfresh")>
	<cfset application.pageService.delete(page=attributes.page) />
	<cfset application.pageService.make(page=attributes.page, user=session.user) />
	<cflocation url="#attributes.page#" addtoken="false" />
</cfif>


<cfif page.getIsPersisted()>
	<cfset sections = page.getsectionArray() />
	
	<cfoutput>
		<div id="main" class="">
			<p>This page does not exist in the site, but there is a record matching it in the database. </p> 
			<p>This usually happens because you deleted a page directly rather than use <cfoutput><em>#application.cms.title#</em></cfoutput>.</p>
			<p>Do you want to:</p> 
			<ul>
				<li><a href="#attributes.page#?remakepage">Create a new page based on what's in the database.</a></li>
				<li><a href="#attributes.page#?startfresh">Delete the database information and create a fresh page.</a></li>
			</ul>
		<br />
		<div style="border: 1px solid ##DDDDDD; background-color: ##EEEEEE;">
		<h2>Database Content</h2>
		<cfloop index="i" from="1" to="#ArrayLen(sections)#">
			<div class="section" style="border: 1px solid ##CCCCCC; ; background-color: ##FAFAFA; margin: 5px; padding: 5px;">
			<h3>Section: #sections[i].getId()#</h3>
			#sections[i].getContent()#
			</div>
		</cfloop>
		</div>
		
		</div>
		
		
	</cfoutput>
<cfelse>

	<cfoutput>
		<div id="main" class="">
			<p>This page does not exist yet.  Do you want it to? <a href="#attributes.page#?makepage">Yes</a></p>
		</div>
	</cfoutput>

</cfif>





</cfprocessingdirective>
<!--- In case you call as a tag  --->
<cfexit method="exittag" />