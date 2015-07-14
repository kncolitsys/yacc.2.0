<!---
   Copyright 2007 Dominic Watson

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

   BetterXml for ColdFusion 6.1 and MX7
   Created by Dominic Watson

   For help with this component, go to http://betterxml.riaforge.org/
--->

<cfcomponent displayname="BetterXml Reader component" output="no" hint="Provides generic, easy-to-use methods for reading Xml data using XPath">
<!--- BASE METHODS --->
	
	<cffunction name="Init" returntype="betterXmlReader" hint="Returns an instance of the Xml Reader component. The method allows you to prepopulate the component with xml data by providing the source. This source can be either a url, a local file path or an Xml String">
		<cfargument name="src" type="string" required="false" hint="The Xml source. This can be a url, a local file path or an xml string" />
		
		<cfscript>
			// struct to store 'member' variables (or properties)
			variables.member = StructNew();

			// identifies the type of the Xml source supplied to the object (file, string, url or CFXml)
			member.sourceType = "No Xml Loaded";

			// create xml object
			if( StructKeyExists(arguments,'src') )
				Load(arguments.src);
			else
				member.xmlDoc = XmlNew();
				
			// create XPath helper
			member.xPathHelper = CreateObject("java","org.apache.xpath.XPathAPI");
			member.namespaces = QueryNew('uri,prefix');
			
			return this;
		</cfscript>
			
	</cffunction>
	
	<cffunction name="Load" returntype="boolean" hint="Loads the given Xml source into the object. The source can be a url, a local file path or an xml string">
		<cfargument name="src" type="string" required="true" hint="The Xml source. This can be the name of a url, a local file path or an xml string" />
		
		<cfset arguments.src = Trim(arguments.src)/>
		
		<!--- Attempt to parse the source --->
		<cftry>
			<!--- ColdFusion 7+ can auto parse urls and filepaths for the Xml source --->
			<cfif IsDefined('server.coldfusion.productVersion') AND ListFirst(server.coldfusion.productVersion) GT 6>
				<cfset variables.member.xmlDoc = XmlParse(arguments.src)/>
			
			<!--- coldfusion 6 or below will have see what kind of string it is and act accordingly --->
			<cfelse>
				<!--- file --->
				<cfif FileExists(arguments.src)>
					<cffile action="read" file="#arguments.src#" variable="arguments.src"/>
					<cfset variables.member.xmlDoc = XmlParse(Trim(arguments.src))/>
				
				<!--- url --->
				<cfelseif REFindNoCase("^(((https?:|ftp:|gopher:)\/\/))[-[:alnum:]\?%,\.\/&##!@:=\+~_]+[A-Za-z0-9\/]$", arguments.src)>
					<cfhttp url="#arguments.src#" method="get"/>
					<cfset variables.member.xmlDoc = XmlParse(Trim(cfhttp.FileContent))/>	
				
				<!--- else just try parsing it as an xml string --->
				<cfelse>
					<cfset variables.member.xmlDoc = XmlParse(arguments.src)/>
				</cfif>
			</cfif>
			
			<cfreturn true/>
			
			<cfcatch>
				<cfthrow message="Error loading Xml source. Hint: the source must be an Xml string, URL or file path." detail="#cfcatch.message#<br/><br/>#cfcatch.detail#"  type="BetterXml" errorcode="101"/>
				<cfreturn false/>			
			</cfcatch>
		</cftry>			
	</cffunction>

	<cffunction name="Xml" returntype="string" hint="Returns the xml as a string.">
		<cfreturn ToString(member.xmlDoc)/>
	</cffunction>
	
	<cffunction name="MapNamespace" hint="Maps a namespace to a prefix for use with XPath queries. This is useful when there is more than one default namespace in the xml document">
		<cfargument name="uri" type="string" required="true" hint="The namespace URI">
		<cfargument name="prefix" type="string" required="true" hint="The prefix to map it to">
		
		<cfscript>
			QueryAddRow(member.namespaces);
			QuerySetCell(member.namespaces, 'uri', arguments.uri);
			QuerySetCell(member.namespaces, 'prefix', arguments.prefix);
		</cfscript>
	</cffunction>

