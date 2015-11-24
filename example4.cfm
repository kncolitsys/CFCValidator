
<!---
	This top portion would normally be in your onApplication start or have similar logic in your Application.cfm
	Note, you would apply some type of conditional logic to this to run it once when the application loads up
--->
<cfset application.Thor = createObject("component","thor.com.fusionlink.Thor").init()/>

<cfset lib = createObject("component","thor.com.fusionlink.libraries.BasicValidators").init()/>
<cfset application.Thor.import(lib)/>




<cfparam name="form.email" default=""/>
<cfparam name="form.color" default=""/>

<cfif url.action eq "process">

	<cfxml variable="lib1">
	<validators>

		<validator name="isColor">
			<regex><![CDATA[^#?([a-f]|[A-F]|[0-9]){3}(([a-f]|[A-F]|[0-9]){3})?$]]></regex>
			<errorCode>Not a valid hexadecimal color code</errorCode>
		</validator>
	
	</validators>
	</cfxml>
	
	<cfset fieldsNotRequired = "">
	<cfset request.errors = application.Thor.validate(form,fieldsNotRequired,lib1)/>
</cfif>


<h1>Thor "On-the-fly" Validation</h1>
<p>
Even though we have imported a library, only the injected validate is used.
</p>
<table width="100%"><tr><Td valign="top">

<table>
<form method="post" action="example4.cfm?action=process" enctype="multipart/form-data">
<cfoutput>	
<tr><td>Email:</td><td><input type="text" name="email" value="#form.email#"/></td></tr>
<tr><td>Hex Color:</td><td><input type="text" name="color" value="#form.color#"/></td></tr>
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


