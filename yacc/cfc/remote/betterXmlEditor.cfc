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

<cfcomponent displayname="BetterXml Editor" extends="betterXmlReader" hint="Provides generic methods for dealing with a coldfusion xml object or xml file.">
<!--- BASE METHODS --->
	<cffunction name="Init" returntype="betterXmlEditor" hint="Returns an instance of the Xml_editor object. The method allows you to prepopulate the component with xml data by providing the source. This source can be either a url, a local file path or an Xml String">
		<cfargument name="src" type="string" required="false" hint="The Xml source. This can be a url, a local file path or an xml string" />
		
		<cfscript>
			super.init();
			
			if(StructKeyExists(arguments, 'src'))
				Load(arguments.src);
				
			return this;
		</cfscript>
	</cffunction>
	
	<cffunction name="Write" returntype="boolean" hint="Writes the xml to the given file. Returns true on success, false otherwise">
		<cfargument name="file" type="string" required="true" hint="Full path of the target file." />

		<cftry>
			<cffile action="write" output="#Xml()#" file="#arguments.file#" addnewline="false"/>
			<cfreturn true/>
			
			<cfcatch>
				<cfthrow message="Error writing Xml file." detail="#cfcatch.message#<br/><br/>#cfcatch.detail#"  type="BetterXml" errorcode="103"/>
			</cfcatch>
		</cftry>
		
		<cfreturn false/>
	</cffunction>
	
<!--- MANIPULATING Xml --->
	<cffunction name="SetRoot" hint="Sets the root element of the xml">
		<cfargument name="name" type="string" required="true" hint="The name of the root."/>
		
		<cfset	variables.member.xmlDoc.xmlRoot = XmlElemNew(member.xmlDoc, arguments.name)/>
	</cffunction>

	<cffunction name="CreateElement" returntype="numeric" hint="Adds a new element to the xml object..">
		<cfargument name="XPath" type="string" required="true" hint="The XPath of the parent(s) to which to add the element"/>
		<cfargument name="name" type="string" required="true" hint="The name of the xml element to add"/>
		<cfargument name="value" type="any" required="false" default="" hint="The value for the new element. If this is a structure (i.e. a form), subelements will be created using the structure keys. If it is a simple value, the element's xmlText will be set with this value."/>
		
		<cfscript>				
			var pNodes = XPathResults(arguments.XPath);
			var cNodes = CreateNodes(arguments.value);
			var eNode = member.xmlDoc.GetDocumentElement().GetOwnerDocument().CreateElement(arguments.name);
			var i = 0;
			var n = 0;
	
			if(not pNodes.GetLength() or not cNodes.GetLength())
				return 0;

			// add value nodes to the new element node
			// NOTE: Strange behaviour here - The cNodes nodelist loses the node referenced on each AppendChild call
			// so a funky looking loop
			n = cNodes.GetLength();
			for(i=1; i LTE n; i=i+1)
				eNode.AppendChild(cNodes.item(0));
			
			// add new element node to all the parent nodes found in the XPath
			for(i=0; i LT pNodes.GetLength(); i=i+1)
				pNodes.item(javacast('int',i)).AppendChild(eNode.CloneNode(true));
			
			return pNodes.GetLength();	
		</cfscript>
	</cffunction>

	<cffunction name="CreateAttribute" returntype="numeric" hint="Adds a new attribute to xml elements returned by an XPath query">
		<cfargument name="XPath" type="string" required="true" hint="The XPath to the parent element(s)"/>
		<cfargument name="name" type="string" required="true" hint="The name of the attribute to add"/>
		<cfargument name="value" type="string" required="false" default="" hint="The value of the attribute"/>
		
		<cfscript>
			var pNodes = XPathResults(arguments.XPath);
			var i = 0;
			
			if(not pNodes.GetLength())
				return 0;
				
			try{
				for(i=0; i LT pNodes.GetLength(); i=i+1)
					pNodes.item(javacast('int',i)).SetAttribute(arguments.name, arguments.value);			
			}catch(any e){
				return i;
			}
			
			return pNodes.GetLength();
		</cfscript>
	</cffunction>

	<cffunction name="Update" returntype="numeric" hint="Updates the values of the nodes returned by the given XPath query">
		<cfargument name="XPath" type="string" required="true" hint="The XPath to the elements to update"/>
		<cfargument name="value" type="any" required="true" hint="The updated data"/>
		
		<cfscript>
			var pNodes = XPathResults(arguments.XPath); // parent nodes
			var cNodes = CreateNodes(arguments.value); // child nodes
			var i = 0;
			var n = 0;		
			
			// if results contain document, return with error
			if(NodeListContainsTypes(pNodes,9))
				return 0;
					
			// delete any child nodes from the result elements
			Delete('#arguments.XPath#/*|#arguments.XPath#/text()|#arguments.XPath#/comment()|#arguments.XPath#/processing-instruction()');	
			
			// loop through the nodes who's data is to be replaced
			for(i=0; i LT pNodes.GetLength(); i=i+1)
			{
				// do different things dependant on the type of node
				switch(NodeTypeAsString(pNodes.item(javacast('int',i)).GetNodeType()))
				{
					// simple nodes, just set their values
					case 'Attribute': case 'Text': case 'Processing Instruction': case 'comment': case 'CDATA':
					{
						if(IsSimpleValue(arguments.value))
							pNodes.item(javacast('int',i)).SetNodeValue(arguments.value);
						break;
					}
					// elements and docs, append child nodes
					case 'Element':
					{
						for(n=0; n LT cNodes.GetLength(); n=n+1)
							pNodes.item(javacast('int',i)).AppendChild(cNodes.Item(javacast('int',n)).CloneNode(true));	
					}
				}
			}
			
			return pNodes.GetLength();
		</cfscript>
	</cffunction>

	<cffunction name="Delete" returntype="numeric" hint="Deletes the xml nodes returned by the XPath query. Returns the number of nodes deleted.">
		<cfargument name="XPath" type="string" required="false" hint="The XPath that chooses what to delete."/>

		<cfscript>			
			var nodes = XPathResults(arguments.XPath);
			var i = 0;
			
			for(i=0; i LT nodes.GetLength(); i=i+1)
			{
				try{
					switch(NodeTypeAsString(nodes.item(javacast('int',i)).GetNodeType()))
					{
						// attribute
						case 'Attribute':{
							nodes.item(javacast('int',i)).getOwnerElement().RemoveAttribute(nodes.item(javacast('int',i)).GetNodeName());
							break;
						}
						// the document (delete all the xml)
						case 'Document':{
							member.xmlDoc = XmlNew();
							return nodes.GetLength();
							break;
						}						
						// other nodes: use getparent->deletechild
						case 'Element': case 'Text': case 'Comment': case 'Processing Instruction':{
							nodes.item(javacast('int',i)).GetParentNode().RemoveChild(nodes.item(javacast('int',i)));	
							break;
						}
						
						// default: not supported
						default:{
							Throw("Error deleting xml.", "The type of nodes returned by the XPath expression, #arguments.XPath#, are not supported by this method at this time.", 104, "BetterXml");
							return i-1;
						}					
					}					
				}catch(any e){
					return i-1;
				}
			}
			
			return nodes.GetLength();
		</cfscript>		
	</cffunction>	