<!--- Get Data Methods --->
	<cffunction name="Search" returntype="any" hint="Searches the xml with an XPath expression. Returns the results in an array of either string values or structures depending on the results encountered.">
		<cfargument name="XPath" type="string" required="true" hint="The XPath expression with wich to search the xml"/>
		<cfargument name="childFilter" type="string" required="false" hint="A list of child elements to filter each result by. I.e. Each result will only contain the child elements you specify here."/>

		<cfscript>
			var nodes = XPathResults(arguments.XPath);
			var nNodes = nodes.GetLength();
			var node = "";
			var children = "";
			var aResult = ArrayNew(1);
			var converted = "";
			var i = 0;
			var n = 0;
			var bMixedContent = NodeListNames(nodes).Size() - 1;
			var stTemp = StructNew();
			var aComplexTypes = ListToArray("1,9,11");
			
			// no results, return empty array
			if(not nNodes)
				return aResult;
			
			// loop the node results and append each node to the results array (after converting it)
			for(i=0; i LT nNodes; i=i+1)
			{
				node = nodes.item(javacast('int',i));

				if(StructKeyExists(arguments, 'childFilter'))
					converted = ConvertNode(node, arguments.childFilter);
				else
					converted = ConvertNode(node);
				
				// if mixed content and node is an element, document or doc fragment, create a structure and key for it.
				if( bMixedContent and aComplexTypes.contains(node.GetNodeType()) )
				{
					stTemp.clear();
					stTemp[ node.GetNodeName() ] = converted;
					ArrayAppend(aResult,sttemp);
				}
				// else, if it's not a blank string then add it
				else if(not ( IsSimpleValue(converted) and  not Len(Trim(converted)) ) )
					ArrayAppend(aResult,converted);
			}
			
			return aResult;
		</cfscript>
	</cffunction>
	
	<cffunction name="Count" returntype="numeric" hint="Returns the number of results that match the given XPath expression.">
		<cfargument name="XPath" type="string" required="true" hint="The XPath expression"/>
		
		<cfreturn XPathResults(arguments.XPath).GetLength()/>
	</cffunction>

	<cffunction name="Names" returntype="array" hint="Returns an array of the names of nodes/elements returned in an XPath query">
		<cfargument name="XPath" type="string" required="true" hint="The XPath expression with wich to search the xml"/>		

		<cfreturn NodeListNames(XPathResults(arguments.XPath))/>
	</cffunction>
	
