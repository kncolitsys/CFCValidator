
<cfset application.coldspring = createObject('component', 'coldspring.beans.defaultXMLbeanfactory').init() />
<cfset application.coldspring.loadBeansFromXMLFile( expandPath('coldspring.xml') ) />

<cfset thor = application.coldspring.getBean("Thor") />

<cfparam name="form.email" default=""/>
<cfparam name="form.ssn" default=""/>
<cfparam name="form.age" default=""/>
<cfparam name="form.ipaddress" default=""/>
<cfparam name="form.creditcard" default=""/>

<cfif url.action eq "process">
	<cfset request.errors = thor.validate(form)/>
</cfif>


<h1>Using Thor with Coldspring</h1>
<p>You first need <a href="http://www.coldspringframework.org/" target="new">Coldspring</a> to run this example.</p>
<table width="100%"><tr><Td valign="top">

<table>
<form method="post" action="example8.cfm?action=process" enctype="multipart/form-data">
<cfoutput>	
<tr><td>Email:</td><td><input type="text" name="email" value="#form.email#"/></td></tr>
<tr><td>SSN:</td><td><input type="text" name="ssn" value="#form.ssn#"/></td></tr>
<tr><td>Age:</td><td><input type="text" name="age" value="#form.age#"/></td></tr>
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