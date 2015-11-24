<cfcomponent output="false" hint="Some Basic Validator tests that everyone needs">

	<!---
		Some Basic Validator tests that everyone needs
		Regex from regexlib.com
	--->
	
	<cffunction name="init" returntype="Any" access="public" output="false">
		<cfreturn this/>
	</cffunction>

	<cffunction name="isEmail" output="false" access="public" returntype="boolean" errorCode="Is not a valid email format">
		<cfargument name="text" required="true" type="string" default=""/>
		<cfreturn ReFindNoCase("^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$",arguments.text)/>
	</cffunction>

	<cffunction name="isSSN" output="false" access="public" returntype="boolean" errorCode="Is not a valid SSN number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches 333-33-3333--->
		<cfreturn ReFindNoCase("^\d{3}-\d{2}-\d{4}$",arguments.text)/>
	</cffunction>

	<cffunction name="isAge" output="false" access="public" returntype="boolean" errorCode="Is not a valid age">
		<cfargument name="text" required="true" type="string" default=""/>
		<cfset var result = false/>
		<cfif arguments.text gte 0 and arguments.text lt 130><cfset result = true/></cfif> <!---The oldest verified person on record was 122, naturally this upper limit could change--->
		<cfreturn result/>
	</cffunction>

	<cffunction name="isIPAddress" output="false" access="public" returntype="boolean" errorCode="Is not a valid IP Address">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches 192.168.1.1--->
		<cfreturn ReFindNoCase("\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b",arguments.text)/>
	</cffunction>

	<cffunction name="isDomainName" output="false" access="public" returntype="boolean" errorCode="Is not a valid Domain Name">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches fusionlink.com | asp.net | army.mil--->
		<cfreturn ReFindNoCase("^[a-zA-Z0-9\-\.]+\.(com|org|net|mil|edu|COM|ORG|NET|MIL|EDU)$",arguments.text)/>
	</cffunction>

	<cffunction name="isCreditCard" output="false" access="public" returntype="boolean" errorCode="Is not a valid Credit Card">
		<cfargument name="text" required="true" type="string" default=""/>
		<cfset var local = StructNew()/>
		<cfset local.result = 0/>
		<!---
		Matches AMEX,VISA,MASTER, Dinnerclub, JCB, enRoute ,Discover cards
		Regex and coding from http://www.regular-expressions.info/creditcard.html and isCreditCard() by Nick de Voil (cflib.org/udf.cfm?id=49
		--->
		
		<cfset local.ccNum = replace(trim(arguments.text)," ","","ALL")/>
		<cfset local.ccNum = replace(local.ccNum,"-","","ALL")/>
	    
	    <cfif isNumeric(local.ccNum)>
	    <cfset local.rv = Reverse(local.ccNum)/>
    	<cfset local.ccln = Len(local.ccNum)/>
	    
	    <cfif local.ccln gte 13>
		<cfscript>
		//mod number check
		local.str = "";
		local.chk = 0;
	    for(local.ii = 1; local.ii lte local.ccln; local.ii = local.ii + 1) {
	        if(local.ii mod 2 eq 0) {
    	        local.str = local.str & Mid(local.rv, local.ii, 1) * 2;
	        } else {
    	        local.str = local.str & Mid(local.rv, local.ii, 1);
        	}
		}
    	local.strln = Len(local.str);
	    for(local.ii = 1; local.ii lte local.strln; local.ii = local.ii + 1) local.chk = local.chk + Mid(local.str, local.ii, 1);
		</cfscript>
	
		<cfif local.chk neq 0 and local.chk mod 10 is 0>
			<!---Visa check--->
			<cfset local.result = ReFindNoCase("^4[0-9]{12}(?:[0-9]{3})?$",local.ccNum)/>
			<!---Mastercard check--->
			<cfif local.result eq false><cfset local.result = ReFindNoCase("^5[1-5][0-9]{14}$",local.ccNum)/></cfif>
			<!---Amex check--->
			<cfif local.result eq false><cfset local.result = ReFindNoCase("^3[47][0-9]{13}$",local.ccNum)/></cfif>
			<!---Diners check--->
			<cfif local.result eq false><cfset local.result = ReFindNoCase("^3(?:0[0-5]|[68][0-9])[0-9]{11}$",local.ccNum)/></cfif>
			<!---Discover check--->
			<cfif local.result eq false><cfset local.result = ReFindNoCase("^6(?:011|5[0-9]{2})[0-9]{12}$",local.ccNum)/></cfif>
			<!---JCB check--->
			<cfif local.result eq false><cfset local.result = ReFindNoCase("^(?:2131|1800|35\d{3})\d{11}$",local.ccNum)/></cfif>
		</cfif>
		</cfif>
		</cfif>
		<cfreturn local.result/>
	</cffunction>

</cfcomponent>