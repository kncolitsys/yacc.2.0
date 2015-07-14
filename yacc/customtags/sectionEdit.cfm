<!---    sectionEdit.cfm

AUTHOR				: tpryan
CREATED				: 6/10/2008 7:20:50 AM
DESCRIPTION			: Allows editing control for section
---->

<cfprocessingdirective suppresswhitespace="yes">


<cfajaxproxy cfc="#application.settings.getcfcpath()#.remote.edit" jsclassname="edit" />
	
<cfparam name="attributes.section" type="any" />	

<cfset section = attributes.section />
<cfset author = section.GetupdatedBy() />

<cfsavecontent variable="jstoinject">
	<script type="text/javascript">
		function updatesection(){
			var id = document.getElementById('id').value;
			var path = document.getElementById('path').value;
			var content = ColdFusion.getElementValue('content', 'sectionwindow');
			var editObj = new edit();
			editObj.section(path,id,content);
			
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




<cfwindow  width="730" height="620"  name="sectionwindow" title="Edit Section" closable="false" modal="true" draggable="true" resizable="false" initshow="true">

	<cfform action="" method="get" onsubmit="updatesection();" name="section">
		<cfoutput><p><em>Last updated by: #author.GetDisplayName()# on #DateFormat(section.GetupdatedOn(), 'mmmm d, yyyy')# at #TimeFormat(section.GetupdatedOn())#</em></p></cfoutput>
		<p id="alert"></p>
		<cfinput type="hidden" name="method" value="section" />	
		<cfinput type="hidden" name="path" value="#section.GetPath()#"  id="path" />	
		<cfinput type="hidden" name="id" value="#section.GetID()#"  id="id" />	
		<cftextarea name="content" richtext="TRUE" value="#section.GetContent()#" height="400" width="650" skin="silver" id="content" />
		
		<input type="button" name="update" value="Update" onclick="updatesection();" />
		<input type="button" name="close" value="Close" onclick="closewindow();" />
	</cfform>

</cfwindow>



</cfprocessingdirective>
<!--- In case you call as a tag  --->
<cfexit method="exittag" />