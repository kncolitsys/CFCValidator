<cfcomponent output="false">
	<!---
	List of validators based on internal CF decision functions
	
	Since functions can't name conflict with CF functions we end their names with CF and then do a mapping
	--->
	
	<!---My Mappings--->
	<cffunction name="mappings" output="false" access="public" returntype="struct">
		<cfset var mappings = StructNew()/>
		<cfset mappings["Array"] = "ArrayCF"/>
		<cfset mappings["Binary"] = "BinaryCF"/>
		<cfset mappings["Boolean"] = "BooleanCF"/>
		<cfset mappings["Date"] = "DateCF"/>
		<cfset mappings["DDX"] = "DDXCF"/>
		<cfset mappings["JSON"] = "JSONCF"/>
		<cfset mappings["LeapYear"] = "LeapYearCF"/>
		<cfset mappings["Numeric"] = "NumericCF"/>
		<cfset mappings["NumericDate"] = "NumericDateCF"/>
		<cfset mappings["WDDX"] = "WDDXCF"/>
		<cfset mappings["XML"] = "XMLCF"/>
		<cfset mappings["XMLAttribute"] = "XMLAttributeCF"/>
		<cfset mappings["XMLDoc"] = "XMLDocCF"/>
		<cfset mappings["XMLElem"] = "XMLElemCF"/>
		<cfset mappings["XMLNode"] = "XMLNodeCF"/>
		<cfset mappings["XMLRoot"] = "XMLRootCF"/>
		<cfreturn mappings/>
	</cffunction>
	
	<cffunction name="init" returntype="Any" access="public" output="false">
		<cfreturn this/>
	</cffunction>

	<cffunction name="isArrayCF" output="false" access="public" returntype="boolean" errorCode="Is not an Array" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<cfreturn isArray(arguments.text)/>
	</cffunction>

	<cffunction name="isBinaryCF" output="false" access="public" returntype="boolean" errorCode="Is not a Binary" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<cfreturn isBinary(arguments.text)/>
	</cffunction>

	<cffunction name="isBooleanCF" output="false" access="public" returntype="boolean" errorCode="Is not a Boolean" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<cfreturn isBoolean(arguments.text)/>
	</cffunction>

	<cffunction name="isDateCF" output="false" access="public" returntype="boolean" errorCode="Is not a Date" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<cfreturn isDate(arguments.text)/>
	</cffunction>

	<cffunction name="isDDXCF" output="false" access="public" returntype="boolean" errorCode="Is not a DDX" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<cfreturn isDDX(arguments.text)/>
	</cffunction>

	<cffunction name="isJSONCF" output="false" access="public" returntype="boolean" errorCode="Is not a JSON string" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<cfreturn isJSON(arguments.text)/>
	</cffunction>

	<cffunction name="isLeapYearCF" output="false" access="public" returntype="boolean" errorCode="Is not a Leap Year" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<cfreturn isLeapYear(arguments.text)/>
	</cffunction>

	<cffunction name="isNumericCF" output="false" access="public" returntype="boolean" errorCode="Is not a Numeric" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<cfreturn isNumeric(arguments.text)/>
	</cffunction>

	<cffunction name="isNumericDateCF" output="false" access="public" returntype="boolean" errorCode="Is not a Numeric Date" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<cfreturn isNumericDate(arguments.text)/>
	</cffunction>

	<cffunction name="isWDDXCF" output="false" access="public" returntype="boolean" errorCode="Is not a WDDX" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<cfreturn isWDDX(arguments.text)/>
	</cffunction>

	<cffunction name="isXMLCF" output="false" access="public" returntype="boolean" errorCode="Is not an XML" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<cfreturn isXML(arguments.text)/>
	</cffunction>

	<cffunction name="isXMLAttributeCF" output="false" access="public" returntype="boolean" errorCode="Is not a XML Attribute" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<cfreturn isXMLAttribute(arguments.text)/>
	</cffunction>

	<cffunction name="isXMLDocCF" output="false" access="public" returntype="boolean" errorCode="Is not a XML Document" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<cfreturn isXMLDoc(arguments.text)/>
	</cffunction>

	<cffunction name="isXMLElemCF" output="false" access="public" returntype="boolean" errorCode="Is not a XML Element" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<cfreturn isXMLElem(arguments.text)/>
	</cffunction>

	<cffunction name="isXMLNodeCF" output="false" access="public" returntype="boolean" errorCode="Is not a XML Node" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<cfreturn isXMLNode(arguments.text)/>
	</cffunction>

	<cffunction name="isXMLRootCF" output="false" access="public" returntype="boolean" errorCode="Is not a XML root" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<cfreturn isXMLRoot(arguments.text)/>
	</cffunction>

</cfcomponent>