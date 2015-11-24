<cfcomponent output="false" hint="An example of a CFC based Error code library">

	<cffunction name="errorcodes" output="false" access="public" returntype="struct">
		<cfset var errorcode = StructNew()/>
		<cfset errorcode["Field1"] = "Error Code 1"/>
		<cfset errorcode["Field2"] = "Error Code 2"/>
		<cfset errorcode["Field3"] = "Error Code 3"/>
		<cfreturn errorcode/>
	</cffunction>
	
	<cffunction name="init" returntype="Any" access="public" output="false">
		<cfreturn this/>
	</cffunction>

</cfcomponent>