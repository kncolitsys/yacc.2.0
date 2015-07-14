<!---    siteEdit.cfm

AUTHOR				: tpryan
CREATED				: 6/18/2008 10:32:27 PM
DESCRIPTION			: Allows you to set certain attributes about a site. 
---->

<cfprocessingdirective suppresswhitespace="yes">


	
	<cfajaxproxy cfc="#application.settings.getcfcpath()#.remote.edit" jsclassname="edit" />
	
	
	
	


	<cfsavecontent variable="jstoinject">
		<script type="text/javascript">
			function updatesite(){
				var template = document.getElementById('template').value;
				var editObj = new edit();
				editObj.site(template);
				
				var alertItem  = document.getElementById('alert');
				alertItem.innerHTML = '<span class="alert">Configuration has been changed. <br /> Close to see changes.</span>'
				
				return false;
			}
		
			function closewindow(){
				var docloc = document.location.toString();
				var questloc = docloc.indexOf('?');
				var cleanloc = docloc.substr(0,questloc) + "?reset_app=true";
				window.location = cleanloc;
			
			}
			
			
		</script>
	
</cfsavecontent>
<cfhtmlhead text="#jstoinject#" />
	
	
	
	
	
	
	
	
	
	
	<cfwindow  width="330" height="240"  name="nuggetwindow" title="Edit Page Settings" closable="false" modal="true" draggable="true" resizable="false" initshow="true">

		<cfoutput>
		<form action="" method="get" onsubmit="updatepage();" name="page">
			<p id="alert"></p>
			
		
			
			<label for="template">Template: </label>
			<select name="template" id="template">
				<cfloop list="#application.yaccsettings.gettemplates()#" index="template">
					<option value="#template#"<cfif template eq application.settings.gettemplate()> selected ="selected"</cfif>>#template#</option>
				
				</cfloop>
			
			</select><br /><br /> 
			<input type="button" name="update" value="Update" onclick="updatesite();" />
			<input type="button" name="close" value="Close" onclick="closewindow();" />
		</form>
		</cfoutput>
	</cfwindow>




</cfprocessingdirective>
<!--- In case you call as a tag  --->
<cfexit method="exittag" />