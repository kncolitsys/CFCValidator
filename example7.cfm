<cfset thor = createObject("component","thor.com.fusionlink.Thor").init()/>

<cfset lib = createObject("component","thor.com.fusionlink.libraries.PhoneNumbers").init()/>
<cfset thor.import(lib)/>


<cfparam name="form.phoneformat1" default=""/>
<cfparam name="form.usphone" default=""/>
<cfparam name="form.phoneformat3" default=""/>
<cfparam name="form.ukphone" default=""/>
<cfparam name="form.frenchphone" default=""/>
<cfparam name="form.germanphoneformat1" default=""/>
<cfparam name="form.germanphoneformat2" default=""/>
<cfparam name="form.germanphoneformat3" default=""/>
<cfparam name="form.germanphoneformat4" default=""/>
<cfparam name="form.germanphoneformat5" default=""/>
<cfparam name="form.germanphoneformat6" default=""/>
<cfparam name="form.germanphoneformat7" default=""/>

<cfif url.action eq "process">
	<cfset request.errors = thor.validate(form)/>
</cfif>

<h1>Checking Phone Number Formats</h1>
<table width="100%"><tr><Td valign="top">

<table>
<form method="post" action="example7.cfm?action=process" enctype="multipart/form-data">
<cfoutput>	
<tr><td>Phone 1:</td><td><input type="text"  name="phoneformat1"  value="#form.phoneformat1#"/> - ie. AAA-BBBB-BBBB or AAA BBBB BBBB</td></tr>
<tr><td>NANP:</td><td><input type="text"     name="usphone"       value="#form.usphone#"/> - ie. AAA-BBB-BBBB (AAA) BBB-BBBB</td></tr>
<tr><td>Phone 3:</td><td><input type="text"  name="phoneformat3"  value="#form.phoneformat3#"/> - ie. AA AA AA AA or AAA AA AAA</td></tr>
<tr><td>UK:</td><td><input type="text"       name="ukphone"       value="#form.ukphone#"/> - ie. 0AAAA BBBBBB or +44(0)AAAA BBBBBB</td></tr>
<tr><td>French:</td><td><input type="text"   name="frenchphone"   value="#form.frenchphone#"/> - ie. 0A AA AA AA AA</td></tr>
<tr><td>German 1:</td><td><input type="text" name="germanphoneformat1" value="#form.germanphoneformat1#"/> - ie. 0AAA BBBBBB or 0AAA BBBBBB-XX</td></tr>
<tr><td>German 2:</td><td><input type="text" name="germanphoneformat2" value="#form.germanphoneformat2#"/> - ie. +49 AAA BBBBBB or +49 (AAA) BBBBBB or +49 (0AAA) BBBBBB</td></tr>
<tr><td>German 3:</td><td><input type="text" name="germanphoneformat3" value="#form.germanphoneformat3#"/> - ie. +49 (0AAA) / BBBBBBB or +49 (0AAA) BBBBBBB</td></tr>
<tr><td>German 4:</td><td><input type="text" name="germanphoneformat4" value="#form.germanphoneformat4#"/> - ie. 0AAA / BBB BBB BB</td></tr>
<tr><td>German 5:</td><td><input type="text" name="germanphoneformat5" value="#form.germanphoneformat5#"/> - ie. +49 0AAA / BBBB</td></tr>
<tr><td>German 6:</td><td><input type="text" name="germanphoneformat6" value="#form.germanphoneformat6#"/> - ie. +49 (0AAAA) BBBBB</td></tr>
<tr><td>German 7:</td><td><input type="text" name="germanphoneformat7" value="#form.germanphoneformat7#"/> - ie. +49 (0AA) BB BB BBB-B</td></tr>
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


