<cfcomponent output="false">

	<cffunction name="mappings" output="false" access="public" returntype="struct">
		<cfset var mappings = StructNew()/>
		<cfset mappings["Field1"] = "String"/>
		<cfset mappings["Field2"] = "String"/>
		<cfset mappings["Field3"] = "String"/>
		<cfreturn mappings/>
	</cffunction>
	
	<cffunction name="init" returntype="Any" access="public" output="false">
		<cfreturn this/>
	</cffunction>

</cfcomponent>