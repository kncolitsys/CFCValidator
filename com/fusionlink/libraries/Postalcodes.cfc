<cfcomponent output="false">

	<!---Some Regex from regexlib.com, many others made for this Thor library--->
	<!---Help on postal code formats - 
			http://www.upu.int/post_code/en/postal_addressing_systems_member_countries.shtml
			http://en.wikipedia.org/wiki/Postal_code
			http://en.wikipedia.org/wiki/List_of_postal_codes
			
			This library pretty much covers any known postalcode format.
			
	--->
	
	<cffunction name="init" returntype="Any" access="public" output="false">
		<cfreturn this/>
	</cffunction>

	<!---We have 7 common formats that most countries follow, below that we have the outliners--->
	
	<cffunction name="isPostalcodeFormat1" output="false" access="public" returntype="boolean" errorCode="Is not a valid Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Several country codes have two letters followed by 3 numbers like AD100 or AD-700 format --->
		<cfreturn ReFindNoCase("^(([a-zA-Z]{2}[0-9]{3})|([a-zA-Z]{2}-[0-9]{3}))$",arguments.text)/>
	</cffunction>

	<cffunction name="isPostalcodeFormat2" output="false" access="public" returntype="boolean" errorCode="Is not a valid Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Several country codes are based on the old Soviet system; 999999 or AA999999 or AA-999999 --->
		<cfreturn ReFindNoCase("^(([0-9]{6})|([a-zA-Z]{2}-[0-9]{6})|([a-zA-Z]{2}[0-9]{6}))$",arguments.text)/>
	</cffunction>

	<cffunction name="isPostalcodeFormat3" output="false" access="public" returntype="boolean" errorCode="Is not a valid Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Several country codes are like so; AA9999 or AA-9999 or A-9999 --->
		<cfreturn ReFindNoCase("^(([a-zA-Z]-[0-9]{4})|([a-zA-Z]{2}-[0-9]{4})|([a-zA-Z]{2}[0-9]{4}))$",arguments.text)/>
	</cffunction>

	<!---Look at the notes below in regards to the Format4 postalcodes--->
	
	<cffunction name="isPostalcodeFormat5" output="false" access="public" returntype="boolean" errorCode="Is not a valid Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Several country codes are like so; AA-99999 or A-99999 --->
		<cfreturn ReFindNoCase("^(([a-zA-Z]-[0-9]{5})|([a-zA-Z]{2}-[0-9]{5}))$",arguments.text)/>
	</cffunction>

	<cffunction name="isPostalcodeFormat6" output="false" access="public" returntype="boolean" errorCode="Is not a valid Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Several country codes are small two character formats like so; 99 or AA 99 or AA AA or 99-99 --->
		<cfreturn ReFindNoCase("^(([0-9]{2})|([a-zA-Z]{2}\s?[0-9]{2})|([a-zA-Z]{2}\s?[a-zA-Z]{2})|([0-9]{2}-[0-9]{2}))$",arguments.text)/>
	</cffunction>

	<cffunction name="isPostalcodeFormat7" output="false" access="public" returntype="boolean" errorCode="Is not a valid Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Sweden, Czech and Slovakia do the following. (AA-)999 99 --->
		<cfreturn ReFindNoCase("^(([a-zA-Z]{2}-[0-9]{3}\s?[0-9]{2})|([0-9]{3}\s?[0-9]{2}))$",arguments.text)/>
	</cffunction>

	<!---Individual Country validators below--->

	<cffunction name="isUSPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid US Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<cfreturn ReFindNoCase("(^\d{5}$)|(^\d{5}-\d{4}$)",arguments.text)/>
	</cffunction>

	<cffunction name="isCanadianPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Canadian Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches T2p 3c7 | T3P3c7 | T2P 3C7--->
		<cfreturn ReFindNoCase("^([a-zA-Z][0-9][a-zA-Z]\s?[0-9][a-zA-Z][0-9])$",arguments.text)/>
	</cffunction>

	<cffunction name="isDutchPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Dutch Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches 1234AB | 1234 AB | 1001 AB | NL-1234 AB--->
		<cfreturn ReFindNoCase("^([N][L]-[1-9][0-9]{3}\s?[a-zA-Z]{2})|([1-9][0-9]{3}\s?[a-zA-Z]{2})$",arguments.text)/>
	</cffunction>

	<cffunction name="isBrazilPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Brazilian Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches 70235 | 70235-120 | 70235125--->
		<cfreturn ReFindNoCase("((^\d{5}$)|(^\d{8}$))|(^\d{5}-\d{3}$)",arguments.text)/>
	</cffunction>

	<cffunction name="isGermanPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid German Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches 03242 | 36260 | 12394--->
		<cfreturn ReFindNoCase("^([0-9]{5})$",arguments.text)/>
	</cffunction>

	<cffunction name="isDanishPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Danish Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches 03242 | 36260 | 12394--->
		<cfreturn ReFindNoCase("^([D-d][K-k]-[1-9]{1}[0-9]{3})$",arguments.text)/>
	</cffunction>

	<cffunction name="isUKPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid UK Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches GIR 0AA | SW1Y 1AA | AB1 4BL--->
		<cfreturn ReFindNoCase("^((([A-PR-UWYZ])([0-9][0-9A-HJKS-UW]?))|(([A-PR-UWYZ][A-HK-Y])([0-9][0-9ABEHMNPRV-Y]?))\s{0,2}(([0-9])([ABD-HJLNP-UW-Z])([ABD-HJLNP-UW-Z])))|(((GI)(R))\s{0,2}((0)(A)(A)))$",arguments.text)/>
	</cffunction>

	<cffunction name="isSwedishPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Swedish Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches S-123 45 | s 123 45 | S123-45--->
		<cfreturn ReFindNoCase("^([S-s]( |-)?[1-9]{1}[0-9]{2}( |-)?[0-9]{2})$",arguments.text)/>
	</cffunction>

	<cffunction name="isEasternEuropeanPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Eastern European Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Most Eastern European codes have 4 digits - Matches 1000 | 1700 --->
		<cfreturn ReFindNoCase("^([0-9]{4})$",arguments.text)/>
	</cffunction>

	<cffunction name="isJapanPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Japanese Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Japan's format is 999-9999' --->
		<cfreturn ReFindNoCase("^([0-9]{3}-[0-9]{4})$",arguments.text)/>
	</cffunction>

	<cffunction name="isKoreanPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Korean Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---South Korea's format is 999-999' --->
		<cfreturn ReFindNoCase("^([0-9]{3}-[0-9]{3})$",arguments.text)/>
	</cffunction>

	<cffunction name="isIranPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Iranian Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Iran's format is 99999 99999' --->
		<cfreturn ReFindNoCase("^([0-9]{5}\s?[0-9]{5})$",arguments.text)/>
	</cffunction>

	<cffunction name="isChilePostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Chilean Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Chile's format is 9999999 --->
		<cfreturn ReFindNoCase("^([0-9]{7})$",arguments.text)/>
	</cffunction>

	<cffunction name="isArgentinaPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Argentina Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Argentina's format is A9999AAA --->
		<cfreturn ReFindNoCase("^([A-a][0-9]{3}[a-zA-Z]{3})$",arguments.text)/>
	</cffunction>

	<cffunction name="isBarbadosPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Barbados Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Barbados's format is BB99999 --->
		<cfreturn ReFindNoCase("^([B-b]{2}[0-9]{5})$",arguments.text)/>
	</cffunction>

	<cffunction name="isCaymanPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Cayman Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Cayman's format is KY9-9999 --->
		<cfreturn ReFindNoCase("^([K-k][Y-y][0-9]-[0-9]{4})$",arguments.text)/>
	</cffunction>

	<cffunction name="isMaltaPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Malta Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Malta's format is AAA 9999 --->
		<cfreturn ReFindNoCase("^([a-zA-Z]{3}\s?[0-9]{4})$",arguments.text)/>
	</cffunction>

	<cffunction name="isNicaraguaPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Nicaragua Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Nicaragua's format is 999-9999-9 --->
		<cfreturn ReFindNoCase("^([0-9]{3}-[0-9]{4}-[0-9])$",arguments.text)/>
	</cffunction>

	<cffunction name="isPolandPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Polish Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Poland's format is (PL-)99-999 --->
		<cfreturn ReFindNoCase("^(([P][L]-[0-9]{2}-[0-9]{3})|([0-9]{2}-[0-9]{3}))$",arguments.text)/>
	</cffunction>


