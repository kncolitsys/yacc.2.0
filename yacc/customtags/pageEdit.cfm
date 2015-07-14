<!---    pageEdit.cfm

AUTHOR				: tpryan
CREATED				: 6/18/2008 4:39:43 PM
DESCRIPTION			: Allows users to set properties of a page.
---->

<cfprocessingdirective suppresswhitespace="yes">

	<cfparam name="attributes.page" type="any"	/>
	<cfset page = attributes.page>
	<cfajaxproxy cfc="#application.settings.getcfcpath()#.remote.edit" jsclassname="edit" />
	
	
	
	


	<cfsavecontent variable="jstoinject">
		<script type="text/javascript">
			function updatepage(){
				var title = document.getElementById('title').value;
				var layout = document.getElementById('layout').value;
				var path = document.getElementById('path').value;
				var editObj = new edit();
				editObj.page(path,title,layout);
				
				var alertItem  = document.getElementById('alert');
				alertItem.innerHTML = '<span class="alert">Your changes has been made.</span>'
				
				return false;
			}
		
			function closewindow(){
				var docloc = document.location.toString();
				var questloc = docloc.indexOf('?');
				var cleanloc = docloc.substr(0,questloc);
				window.location = cleanloc;
			
			}
			
			
		</script>
	
</cfsavecontent>
<cfhtmlhead text="#jstoinject#" />
	
	
	
	
	
	
	
	
	
	
	<cfwindow  width="330" height="240"  name="nuggetwindow" title="Edit Page Settings" closable="false" modal="true" draggable="true" resizable="false" initshow="true">

		<cfoutput>
		<form action="" method="get" onsubmit="updatepage();" name="page">
			<p id="alert"></p>
			<input type="hidden" name="path" value="#page.GetPath()#"  id="path" />	
			<label for="title">Title: </label>
			<input name="title" id="title" value="#page.getTitle()#" />
			
			<label for="layout">Layout: </label>
			<select name="layout" id="layout">
				<cfloop list="#application.settings.getLayouts()#" index="layout">
					<option value="#layout#"<cfif layout eq page.getLayout()> selected ="selected"</cfif>>#layout#</option>
				
				</cfloop>
			
			</select><br /><br /> 
			<input type="button" name="update" value="Update" onclick="updatepage();" />
			<input type="button" name="close" value="Close" onclick="closewindow();" />
		</form>
		</cfoutput>
	</cfwindow>

</cfprocessingdirective>
<!--- In case you call as a tag  --->
<cfexit method="exittag" />