<!--- PRIVATE UTILITY METHODS --->
	<cffunction name="XPathResults" access="private" returntype="any" hint="Returns the nodeList results of an XPath expression.">
		<cfargument name="XPath" type="string" required="true" hint="The XPath expression"/>
		
		<cftry>
			<cfif member.namespaces.recordCount>
				<cfreturn member.xPathHelper.SelectNodeList(member.xmlDoc.GetDocumentElement().GetOwnerDocument(), arguments.XPath, CreateNamespaceNode())/>
			<cfelse>
				<cfreturn member.xPathHelper.SelectNodeList(member.xmlDoc.GetDocumentElement().GetOwnerDocument(), arguments.XPath)/>
			</cfif>
			<cfcatch>
				<cfthrow message="Error searching the Xml document: The XPath expression, #arguments.XPath#, produced an unexpected error." detail="#cfcatch.message#<br/><br/>#cfcatch.detail#"  type="BetterXml" errorcode="102"/>
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="ConvertNode" access="private" returntype="any" hint="Converts a given node to a more Coldfusion friendly format dependent on the type and value(s) of the node.">
		<cfargument name="node" type="any" required="true" hint="The node to convert"/>
		<cfargument name="childFilter" type="string" required="false" hint="If supplied, the node will only be returned with these child elements."/>

		<cfscript>
			var aValue = "";
			var aArr = "";
			var child = "";
			var children = "";
			var converted = "";
			var bFinished = false;
			var sKey = "";
			var i = 0;				
			
			switch(node.GetNodeType())
			{	
				//case 'Attribute': case 'Text': case 'CDATA': case 'Comment': case 'Notation':{						
				case 2: case 3: case 4: case 8: case 12:{
					if(StructKeyExists(arguments, 'childFilter'))
						return "";
					return node.GetNodeValue();
				}
				
				//case 'Processing Instruction':{
				case 7:{
					if(StructKeyExists(arguments, 'childFilter'))
						return "";
					
					aValue = StructNew();
					aValue[node.GetNodeName()] = node.GetNodeValue();
					return aValue;						
				}				
				//case 'Element': case 'Document': case 'Document Fragment':
				case 1: case 9: case 11:
				{	
			
					// no child elements or attributes, just get the element text
					if(not NodeListContainsTypes(node.GetChildNodes(),'1') AND not node.GetAttributes().GetLength())
					{
						if(StructKeyExists(arguments, 'childFilter'))
							return "";
						
						// get text
						child = member.xPathHelper.SelectNodeList(node,'./text()');

						if(not child.GetLength())
							return "";
						else if(child.GetLength() EQ 1)
							return child.item(0).GetNodeValue();
						else
						{
							aValue = StructNew();
							
							aArr = ArrayNew(1);
							for(i=0; i LT child.GetLength(); i=i+1)
								ArrayAppend(aArr, child.item(javacast('int',i)).GetNodeValue());
							
							aValue.xmlText = aArr;
							return aValue;
						}							
					}
					// element contains children / attributes - make a structure of it
					else
					{
						// get structure of the children and attributes
						aValue = StructNew();
						children = node.GetChildNodes();
						
						if(children.GetLength())
						{		
							for(i=0; i LT children.GetLength(); i=i+1)
							{
								child = children.item(javacast('int',i));
								if(StructKeyExists(arguments, 'childFilter') and not ListFind(arguments.childFilter, child.GetNodeName()))
									continue;
								
								// only add child elements and text nodes (that aren't blank)
								if(ListFind("1,3", child.GetNodeType()))
								{
									converted = ConvertNode(child);
									if(not (IsSimpleValue(converted) AND Trim(converted) EQ "") )
									{
										if(child.GetNodeType() EQ 3)
											sKey = "xmlText";
										else
											sKey = child.GetNodeName();										
									
										if(StructKeyExists(aValue, sKey))
										{
											if(not IsArray(aValue[child.GetNodeName()]))
											{
												aArr = ArrayNew(1);
												ArrayAppend(aArr, aValue[sKey]);
												ArrayAppend(aArr, converted);
												aValue[sKey] = aArr;
											}else
												ArrayAppend(aValue[child.GetNodeName()], converted);		
										}
										else
											aValue[sKey] = converted;
									}									
								}
							}
						}
						if(node.HasAttributes())
						{
							children = node.GetAttributes();
							for(i=0; i LT children.GetLength(); i=i+1)
							{
								child = children.item(javacast('int',i));
								if(not StructKeyExists(arguments, 'childFilter') or ListFind(arguments.childFilter, child.GetNodeName()))
								{
									
									if( StructKeyExists(aValue, child.GetNodeName()) )
									{
										if(not IsArray(aValue[child.GetNodeName()]))
										{
											aArr = ArrayNew(1);
											ArrayAppend(aArr, aValue[child.GetNodeName()]);
											ArrayAppend(aArr, child.GetNodeValue());
											aValue[child.GetNodeName()] = aArr;
										}else
											ArrayAppend(aValue[child.GetNodeName()], child.GetNodeValue());
									}
									else
										aValue[child.GetNodeName()] = child.GetNodeValue();
								}
							}
						}
						if(aValue.isEmpty())
							return "";
							
						return aValue;						
					}
						
				}
				
				default: return type;
			}			
		</cfscript>
	</cffunction>
	
	<cffunction name="NodeTypeAsString" access="private" returntype="string" hint="Converts a numerical node type to it's string name.">
		<cfargument name="nodeType" type="numeric" required="true" hint="The numerical node type value."/>
		
		<cfscript>
			switch(arguments.nodeType)
			{
				case 1: return "Element";
				case 2: return "Attribute";
				case 3: return "Text";
				case 4: return "CDATA";
				case 5: return "Entity Reference";
				case 6: return "Entity";
				case 7: return "Processing Instruction";
				case 8: return "Comment";
				case 9: return "Document";
				case 10: return "Document Type";
				case 11: return "Document Fragment";
				case 12: return "Notation";
				default: return "Unknown";
			}
		</cfscript>
	</cffunction>

	<cffunction name="NodeListContainsTypes" access="private" returntype="boolean" hint="Returns whether or not a node list contains one of a given nodetypes">
		<cfargument name="nodelist" type="any" required="true" hint="The nodelist"/>
		<cfargument name="types" type="string" required="true" hint="A list of node types"/>
		
		<cfscript>
			var i=0;
			
			for(i=0; i LT nodeList.GetLength(); i=i+1)
			{
				if(ListFind(arguments.types, nodeList.item(javacast('int',i)).GetNodeType()))
					return true;
			}		
			
			return false;
		</cfscript>
	</cffunction>

	<cffunction name="NodeListNames" access="private" returntype="array" hint="Returns an array containg an element for each unique node name in the node list">
		<cfargument name="nodeList" type="any" required="true" default="The nodelist"/>
		
		<cfscript>
			var i=0;
			var aNames = ArrayNew(1);
			
			for(i=0; i LT arguments.nodeList.GetLength(); i=i+1)
			{
				if(aNames.IndexOf(arguments.nodeList.item(javacast('int',i)).GetNodeName()) EQ -1)
					ArrayAppend(aNames, arguments.nodeList.item(javacast('int',i)).GetNodeName());
			}
			
			return aNames;
		</cfscript>
	</cffunction>

	<cffunction name="CreateNamespaceNode" access="private" hint="Creates a namespace node for use in mapping namespaces to prefixes for XPath searches">
		<cfset var nsXml = "<nsmanager ">
			
		<cfloop query="member.namespaces">
			<cfset nsXml = nsXml & 'xmlns:#prefix#="#uri#" '>
		</cfloop>	
		
		<cfreturn XmlParse(nsXml & "/>").GetDocumentElement().GetOwnerDocument()>		
	</cffunction>

	<cffunction name="Throw" access="private" hint="Throws an error. Used to throw an error from within a cfscript block">
		<cfargument name="message" type="string" required="true"/>
		<cfargument name="detail" type="string" required="true"/>
		<cfargument name="errorCode" type="string" required="true"/>
		<cfargument name="type" type="string" required="no" default="BetterXml"/>
		
		<cfthrow message="#arguments.message#" detail="#arguments.detail#" errorcode="#arguments.errorCode#" type="#arguments.type#"/>
	</cffunction>

	
</cfcomponent>