<!--- Notes on the format types
Key

    * A: Letters.
    * 9: Digits.
    * *: Postal code placed to the right of the region, city, suburb or town.

No postal code
    * Afghanistan : No postal code used.
    * Angola: No postal code used.
    * Antigua and Barbuda: No postal code used.
    * Aruba: No postal codes used.
    * Bahamas: No postal code used.
    * Belize: No postal code used.
    * Benin: No postal code used.
    * Bhutan: No postal code used.
    * Botswana: not used
    * Burkina Faso: No postal code used.
    * Burundi: No postal code used.
    * Cameroon: No postal code used.
    * Central African Republic: No postal code used.
    * Colombia: No postal code used.
    * Comoros: No postal code used.
    * Congo (Brazzaville): No postal code used.
    * Congo, Democratic Republic: No postal code used.
    * Cook Islands: No postal code used.
    * Côte d'Ivoire: No postal code used.
    * Djibouti: No postal code used.
    * Dominica: No postal code used.
    * East Timor: No postal code system in use.
    * Equatorial Guinea: No postal code used.
    * Eritrea: No postal code used.
    * Fiji: No postal code used.
    * Gambia: No postal code used.
    * Gibraltar: No postal code system
    * Grenada: No postal code used.
    * Guinea: No postal code used.
    * Guyana: No postal code used.
    * Hong Kong: No postal code system
    * Ireland: No postal codes; however, Dublin is divided into postal districts on syntax Dublin 9.
    * Kiribati: No postal code used.
    * Korea, North: No postal code used.
    * Macau: No postal code system
    * Malawi: No postal code used.
    * Mali: No postal code used.
    * Mauritania: No postal code used.
    * Mauritius: No postal code used.
    * Montserrat: No postal code used.
    * Namibia: None - South African post codes discontinued in 1992.
    * Nauru: No postal code used.
    * Netherlands Antilles: No postal code used.
    * Niue: No postal code used.
    * Panama: No use of postal codes. Deliveries to PO Boxes only
    * Qatar: No postal code used. PO box delivery only.
    * Rwanda: No postal code used.
    * Saint Kitts and Nevis: No postal code used.
    * Saint Lucia: No postal code used.
    * Saint Vincent and the Grenadines: No postal code used.
    * Sao Tome and Principe: No postal code used.
    * Seychelles: No postal code used.
    * Sierra Leone: No postal code used.
    * Solomon Islands: No postal code used.
    * Somalia: No postal code used. A 5 digit code has been publicized, but never taken into use.
    * Suriname: No postal code used.
    * Syria: No postal code used. A 4-digit system has been announced. Status unknown.
    * Tanzania: No postal code used.
    * Tokelau: No postal code used.
    * Tonga: No postal code used.
    * Trinidad and Tobago: No postal code used.
    * Tuvalu: No postal code used.
    * Uganda: No postal code used.
    * United Arab Emirates: No postal code used.
    * Vanuatu: No postal code used.
    * Yemen: No postal code used.
    * Zimbabwe: No postal code used.

    UK Commonwealth Countries that follow the UK code
    * Ascension Island: ASCN 1ZZ. Single code used for all addresses.
    * Falkland Islands: FIQQ 1ZZ Single code used for all addresses.
    * Pitcairn Islands: PCRN 1ZZ Single code used for all addresses.
    * Saint Helena: STHL 1ZZ Single code used for all addresses.
    * Tristan da Cunha: TDCU 1ZZ Single code used for all addresses.
    * South Georgia and the South Sandwich Islands: SIQQ 1ZZ Single code used for all addresses.
    * Turks and Caicos Islands: TKCA 1ZZ Single code used for all addresses.

    French Overseas Department - they use the Frnch pattern
    * French Guiana: Overseas Department of France. French codes used.
    * French Polynesia: Overseas Territory of France. French codes used.
    * French Southern and Antarctic Territories No postal code used.
    * Martinique: Overseas Department of France. French codes used.
    * Mayotte: Overseas Territory of France. French codes used.
    * New Caledonia: Overseas Territory of France. French codes used.
    * Reunion: Overseas Department of France. French codes used.
    * Saint Barthélemy: Overseas Territory of France. French codes used.
    * Saint Martin: Overseas Territory of France. French codes used.
    * Saint Pierre and Miquelon: Overseas Territory of France. French codes used.
    * Wallis and Futuna: Overseas Territory of France. French codes used.
    * Guadeloupe: Overseas Department of France. French codes used.


