<cfcomponent output="false">
	<!---
	An example of a CFC based validator library
	
	Note the optional "enabled" attribute has turned off the isWDDXCF validator

	CFC based validator can be as complex as you like, it just has to result in a boolean true/false.
		
	Since functions can't name conflict with CF functions we end their names with CF and then do some field name mapping
	--->
	
	<!---Some Mappings - this is optional--->
	<cffunction name="mappings" output="false" access="public" returntype="struct">
		<cfset var mappings = StructNew()/>
		<cfset mappings["JSON"] = "JSONCF"/>
		<cfset mappings["WDDX"] = "WDDXCF"/>
		<cfset mappings["XML"] = "XMLCF"/>
		<cfset mappings["XMLDoc"] = "XMLCF"/>
		<cfset mappings["JSONDoc"] = "JSONCF"/>
		<cfreturn mappings/>
	</cffunction>

	<!---Some error codes - this is optional and is handy for implicit validation--->
	<cffunction name="errorcodes" output="false" access="public" returntype="struct">
		<cfset var errorcodes = StructNew()/>
		<cfset errorcodes["XMLDoc"] = "Is not a known XML format"/>
		<cfset errorcodes["JSONDoc"] = "Is not a known document format"/>
		<cfreturn errorcodes/>
	</cffunction>
	
	<cffunction name="init" returntype="Any" access="public" output="false">
		<cfreturn this/>
	</cffunction>

	<cffunction name="isJSONCF" output="false" access="public" returntype="boolean" errorCode="Is not a JSON string">
		<cfargument name="text" required="true" type="string" default=""/>
		<cfreturn isJSON(arguments.text)/>
	</cffunction>

	<cffunction name="isWDDXCF" output="false" access="public" returntype="boolean" errorCode="Is not a WDDX" enabled="false">
		<cfargument name="text" required="true" type="string" default=""/>
		<cfreturn isWDDX(arguments.text)/>
	</cffunction>

	<cffunction name="isXMLCF" output="false" access="public" returntype="boolean" errorCode="Is not an XML">
		<cfargument name="text" required="true" type="string" default=""/>
		<cfreturn isXML(arguments.text)/>
	</cffunction>

</cfcomponent>