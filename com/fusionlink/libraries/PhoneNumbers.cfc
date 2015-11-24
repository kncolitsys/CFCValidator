<cfcomponent output="false">

	<!---Some Regex from regexlib.com, many others made for this Thor library--->
	<!---Look at notes at the bottom of the CFC--->
	<!---Help on phone number formats -
		http://en.wikipedia.org/wiki/Local_conventions_for_writing_telephone_numbers
		
	--->

	<cffunction name="init" returntype="Any" access="public" output="false">
		<cfreturn this/>
	</cffunction>

<!--- Some common Country Formats--->

	<cffunction name="isPhoneFormat1" output="false" access="public" returntype="boolean" errorCode="Is not a valid Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!--- Matches AAA-BBBB-BBBB or AAA BBBB BBBB --->
		<cfreturn ReFindNoCase("^(([0-9]{3}-[0-9]{4}-[0-9]{4})|([0-9]{3}\s?[0-9]{4}\s?[0-9]{4}))$",arguments.text)/>
	</cffunction>

	<!---Phone Format 2 is the NANP format aka the US phone format--->
	
	<cffunction name="isPhoneFormat3" output="false" access="public" returntype="boolean" errorCode="Is not a valid Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!--- Matches AA AA AA AA or AAA AA AAA --->
		<cfreturn ReFindNoCase("^(([0-9]{2}\s?[0-9]{2}\s?[0-9]{2}\s?[0-9]{2})|([0-9]{3}\s?[0-9]{2}\s?[0-9]{3}))$",arguments.text)/>
	</cffunction>