Format 1 - AA999 or AA-999

    * Andorra: AD999 each parish now has its own post code. See Postal services in Andorra.
    * Faroe Islands: (FO-)999
    * Iceland: (IS-)999
    * Lesotho: 999
    * Madagascar: 999
    * Oman: 999
    * Papua New Guinea: 999
    * Swaziland: A999* Letter identifies one of the country's four districts.

Format 2 - 999999 or AA999999 or AA-999999 - based old soviet system

    * Belarus: (BY-)999999 Retained system inherited from former Soviet Union.
    * China, People's Republic of (Mainland): 999999. 
    * Ecuador: EC999999 Introduced in December 2007. For Guayaquil is EC090150.
    * Kazakhstan: 999999 Retained system inherited from former Soviet Union.
    * Kyrgyzstan: 999999 Retained system inherited from former Soviet Union.
    * Nigeria: 999999
    * Mongolia: 999999
    * Romania: (RO-)999999 since 2003. Previously 99999 in Bucharest and 9999 in rest of country.
    * Russia: 999999 Placed on a line of its own.
    * Singapore: 999999 Each building has its own unique postcode.
    * Tajikistan: (TJ-)999999 Retained system from former Soviet Union.
    * Turkmenistan: 999999 Retained system from former Soviet Union.
    * Uzbekistan: 999999 Retained system inherited from former Soviet Union.
    * Vietnam: 999999

