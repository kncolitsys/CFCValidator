<cfcomponent output="false">

	<!---
		Thor is a CFC based validator. For instructions on how to use Thor, go to codfusion.com. This validator has 
		several unique features which you will not find in other CFC validators. These features include:
		
			- explicit / implicit validation
			- global validation 
			- handle Server and client side validation with one set of validator libraries
			- specific and general error text
			- field name mapping (translation)
			- validator/mapping importing by either CFC or XML
			- validator list reporting
			- fields not required option
			- on-the-fly validator injection 
			- logging 
		
		WARNING: The Thor validator was not specifically designed to prevent URL, SQL Injection and XSS attacks even 
		though it naturally could block some by the process of validation. I have another project that is by designed can 
		help block many of those attack	vectors called Portcullis - http://portcullis.riaforge.org. If you do use 
		Portcullis with Thor, in your coding call Portcullis first and then make the call to Thor. No reason to validate 
		bogus information.

		History:
		1.0.1 (3/3/09)  - First initial public release
		1.0.2 (3/10/09) - Expand import features,specific validator/library enabling,fields not require option on validate(),on-the-fly validator injection
		1.0.3 (3/25/09) - Added some functionality to make it easier to use Thor with Coldspring, added Coldspring information to the documentation
		1.0.4 (4/8/09)  - Added client-side validation example with jQuery. Fixed a bug with logging and one with the error coding which does affect the name of the error struct that Thor returns back.
		1.0.5 (6/10/09)	- Bug fix where getMetaData().fullname didn't work in CF 7, changed to use just the name property

		Most of the regex validation strings came from regexlib.com or are ones I have had for several years.
		If you run across some better regex validators, feel free to pass to along, and I'll 
		incorporate them on the future updates for this project.
	--->

	<cfset variables.instance = StructNew()/>

	<cfset variables.instance.excludelist = "submit,fieldnames"/> 		<!--- Fieldnames that Thor should always ignore--->
	<cfset variables.instance.useGlobal = true/>						<!--- Use the global validator--->
	<cfset variables.instance.implicitValidation = true/>				<!--- If a specific validator isn't found, should Thor look for and test against related ones--->
	<cfset variables.instance.logging = true/>							<!--- Turn logging on or off--->
	<cfset variables.instance.maxLogTime = 86400/> 						<!--- In seconds, how long do you want to keep a record in the log. 86400 seconds equals 1 day--->
	<cfset variables.instance.itemValuesNotToLog = "CreditCard,SSN"/>	<!--- Item values submitted that you don't want logged for security reasons such as PCI,etc--->

	<!---Customized Error Codes, which is really comes into use with implicit validation--->
	<cfset variables.instance.defaultErrorCode = StructNew()/>
	<cfset variables.instance.defaultErrorCode["Default"] = "Is not a valid entry"/>
	<cfset variables.instance.defaultErrorCode["Global"] = "Is not a valid entry - field value is too long"/>

	<!---Fieldname translations--->
	<cfset variables.instance.mappings = StructNew()/>

	<!---Global Validator--->
	<cffunction name="globalValidator" output="false" access="private" returntype="boolean" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<cfset var local = StructNew()/>
		<cfset local.result = true/>
		<cfif variables.instance.useGlobal eq true>
			<!---If any field value is over 5120 characters in length, reject it--->
			<cfif len(arguments.text) gt 5120>
				<cfset local.result = false/>
			</cfif>
		</cfif>
		<cfreturn local.result/>		
	</cffunction>



	<!---The rest is internal to Thor, don't modify unless you need to--->
	<cfset variables.instance.importedCFCValidators = StructNew()/>
	
	<cfif structkeyexists(variables.instance,"validators") eq false>
			<cfset variables.instance.validators = QueryNew("Name, Type, CFCName, Regex, ErrorCode", "VarChar, VarChar, VarChar, VarChar, VarChar")/>
	</cfif>
	<cfif structkeyexists(variables.instance,"log") eq false>
			<cfset variables.instance.log = QueryNew("FieldName, MappedName, ValueSubmitted, Validator, Result, DateRecorded", "VarChar, VarChar, VarChar, VarChar, VarChar, Date")/>
	</cfif>
	
	<cffunction name="init" output="false" access="public" returntype="Thor">
		<cfreturn this/>
	</cffunction>

	<cffunction name="getValidators" output="false" access="public" returntype="query">
		<cfreturn variables.instance.validators/>
	</cffunction>

	<cffunction name="setImport" output="false" access="public" returntype="any">
		<cfargument name="obj" required="true" type="any"/>
		<!---For Coldspringers--->
		<cfreturn import(arguments.obj)/>
	</cffunction>

	<cffunction name="import" output="false" access="public" returntype="any">
		<cfargument name="obj" required="true" type="any"/>
		<cfset var local = StructNew()/>
		<cfset local.result = true/>

		<cftry>
			<cfif isSimpleValue(arguments.obj) and isXML(arguments.obj) eq false and fileexists(arguments.obj)>
				<!---Appears to be a file path to an xml doc, let's read it in--->
				<cffile action="read" variable="arguments.obj" file="#arguments.obj#"/>
			</cfif>
			<cfcatch><cfset local.result = false/></cfcatch>
		</cftry>
		<cftry>
			<cfif local.result eq true>
			<cfif isObject(arguments.obj)>
				<cfset importCFCValidators(arguments.obj)>
			<cfelseif isXML(arguments.obj)>
				<cfset local.obj = xmlparse(arguments.obj)/>
		
				<cfif arraylen(xmlsearch(local.obj,"validators")) gt 0>
					<cfset importXMLValidators(local.obj)>
				</cfif>
				<cfif arraylen(xmlsearch(local.obj,"mappings")) gt 0>
					<cfset importXMLMappings(local.obj)>
				</cfif>
				<cfif arraylen(xmlsearch(local.obj,"errorcodes")) gt 0>
					<cfset importXMLErrorcodes(local.obj)>
				</cfif>
			<cfelse>
				<cfset local.result = false/>
			</cfif>
			</cfif>

			<cfcatch><cfset local.result = false/></cfcatch>
		</cftry>
		
		<cfreturn local.result/>
	</cffunction>

	<cffunction name="importXMLMappings" output="false" access="private" returntype="void">
		<cfargument name="contents" required="true" type="XML"/>
		<cfset var local = StructNew()/>
		
		<cfset local.map = arguments.contents.mappings/>
			<cfif structkeyexists(local.map.XMLAttributes,"enabled") and local.map.XMLAttributes.enabled eq false>
			<cfelse>
			<cfloop from="1" to="#arraylen(local.map.XmlChildren)#" index="local.ii">
				<cftry>
				<cfif structkeyexists(local.map.mapping[local.ii].XmlAttributes,"enabled") and local.map.mapping[local.ii].XmlAttributes.enabled eq false>
				<cfelse>
					<cfif structkeyexists(local.map.mapping,local.ii) eq false>
						<cfset local.m.name = local.map.mapping[local.ii].XmlAttributes.name/>
						<cfset variables.instance.mappings[local.m.name] = trim(local.map.mapping[local.ii].Xmltext)/>
					</cfif>
				</cfif>
				<cfcatch></cfcatch>
				</cftry>
			</cfloop>
			</cfif>
	</cffunction>

	<cffunction name="importXMLValidators" output="false" access="private" returntype="void">
		<cfargument name="contents" required="true" type="XML"/>
		<cfset var local = StructNew()/>

			<cfif isdefined("arguments.contents.validators.XmlAttributes.enabled") and arguments.contents.validators.XmlAttributes.enabled eq false>
			<cfelse>
			<cfset local.vals = arguments.contents.validators.XmlChildren>
			<cfloop from="1" to="#arraylen(local.vals)#" index="local.ii">
				<cftry>
				<cfif local.vals[local.ii].XmlName eq "validator">
					<cfif structkeyexists(local.vals[local.ii].XmlAttributes,"enabled") and local.vals[local.ii].XmlAttributes.enabled eq false>
					<cfelse>
						<cfset local.v.name = local.vals[local.ii].XmlAttributes.name/>
						<cfset insertValidator(trim(local.v.name),"XML","",trim(local.vals[local.ii].regex.Xmltext),trim(local.vals[local.ii].errorCode.Xmltext))>
					</cfif>
				</cfif>
				<cfcatch></cfcatch>
				</cftry> 
			</cfloop>

				<!---Import any mappings in this doc--->
				<cfset importXMLMappings(arguments.contents.validators)/>
				<!---Import any errorcodes in this doc--->
				<cfset importXMLErrorcodes(arguments.contents.validators)/>
			</cfif>			
	</cffunction>

	<cffunction name="importXMLErrorcodes" returntype="void" access="private" output="false">
		<cfargument name="contents" required="true" type="XML"/>
		<cfset var local = StructNew()/>
		
		<cfset local.ec = arguments.contents.errorcodes/>
			<cfif structkeyexists(local.ec.XMLAttributes,"enabled") and local.ec.XMLAttributes.enabled eq false>
			<cfelse>
			<cfloop from="1" to="#arraylen(local.ec.XmlChildren)#" index="local.ii">
				<cftry>
				<cfif structkeyexists(local.ec.errorcode[local.ii].XmlAttributes,"enabled") and local.ec.errorcode[local.ii].XmlAttributes.enabled eq false>
				<cfelse>
					<cfif structkeyexists(local.ec.errorcode,local.ii) eq false>
						<cfset local.m.name = local.ec.errorcode[local.ii].XmlAttributes.name/>
						<cfset variables.instance.defaultErrorCode[local.m.name] = trim(local.ec.errorcode[local.ii].Xmltext)/>
					</cfif>
				</cfif>
				<cfcatch></cfcatch>
				</cftry>
			</cfloop>
			</cfif>
	</cffunction>

	<cffunction name="importCFCMappings" returntype="void" access="private" output="false">
		<cfargument name="str" required="true" type="struct">
		<cfset var local = StructNew()/>
		<cfloop collection="#arguments.str#" item="local.item">
			<cfif structkeyexists(variables.instance.mappings,local.item) eq false>
				<cfset variables.instance.mappings[local.item] = arguments.str[local.item]/>
			</cfif>
		</cfloop>
	</cffunction>

	<cffunction name="importCFCValidators" returntype="void" access="private" output="false">
		<cfargument name="obj" required="true" type="any">
		<cfset var local = StructNew()/>
		<cfset local.obj = getMetaData(arguments.obj)/>
		<cfset local.isvalidator = false/>
				
		<cfif structkeyexists(local.obj,"enabled") and local.obj.enabled eq false>
		<cfelse>
			<cfset local.cfcname = local.obj.name/>
			<cfloop from="1" to="#arraylen(local.obj.functions)#" index="local.ii">
				<cfif left(local.obj.functions[local.ii].name,2) eq "is">
					<cfif structkeyexists(local.obj.functions[local.ii],"enabled") and local.obj.functions[local.ii].enabled eq false>
					<cfelse>
						<cfset insertValidator(trim(local.obj.functions[local.ii].name),"CFC",local.cfcname,"",trim(local.obj.functions[local.ii].errorCode))>
						<cfset local.isvalidator = true/>
					</cfif>
				<cfelseif local.obj.functions[local.ii].name eq "mappings">
					<!---Got some mappings in this cfc--->
					<cfset importCFCMappings(arguments.obj.mappings())/>
				<cfelseif local.obj.functions[local.ii].name eq "errorcodes">
					<!---Got some errorcodes in this cfc--->
					<cfset importCFCErrorcodes(arguments.obj.errorcodes())/>
				</cfif>
			</cfloop>
			<cfif local.isvalidator eq true><cfset variables.instance.importedCFCValidators[local.cfcname] = arguments.obj/></cfif>
		</cfif>
	</cffunction>

	<cffunction name="importCFCErrorcodes" returntype="void" access="private" output="false">
		<cfargument name="str" required="true" type="struct">
		<cfset var local = StructNew()/>
		<cfloop collection="#arguments.str#" item="local.item">
			<cfif structkeyexists(variables.instance.defaultErrorCode,local.item) eq false>
				<cfset variables.instance.defaultErrorCode[local.item] = arguments.str[local.item]/>
			</cfif>
		</cfloop>
	</cffunction>

	<cffunction name="validate" output="false" access="public" returntype="array">
		<cfargument name="data" required="true" type="struct" default=""/>
		<cfargument name="notRequire" required="false" type="string"/>
		<cfargument name="injectedValidators" required="false" type="any"/>
		<cfset var local = StructNew()/>
		<cfset local.result = arrayNew(1)/>
		<cfset local.ii = 1/>
		<cfset local.jj = 1/>

		<cfif structkeyexists(arguments,"injectedValidators") and isXML(arguments.injectedValidators)>
			<!---We have injected validators - so we just test with those submitted only--->
			<cftry>
			<cfset local.injectedValidators = xmlParse(arguments.injectedValidators).validators.XMLChildren/>
			<cfloop from="1" to="#arraylen(local.injectedValidators)#" index="local.jj">
				<cfif local.injectedValidators[local.jj].XmlName eq "validator">
				<!---Nothing fancy here - we just test specific fields against specific validators--->
				<cfset local.tmp = local.injectedValidators[local.jj].XMLAttributes.name/>
				<cfset local.tmp = right(local.tmp,Len(local.tmp)-2)/>
				<cfif structkeyexists(arguments.data,local.tmp)>
					<cfif structkeyexists(arguments,"notRequire") eq false or (ListFindNoCase(arguments.notRequire,local.tmp,',') eq false or len(arguments.data[local.tmp]))>

					<cfset local.res = ReFindNoCase(local.injectedValidators[local.jj].regex.XMLText,arguments.data[local.tmp])/>
					<cfif local.res eq false>
						<cfset local.result[local.ii] = StructNew()/>
						<cfset local.result[local.ii].fieldname = local.tmp/>
						<cfset local.result[local.ii].errorCode = local.injectedValidators[local.jj].errorCode.XMLText/>
						<cfset local.result[local.ii].value = arguments.data[local.tmp]/>
						<cfset local.ii = local.ii + 1/>
						<!---Log--->
						<cfif variables.instance.logging eq true>
							<!---We'll log this for debugging purposes--->
							<cfset insertLog(local.tmp,local.tmp,arguments.data[local.tmp],"Injected Validator - #local.injectedValidators[local.jj].XMLAttributes.name#",local.res,now())/>
						</cfif>
					</cfif>
					</cfif>
				</cfif>
				</cfif>
			</cfloop>
			<cfcatch>
					<cfset local.result[1] = StructNew()/>
					<cfset local.result[1].fieldname = ""/>
					<cfset local.result[1].errorCode = "Injected Validator Error - possibly a bad XML format"/>
					<cfset local.result[1].value = ""/>
			</cfcatch>
			</cftry>
		<cfelse>
		<cfloop collection="#arguments.data#" item="local.item">
			<cfset local.fieldname = local.item/>
			<cfset local.fieldvalue = arguments.data[local.item]/>
			
			<cfif ListFindNoCase(variables.instance.excludelist,local.fieldname,',') eq false>
			<cfif globalValidator(local.fieldvalue) eq true>  <!---Is it globally allowed--->
		
			<cfset local.originalfieldname = local.fieldname/>
			<cfset local.fieldname = getMapping(local.fieldname)/>

			<cfif len(local.item)>

			<!---Not in exclude list so let's try to validate it explicitly first--->
			<cfset local.explicitValidator = findValidator("is#local.fieldname#")>

			<cfif local.explicitValidator.recordcount eq 1>
				<cfif structkeyexists(arguments,"notRequire") eq false or (ListFindNoCase(arguments.notRequire,local.originalfieldname,',') eq false or len(local.fieldvalue))>
				<!---We have a specific validator for this item and it's not been opted out - time to test it--->				
				<cfset local.res = callValidator(local.originalfieldname,local.fieldname,local.fieldvalue,local.explicitValidator.name,local.explicitValidator.type,local.explicitValidator.cfcname,local.explicitValidator.regex)>
				
				<cfif local.res eq false>
						<cfset local.result[local.ii] = StructNew()/>
						<cfset local.result[local.ii].fieldname = local.originalfieldname/>
						<cfset local.result[local.ii].errorCode = local.explicitValidator.ErrorCode/>
						<cfset local.result[local.ii].value = local.fieldvalue/>
						<cfset local.ii = local.ii + 1/>
				</cfif>
				</cfif>
			<cfelse>
				<!---We don't have a explicit validator for this item, so we try a group search using the field name as a keyword - in other words this is an implicit validation--->
				<cfif variables.instance.implicitValidation eq true>
				<cfif structkeyexists(arguments,"notRequire") eq false or (ListFindNoCase(arguments.notRequire,local.originalfieldname,',') eq false or len(local.fieldvalue))>
					<cfset local.res = implicitValidation(local.originalfieldname,local.fieldname,local.fieldvalue)/>	
								
					<cfif len(local.res)>
						<cfset local.result[local.ii] = StructNew()/>
						<cfset local.result[local.ii].fieldname = local.fieldname/>
						<cfset local.result[local.ii].errorCode = local.res/>
						<cfset local.result[local.ii].value = local.fieldvalue/>
						<cfset local.ii = local.ii + 1/>
					</cfif>
				</cfif>
				</cfif>
			</cfif>

			</cfif>
			<cfelse>
					<!---Didn't pass the global validator--->
					<cfset local.result[local.ii] = StructNew()/>
					<cfset local.result[local.ii].fieldname = local.item/>
					<cfset local.result[local.ii].errorCode = variables.instance.defaultErrorCode["Global"]/>
					<cfset local.result[local.ii].value = arguments.data[local.item]/>
					<cfset local.ii = local.ii + 1/>

				<cfif variables.instance.logging eq true>
					<!---We'll log this for debugging purposes--->
					<cfset insertLog(local.item,local.item,arguments.data[local.item],"Global Validator","false",now())/>
				</cfif>
			</cfif>
			</cfif>
		</cfloop>
		</cfif>

		<cfif variables.instance.logging eq true><cfset cleanLog()/></cfif>
		
		<cfreturn local.result/>		
	</cffunction>

	<cffunction name="callValidator" output="false" access="private" returntype="any">
		<cfargument name="originalfieldname" required="true" type="string" default=""/>
		<cfargument name="fieldname" required="true" type="string" default=""/>
		<cfargument name="fieldvalue" required="true" type="string"/>
		<cfargument name="validatorname" required="true" type="string"/>
		<cfargument name="type" required="true" type="string"/>
		<cfargument name="cfcname" required="true" type="string"/>
		<cfargument name="regex" required="true" type="string"/>
		<cfset var local = StructNew()/>

		<cfif arguments.type eq "XML">
			<!---A XML validator--->
			<cfset local.res = ReFindNoCase(arguments.regex,arguments.fieldvalue)/>
		<cfelse>
			<!---A CFC validator--->
			<cfset local.tempFunc = variables.instance.importedCFCValidators[arguments.cfcname][arguments.validatorname]/>
			<cfset local.res = local.tempFunc(arguments.fieldvalue)/>
		</cfif>

		<cfif variables.instance.logging eq true>
			<!---We'll log this for debugging purposes--->
			<cfset insertLog(arguments.originalfieldname,arguments.fieldname,arguments.fieldvalue,arguments.validatorname,local.res,now())/>
		</cfif>
		
		<cfreturn local.res/>
	</cffunction>

	<cffunction name="implicitValidation" output="false" access="private" returntype="string">
		<cfargument name="originalFieldName" required="true" type="string"/>
		<cfargument name="validatorKeyword" required="true" type="string"/>
		<cfargument name="text" required="true" type="string" default=""/>
		<cfset var local = StructNew()/>
		<cfset local.errorCode = ""/>
		
		<cfset local.qry = findSimilarValidators(arguments.validatorKeyword)/>
		
		<cfloop query="local.qry">
				<cfset local.res = callValidator(arguments.originalFieldName,arguments.validatorKeyword,arguments.text,name,type,cfcname,regex)/>

				<cfif local.res eq true>
					<!---As long as a pass one fo the validators we are good and can proceed--->
					<cfset local.errorCode = ""/>
					<cfbreak/>
				<cfelse>
					<cfif structkeyexists(variables.instance.defaultErrorCode,arguments.validatorKeyword)>
						<cfset local.errorCode = variables.instance.defaultErrorCode[arguments.validatorKeyword]/>
						<cfelse>
						<cfset local.errorCode = variables.instance.defaultErrorCode["Default"]/>
					</cfif>
				</cfif>
		</cfloop>
		<cfreturn local.errorCode/>
	</cffunction>

	<cffunction name="getMapping" output="false" access="private" returntype="string" hint="Check to see if there are any fieldname mappings going on">
		<cfargument name="text" required="true" type="string" default=""/>
		<cfset var local = StructNew()/>
		<cfset local.result = arguments.text/>
			<cfif structkeyexists(variables.instance.mappings,"#arguments.text#")>
				<cfset local.result = variables.instance.mappings[arguments.text]/>
			</cfif>
		<cfreturn local.result/>
	</cffunction>

	<!---Logging Functions--->
	<cffunction name="insertLog" output="false" access="private" returntype="Any">
		<cfargument name="fieldname" required="true" type="String">
		<cfargument name="mappedname" required="true" type="String">
		<cfargument name="fieldvalue" required="true" type="String">
		<cfargument name="validator" required="true" type="String">
		<cfargument name="result" required="true" type="String">

		<cfset QueryAddRow(variables.instance.log, 1)>
		<cfset QuerySetCell(variables.instance.log, "FieldName", arguments.fieldname)/> 
		<cfset QuerySetCell(variables.instance.log, "MappedName", arguments.mappedname)/> 
		<cfif ListValueCountNoCase(variables.instance.itemValuesNotToLog,MappedName,",")>
		<cfset QuerySetCell(variables.instance.log, "ValueSubmitted", "[Value Not Logged by Thor]")/> 
		<cfelse>
		<cfset QuerySetCell(variables.instance.log, "ValueSubmitted", arguments.fieldvalue)/> 
		</cfif>
		<cfset QuerySetCell(variables.instance.log, "Validator", arguments.validator)/>
		<cfset QuerySetCell(variables.instance.log, "Result", formatReturn(arguments.result))/>
		<cfset QuerySetCell(variables.instance.log, "DateRecorded", now())/> 

		<cfreturn true/>
	</cffunction>

	<cffunction name="getLog" output="false" access="public" returntype="Any">
		<cfreturn variables.instance.log/>
	</cffunction>

	<cffunction name="cleanLog" output="false" access="private" returntype="Any">
		<cfset var cutoff = 0 - variables.instance.maxLogTime/>
		
		<cfquery dbtype="query" name="variables.instance.log">
		SELECT FieldName, MappedName, ValueSubmitted, Validator,Result, DateRecorded
		FROM variables.instance.log
		<cfif variables.instance.logging eq false>
		WHERE 1=0
		<cfelse>
		WHERE DateRecorded > <cfqueryparam cfsqltype="cf_sql_datetime" maxlength="50" value="#dateadd("s",cutoff,now())#">
		</cfif>
		</cfquery>

		<cfreturn true/>
	</cffunction>

	<!---Validator DB--->
	<cffunction name="insertValidator" output="false" access="private" returntype="Any">
		<cfargument name="name" required="true" type="String"/>
		<cfargument name="type" required="true" type="String"/>
		<cfargument name="cfcname" required="true" type="String"/>
		<cfargument name="regex" required="true" type="String"/>
		<cfargument name="errorcode" required="true" type="String">

		<cfif findValidator(arguments.name).recordcount eq 0>
			<cfset QueryAddRow(variables.instance.validators, 1)>
			<cfset QuerySetCell(variables.instance.validators, "Name", trim(lcase(arguments.name)))/> 
			<cfset QuerySetCell(variables.instance.validators, "Type", arguments.type)/> 
			<cfset QuerySetCell(variables.instance.validators, "CFCName", arguments.cfcname)/> 
			<cfset QuerySetCell(variables.instance.validators, "Regex", arguments.regex)/> 
			<cfset QuerySetCell(variables.instance.validators, "ErrorCode", arguments.errorcode)/>
		</cfif> 

		<cfreturn true/>
	</cffunction>

	<cffunction name="findValidator" output="false" access="private" returntype="Any">
		<cfargument name="name" required="true" type="string"/>
		<cfset var local = StructNew()/>

		<cfquery dbtype="query" name="local.res">
		SELECT Name, Type, CFCName, Regex, ErrorCode
		FROM variables.instance.validators
		WHERE name = '#trim(lcase(arguments.name))#'
		</cfquery>

		<cfreturn local.res/>
	</cffunction>

	<cffunction name="findSimilarValidators" output="false" access="private" returntype="Any">
		<cfargument name="name" required="true" type="string"/>
		<cfset var local = StructNew()/>

		<cfquery dbtype="query" name="local.res">
		SELECT Name, Type, CFCName, Regex, ErrorCode
		FROM variables.instance.validators
		WHERE name like '%#trim(lcase(arguments.name))#%'
		</cfquery>

		<cfreturn local.res/>
	</cffunction>

	<cffunction name="formatReturn" output="false" access="private" returntype="Any">
		<cfargument name="svalue" required="true" type="String">
		<cfset var result = false/>
		<cfif arguments.svalue eq 1 or arguments.svalue eq "true"><cfset result = true/></cfif>
		<cfreturn result/>
	</cffunction>

</cfcomponent>