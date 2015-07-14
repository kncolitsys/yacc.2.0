<!---    nuggetEdit.cfm

AUTHOR				: tpryan
CREATED				: 6/10/2008 7:20:50 AM
DESCRIPTION			: Allows editing control for nugget
---->

<cfprocessingdirective suppresswhitespace="yes">



<cfajaxproxy cfc="#application.settings.getcfcpath()#.remote.edit" jsclassname="edit" />
	
<cfparam name="attributes.nugget" type="any" />	

<cfset nugget = attributes.nugget />
<cfset author = nugget.GetupdatedBy() />

<cfsavecontent variable="jstoinject">
	<script type="text/javascript">
		function updatenugget(){
			var id = document.getElementById('id').value;
			var content = ColdFusion.getElementValue('content', 'nuggetwindow');
			var editObj = new edit();
			editObj.nugget(id,content);
			
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
		


<cfwindow  width="730" height="620"  name="nuggetwindow" title="Edit Nugget" closable="false" modal="true" draggable="true" resizable="false" initshow="true">
	<cfform action="" method="get" onsubmit="updatenugget();" name="nugget">
		<cfoutput><p><em>Last updated by: #author.GetDisplayName()# on #DateFormat(nugget.GetupdatedOn(), 'mmmm d, yyyy')# at #TimeFormat(nugget.GetupdatedOn())#</em></p></cfoutput>
		<p id="alert"></p>
		<cfinput type="hidden" name="method" value="nugget" />	
		
		<cfinput type="hidden" name="id" value="#nugget.GetID()#" id="id" />	
		<cftextarea name="content" richtext="TRUE" value="#nugget.GetContent()#" height="400" width="650" skin="silver" id="content" />
		
		<input type="button" name="update" value="Update" onclick="updatenugget();" />
		<input type="button" name="close" value="Close" onclick="closewindow();" />
	</cfform>

</cfwindow>



</cfprocessingdirective>
<!--- In case you call as a tag  --->
<cfexit method="exittag" />