Format 3 - AA9999 or 9999 or AA-9999 or A-9999
    * Armenia: 9999
    * Azerbaijan: AZ9999 
    * Albania: (AL-)9999. Introduced in 2006, gradually implemented throughout 2007.
    * Anguilla: AI-2640. Single code used for all addresses.
    * Austria: (A- or AT-)9999 (the first digit denotes one of the nine provinces -- called Bundesländer 
    * Belgium: (B- or BE-)9999 (in general, the first digit gives the province) List of postal codes in 
    * Cape Verde: 9999 - the first digit indicates which island.
    * Costa Rica: 99999 Was 9999 until 2007. Each postal code represents a district. Not heavily used as 
    * El Salvador: 9999 The letters CP are frequently used before the postal code. This is not a country 
    * Ethiopia: 9999 The code is only used on a trial basis for Addis Abeba addresses.
    * Georgia: (GE-)9999
    * Lebanon: 9999* in rural areas, 9999 9999 in urban areas.
    * Liberia: 9999 Two digit postal zone after city name.
    * Latvia: (LV-)9999*
    * Liechtenstein: (FL- or LI-)9999. Part of the Swiss postal code system.
    * Luxembourg: (L- or LU-)9999
    * Macedonia: (MK-)9999
    * Moldova: (MD-)9999
    * New Zealand: 9999
    * Niger: 9999
    * Norway: (NO-)9999. See also List of postal codes in Norway
    * Norfolk Island: 9999
    * Paraguay: 9999
    * Philippines: 9999
    * Portugal: (PT-)9999-999 (previously 9999)
    * Slovenia: (SI-)9999
    * South Africa: 9999* Included Namibia (ranges 9000-9299) until 1992, no longer used. See List of 
    * Sudan: 9999
    * Switzerland: (CH-)9999 (also used by Liechtenstein). In Geneva, there may be a digit after the 
    * Tunisia: 9999
    * Venezuela: 9999*. 9999 A may also be used.
    * Australia: known as the "postcode": 9999
    * Australian Antarctic Territory: 9999
    * Bahrain: 999 or 9999
    * Bangladesh: 9999
    * Bolivia: 9999
    * British Virgin Islands: VG9999
    * Bulgaria: (BG-)9999
    * Brunei: AA9999
    * Christmas Island: 9999* Part of the Australian postal code system
    * Cocos (Keeling) Island: 9999* Part of the Australian postal code system
    * Cyprus: (CY-)9999 Post code system covers whole island, but not used in Northern Cyprus where 
    * Denmark: (DK-)9999 also used by Greenland, eg: DK-3900 Nuuk
    * Greenland: (DK-)9999 Part of the Danish postal code system.
    * Guinea Bissau: 9999
    * Haiti: (HT-)9999
    * Heard and McDonald Islands: 9999*. Part of the Australian postcode system.
    * Hungary: (H- or HU-)9999 Introduced in 1973. In all except the six largest towns, there is only 


Format 4 - 99999 or 99999-9999 aka the US format - so we have a isUSPostalCode validator that covers this
    * Algeria: 99999
    * American Samoa: 99999* or 99999-9999*. US territory - part of the US zip-code system.
    * Cambodia: 99999
    * Chad: 99999
    * Cuba: 99999 - may only be required for bulk mail. The letters CP are frequently used before the 
    * Dominican Republic: 99999Postal Code Web Site
    * Egypt 99999
    * Honduras: 99999
    * Guatemala: 99999. 
    * Guam: 99999 or 99999-9999. US territory - part of the US zip-code system.
    * Federated States of Micronesia: 99999 or 99999-9999. Former US territory - part of the US zip-
    * Indonesia: 99999
    * Iraq: 99999 Work started on system post 2003. See List of postal codes in Iraq
    * Israel: 99999 (Postcode is always written BEFORE the city/place name, i.e. to the Right in Hebrew 
    * Italy: 99999 (also used by San Marino and Vatican City) First two digits identify province with 
    * Jordan: 99999. Deliveries to PO Boxes only
    * Kenya: 99999. Deliveries to PO Boxes only
    * Kosovo: 99999 A separate postal code for Kosovo was introduced by the UNMIK postal administration 
    * Kuwait: 99999
    * Laos: 99999
    * Libya: 99999
    * Malaysia: 99999 See also List of postal codes in Malaysia
    * Marshall Islands: 99999* or 99999-9999*. Former US territory - part of the US zip-code system.
    * Mexico: 99999. The first two digits identify the state (or a part thereof), except for Nos. 00 to 
    * Morocco: 99999
    * Mozambique: 99999
    * Myanmar: 99999
    * Nepal: 99999
    * Northern Mariana Islands: 99999 or 99999-9999. US territory - part of the US zip-code system.
    * Palau: 99999 or 99999-9999. Former US territory - part of the US zip-code system.
    * Pakistan: 99999
    * Saudi Arabia: 99999 Deliveries to PO Boxes only
    * Senegal: 99999. The letters CP or C.P. are often written in front of the postcode. This is not a 
    * Serbia: (RS-)99999
    * Sri Lanka: 99999
    * Taiwan: 99999 
    * Thailand: 99999
    * Ukraine: 99999
    * Uruguay: 99999
    * Zambia: 99999. The code is not widely publicized, and thus hardly used.

Format 5 - Like the US Format except with a one or two letter prefix AA-99999 or A-99999, common on Europe
    * Åland: (AX-)99999 Note: Country code: AX even though part of the Finnish postal code system.
    * Bosnia and Herzegovina: (BA-)99999
    * Croatia: (HR-)99999
    * Estonia: (EE-)99999
    * Finland: (FI-)99999. A lower first digit indicates a place in south (for example 00100 Helsinki, a 
    * France: (F- or FR-)99999, the first two digits give the département number, while in Paris, Lyon 
    * Germany: (D- or DE-)99999 since 1993 (previously separate 9999 systems in both East and West     
    * Greece: (GR-)99999 See also List of postal codes in Greece
    * Lithuania: (LT-)99999 since 2004. Previously 9999 which was actually the old Soviet 999999 format 
    * Monaco: (MC-)99999 Uses the French Postal System, but with an "MC" Prefix for Monaco.
    * Montenegro: (ME-)99999
    * San Marino: (SM-)99999. Part of the Italian postal code system.
    * Spain: (E- or ES-)99999 See List of postal codes in Spain
    * Turkey: (TR-)99999 First two digits are the city numbers.
    * Vatican City: (VA-)00120. Single code used for all addresses. Part of the Italian postal code 

Format 6 - Like the US Format except with a one or two letter prefix AA-99999 or A-99999, common on    
    * Bermuda: AA 99* for street addresses, AA AA* for PO Box addresses. The second half of the postcode 
    * Gabon: 99 [city name] 99 Two digit postal zone goes after city name.
    * Maldives: 99-99
    * Peru: 99* in Lima and Callao only, see also List of postal codes in Peru

Format 7 - Sweden, Czech and Slovakia
    * Czech Republic: (CZ-)999 99 Retained system from former Czechoslovakia.
    * Slovakia: (SK-)999 99
    * Sweden: (SE-)999 99


Individual formats - some countries just have to be completely different from everyone else :)
					we made individual validators for each one of these

    * Chile: 9999999 May only be required for bulk mail.

    * India: 999 999 Known as a "PIN" (Postal Index Number)

    * Iran: 99999 99999

    * Korea, South: 999-999

    * Argentina: A9999AAA

    * Barbados: BB99999 

    * Japan: 999-9999

    * Cayman Islands: KY9-9999

    * Malta: AAA 9999

    * Netherlands: (NL-)9999 AA. See also List of postal codes in the Netherlands

    * Nicaragua: 999-999-9

    * Poland: (PL-)99-999 See also List of postal codes in Poland

--->

</cfcomponent>