<!--- Below are Individual Country Formats--->

	<cffunction name="isUSPhone" output="false" access="public" returntype="boolean" errorCode="Is not a valid US Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---For United States, Canada, and other NANP countries--->
		<!---Matches 333-333-3333 or (333) 333-3333--->
		<cfreturn ReFindNoCase("(^[2-9]\d{2}-\d{3}-\d{4}$)|(^\([2-9]\d{2}\) \d{3}-\d{4}$)",arguments.text)/>
	</cffunction>

	<cffunction name="isUKPhone" output="false" access="public" returntype="boolean" errorCode="Is not a valid UK Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches 07222 555555 | (07222) 555555 | +44 7222 555 555 | +44(0)AAAA BBBBBB--->
		<cfreturn ReFindNoCase("^(([0-9]{5}\s?[0-9]{6})|(\([0-9]{5}\)\s?[0-9]{6})|((\+){0,1}[0-9]{2}\s?[0-9]{4}\s?[0-9]{3}\s?[0-9]{3})|((\+){0,1}[0-9]{2}\s?\([0-9]\)\s?[0-9]{4}\s?[0-9]{6}))$",arguments.text)/>
	</cffunction>

	<cffunction name="isFrenchPhone" output="false" access="public" returntype="boolean" errorCode="Is not a valid French Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches 01 46 70 89 12 | 01-46-70-89-12 | 0146708912--->
		<!---<cfreturn ReFindNoCase("^0[1-6]{1}(([0-9]{2}){4})|((\s[0-9]{2}){4})|((-[0-9]{2}){4})$",arguments.text)/>--->
		<cfreturn ReFindNoCase("^(([0-9]{2}\s?[0-9]{2}\s?[0-9]{2}\s?[0-9]{2}\s?[0-9]{2})|([0-9]{2}\-?[0-9]{2}\-?[0-9]{2}\-?[0-9]{2}\-?[0-9]{2}))$",arguments.text)/>
	</cffunction>

	<cffunction name="isIndiaPhone" output="false" access="public" returntype="boolean" errorCode="Is not a valid India Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches +919847444225 | +91-98-44111112 | 98 44111116--->
		<cfreturn ReFindNoCase("^((\+){0,1}91(\s){0,1}(\-){0,1}(\s){0,1}){0,1}98(\s){0,1}(\-){0,1}(\s){0,1}[1-9]{1}[0-9]{7}$",arguments.text)/>
	</cffunction>

	<cffunction name="isBrazilPhone" output="false" access="public" returntype="boolean" errorCode="Is not a valid Brazil Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches 011 5555-1234 | (011) 5555 1234 | (11) 5555.1234 | 1155551234--->
		<cfreturn ReFindNoCase("^((\(0?[1-9][0-9]\))|(0?[1-9][0-9]))[ -.]?([1-9][0-9]{3})[ -.]?([0-9]{4})$",arguments.text)/>
	</cffunction>
	
	<cffunction name="isIsraelPhone" output="false" access="public" returntype="boolean" errorCode="Is not a valid Israel Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches 050-1234567, 0501234567, 501234567 --->
		<cfreturn ReFindNoCase("^0?(5[024])(\-)?\d{7}$",arguments.text)/>
	</cffunction>

	<cffunction name="isSpainPhone" output="false" access="public" returntype="boolean" errorCode="Is not a valid Spanish Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches 333 33 33 33 --->
		<cfreturn ReFindNoCase("^([0-9]{3}\s?[0-9]{2}\s?[0-9]{2}\s?[0-9]{2})$",arguments.text)/>
	</cffunction>

	<cffunction name="isSwitzerlandPhone" output="false" access="public" returntype="boolean" errorCode="Is not a valid Swiss Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches 0AA BBB BB BB --->
		<cfreturn ReFindNoCase("^([0-9]{3}\s?[0-9]{2}\s?[0-9]{2}\s?[0-9]{2})$",arguments.text)/>
	</cffunction>

	<cffunction name="isKoreanPhone" output="false" access="public" returntype="boolean" errorCode="Is not a valid Korean Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches AA-BBB-BB-BBBB --->
		<cfreturn ReFindNoCase("^([0-9]{2}-[0-9]{3}-[0-9]{2}-[0-9]{4})$",arguments.text)/>
	</cffunction>
	
	<cffunction name="isRussianPhone" output="false" access="public" returntype="boolean" errorCode="Is not a valid Russian Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches (AAAA) BB-BB-BB or (AAAAA) BB-BBB --->
		<cfreturn ReFindNoCase("^((\([0-9]{4}\)\s?[0-9]{2}-[0-9]{2}-[0-9]{2})|(\([0-9]{5}\)\s?[0-9]{2}-[0-9]{3}))$",arguments.text)/>
	</cffunction>

	<cffunction name="isDutchPhone" output="false" access="public" returntype="boolean" errorCode="Is not a valid Dutch Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches 0AAA BBBBBB or 06-BBBBBBBB --->
		<cfreturn ReFindNoCase("^(([0-9]{4}\s?[0-9]{6})|([0-9]{2}-[0-9]{8}))$",arguments.text)/>
	</cffunction>

	<cffunction name="isAustraliaPhone" output="false" access="public" returntype="boolean" errorCode="Is not a valid Australian Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!--- Matches (0A) BBBB BBBB or 04MM MBB BBB --->
		<cfreturn ReFindNoCase("^((\([0-9]{2}\)\s?[0-9]{4}\s?[0-9]{4})|([0-9]{4}\s?[0-9]{3}\s?[0-9]{3}))$",arguments.text)/>
	</cffunction>

	<cffunction name="isGermanPhoneFormat1" output="false" access="public" returntype="boolean" errorCode="Is not a valid German Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!--- Matches 
		 	0AAA BBBBBB
			0AAA-BBBBBB
			0AAA BBBBBB-XX
		--->
		<cfreturn ReFindNoCase("^(([0-9]{4}[ -.]?[0-9]{6}\-[0-9]{2})|([0-9]{4}[ -.]?[0-9]{6}))$",arguments.text)/>
	</cffunction>

	<cffunction name="isGermanPhoneFormat2" output="false" access="public" returntype="boolean" errorCode="Is not a valid German Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!--- Matches 
			+49 AAA BBBBBB
			+49 (AAA) BBBBBB
			(0AAA) BBBBBB
			+49 (0AAA) BBBBBB
		--->
		<cfreturn ReFindNoCase("^(((\+){0,1}[0-9]{2}\s?0?[0-9]{3}\s?[0-9]{6})|((\+){0,1}[0-9]{2}\s?\(0?[0-9]{3}\)\s?[0-9]{6}))$",arguments.text)/>
	</cffunction>

	<cffunction name="isGermanPhoneFormat3" output="false" access="public" returntype="boolean" errorCode="Is not a valid German Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!--- Matches 
			+49 (0AAA) / BBBBBBB or +49 (0AAA) BBBBBBB
		--->
		<cfreturn ReFindNoCase("^(((\+){0,1}[0-9]{2}\s?\(0?[0-9]{3}\)\s?[0-9]{7})|((\+){0,1}[0-9]{2}\s?\(0?[0-9]{3}\)\s?\/\s?[0-9]{7}))$",arguments.text)/>
	</cffunction>

	<cffunction name="isGermanPhoneFormat4" output="false" access="public" returntype="boolean" errorCode="Is not a valid German Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!--- Matches 
			0AAA / BBB BBB BB
		--->
		<cfreturn ReFindNoCase("^(0?[0-9]{3}\s?\/\s?[0-9]{3}\s?[0-9]{3}\s?[0-9]{2})$",arguments.text)/>
	</cffunction>

	<cffunction name="isGermanPhoneFormat5" output="false" access="public" returntype="boolean" errorCode="Is not a valid German Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!--- Matches 
			+49 0AAA / BBBB
		--->
		<cfreturn ReFindNoCase("^((\+){0,1}[0-9]{2}\s?[0-9]{4}\s?(\/)\s?[0-9]{5})$",arguments.text)/>
	</cffunction>

	<cffunction name="isGermanPhoneFormat6" output="false" access="public" returntype="boolean" errorCode="Is not a valid German Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!--- Matches 
			+49 (0AAAA) BBBBB
		--->
		<cfreturn ReFindNoCase("^((\+){0,1}[0-9]{2}\s?\(0?[0-9]{4}\)\s?[0-9]{5})$",arguments.text)/>
	</cffunction>

	<cffunction name="isGermanPhoneFormat7" output="false" access="public" returntype="boolean" errorCode="Is not a valid German Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!--- Matches 
			+49 (0AA) BB BB BBB-B
		--->
		<cfreturn ReFindNoCase("^((\+){0,1}[0-9]{2}\s?\(0?[0-9]{2}\)\s?[0-9]{2}\s?[0-9]{2}\s?[0-9]{3}\-?[0-9])$",arguments.text)/>
	</cffunction>


