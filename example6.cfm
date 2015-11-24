<cfset thor = createObject("component","thor.com.fusionlink.Thor").init()/>

<cfset lib = createObject("component","thor.com.fusionlink.libraries.Postalcodes").init()/>
<cfset thor.import(lib)/>


<cfparam name="form.postalcodeformat1" default=""/>
<cfparam name="form.postalcodeformat2" default=""/>
<cfparam name="form.postalcodeformat3" default=""/>
<cfparam name="form.postalcodeformat5" default=""/>
<cfparam name="form.postalcodeformat6" default=""/>
<cfparam name="form.postalcodeformat7" default=""/>
<cfparam name="form.uspostalcode" default=""/>
<cfparam name="form.ukpostalcode" default=""/>
<cfparam name="form.postalcode" default=""/>

<cfif url.action eq "process">
	<cfset request.errors = thor.validate(form)/>
</cfif>


<h1>Checking Postalcode Formats</h1>
<table width="100%"><tr><Td valign="top">

<table>
<form method="post" action="example6.cfm?action=process" enctype="multipart/form-data">
<cfoutput>	
<tr><td>PSC 1:</td><td><input type="text" name="postalcodeformat1" value="#form.postalcodeformat1#"/> - ie. AA-999</td></tr>
<tr><td>PSC 2:</td><td><input type="text" name="postalcodeformat2" value="#form.postalcodeformat2#"/> - ie. 999999</td></tr>
<tr><td>PSC 3:</td><td><input type="text" name="postalcodeformat3" value="#form.postalcodeformat3#"/> - ie. AA-9999</td></tr>
<tr><td>PSC 5:</td><td><input type="text" name="postalcodeformat5" value="#form.postalcodeformat5#"/> - ie. AA-99999</td></tr>
<tr><td>PSC 6:</td><td><input type="text" name="postalcodeformat6" value="#form.postalcodeformat6#"/> - ie. 99-99</td></tr>
<tr><td>PSC 7:</td><td><input type="text" name="postalcodeformat7" value="#form.postalcodeformat7#"/> - ie. SW-999 99</td></tr>
<tr><td>US:</td><td><input type="text" name="uspostalcode" value="#form.uspostalcode#"/> - ie. 99999-9999</td></tr>
<tr><td>UK:</td><td><input type="text" name="ukpostalcode" value="#form.ukpostalcode#"/> - ie. AB1 4BL</td></tr>
<tr><td>Other:</td><td><input type="text" name="postalcode" value="#form.postalcode#"/> - any others we want to test</td></tr>
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


