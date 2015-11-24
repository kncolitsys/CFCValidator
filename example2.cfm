
<!---
	This top portion would normally be in your onApplication start or have similar logic in your Application.cfm
	Note, you would apply some type of conditional logic to this to run it once when the application loads up
--->
<cfset application.Thor = createObject("component","thor.com.fusionlink.Thor").init()/>

<!---Importing CFC based validators--->
<cfset lib = createObject("component","thor.com.fusionlink.libraries.BasicValidators").init()/>
<cfset application.Thor.import(lib)/>

<cfset lib = createObject("component","thor.com.fusionlink.libraries.CFValidators").init()/>
<cfset application.Thor.import(lib)/>

<cfset lib = createObject("component","thor.com.fusionlink.libraries.PhoneNumbers").init()/>
<cfset application.Thor.import(lib)/>

<cfset lib = createObject("component","thor.com.fusionlink.libraries.Postalcodes").init()/>
<cfset application.Thor.import(lib)/>

<!---Import a XML file by directory path--->
<cfset application.Thor.import(expandpath("com/fusionlink/formatexamples/Mappings.xml"))/>

<!---Import a XML Validator library with cffile--->
<cffile action="read" variable="lib" file="#expandpath("com/fusionlink/libraries/ExtraValidators.xml")#"/>
<cfset application.Thor.import(lib)/>

<!---XML of Error codes loaded in with cfxml--->
<cfxml variable="ec1">
<errorcodes name="Sample Error Codes" enabled="false">
	<errorcode name="firstname" enabled="false">Not a valid String</errorcode>
	<errorcode name="lastname" enabled="false">Not a valid String</errorcode>
</errorcodes>
</cfxml>
<cfset application.Thor.import(ec1)/>





<cfparam name="form.email" default=""/>
<cfparam name="form.dayphone" default=""/>
<cfparam name="form.ssn" default=""/>
<cfparam name="form.age" default=""/>
<cfparam name="form.postalcode" default=""/>
<cfparam name="form.ipaddress" default=""/>
<cfparam name="form.creditcard" default=""/>

<cfif url.action eq "process">
	<cfset request.errors = application.Thor.validate(form)/>
</cfif>


<h1>Demo of the Thor Validator with several import examples</h1>
<table width="100%"><tr><Td valign="top">

<table>
<form method="post" action="example2.cfm?action=process" enctype="multipart/form-data">
<cfoutput>	
<tr><td>Email:</td><td><input type="text" name="email" value="#form.email#"/></td></tr>
<tr><td>Day Phone:</td><td><input type="text" name="dayphone" value="#form.dayphone#"/></td></tr>
<tr><td>SSN:</td><td><input type="text" name="ssn" value="#form.ssn#"/></td></tr>
<tr><td>Age:</td><td><input type="text" name="age" value="#form.age#"/></td></tr>
<tr><td>Postal Code:</td><td><input type="text" name="postalcode" value="#form.postalcode#"/></td></tr>
<tr><td>IP Address:</td><td><input type="text" name="ipaddress" value="#cgi.remote_addr#"/></td></tr>
<tr><td>Credit Card:</td><td><input type="text" name="creditcard" value="#form.creditcard#"/></td></tr>
</cfoutput>
<tr><td></td><td><input type="submit" value="Submit" class="submitbtn"/></td></tr>
</form>
</table>

</td><td valign="top">

	<cfif isdefined("request.errors")>
		<cfdump label="Validation Errors Detected" var="#request.errors#"/>
	</cfif>

</td></tr></table>

</body>
</html>


