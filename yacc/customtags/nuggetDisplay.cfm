<!---    nuggetDisplay.cfm

AUTHOR				: tpryan
CREATED				: 6/9/2008 11:03:51 PM
DESCRIPTION			: Displays the content from a nugget.
---->

<cfprocessingdirective suppresswhitespace="yes">

<cfparam name="attributes.nugget" type="any" />

<cfset nugget = attributes.nugget />


<cfoutput>
<div id="#nugget.getID()#">#nugget.getContent()#</div>
</cfoutput>

</cfprocessingdirective>
<!--- In case you call as a tag  --->
<cfexit method="exittag" />