<!--- PRIVATE UTILITY METHODS --->
	<cffunction name="CreateNodes" access="private" returntype="any" hint="Creates and returns a nodelist from either a string or a struct. The method will only create text or element nodes">
		<cfargument name="value" type="any" required="true" hint="The value to convert">
		
		<cfscript>	
			var aKeys = "";
			var tempNode = member.xmlDoc.GetDocumentElement().GetOwnerDocument().CreateElement("temp");
			var newNode = "";
			var subNodes = "";
			var i = 0;
			var n = 0;
			var x = 0;
			var size = 0;
			
			if(IsSimpleValue(arguments.value))
				tempNode.AppendChild(member.xmlDoc.GetDocumentElement().GetOwnerDocument().CreateTextNode(arguments.value));
			else if(IsStruct(arguments.value))
			{
				keys = StructKeyArray(arguments.value);
				size = ArrayLen(keys);
				for(i=1; i LTE size; i=i+1)
				{
					newNode = tempNode.AppendChild(member.xmlDoc.GetDocumentElement().GetOwnerDocument().CreateElement(LCase(keys[i])));
					
					subNodes = CreateNodes(arguments.value[keys[i]]);
					x = subNodes.GetLength();
					for(n=0; n LT x; n=n+1)
						newNode.AppendChild(subNodes.item(0));
				}
			}
			else
				Throw("Only structures and strings can be used to insert or update elements.", "", 105, "BetterXml");
			
			return tempNode.GetChildNodes();			
		</cfscript>
	</cffunction>
</cfcomponent>