<!--- Notes on the various phone formats

Spain
AAA AA AA AA

Switzerland
0AA BBB BB BB

France 0A AA AA AA AA

Korean
AA-BBB-BB-BBBB

Russia
(AAAA) BB-BB-BB
(AAAAA) BB-BBB

Netherlands
0AAA BBBBBB
06-BBBBBBBB

Australia
(0A) BBBB BBBB
04MM MBB BBB

UK
0AAAA BBBBBB or +44(0)AAAA BBBBBB

Germany - jez guys pick a freaking format :)	- seriously we had to create 7 different phone validators just for germans 
0AAA BBBBBB
0AAA-BBBBBB
0AAA BBBBBB-XX
(0AAA) BBBBBB
+49 AAA BBBBBB
+49 (AAA) BBBBBB
+49 (0AAAA) BBBBB
+49 (0AAA) BBBBBBB
+49 (0AAA) / BBBBBBB
+49 0AAA / BBBB
0AAA / BBB BBB BB
+49 (0AA) BB BB BBB-B
+49 (0AAA) BBBBBB

Format 1 - AAA-BBBB-BBBB or AAA BBBB BBBB
	Hong Kong AAA BBBB BBBB
	China 1AA-BBBB-BBBB	
	Some Latin America BBBB-BBBB
	Some Denmark BBBB BBBB

Format 2 - NANP - AAA-BBB-BBBB (AAA) BBB-BBBB - we just use the isUSPhone() validator for this one
	Some Korea AAA-BBB-BBBB
	Some Russia (AAA) BBB-BBBB
	US and Canada AAA-BBB-BBBB
				(AAA) BBB-BBBB
	Some Latin America 999-9999

Format 3 - 8 numbers
	Norway AA AA AA AA or AAA AA AAA
	Some Denmark AA AA AA AA
	
--->
</cfcomponent>
