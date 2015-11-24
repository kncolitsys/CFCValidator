<cfsetting enablecfoutputonly="true" showdebugoutput="false">
<cfsilent>
	<!---Remember, this top portion would normally be in an application or coldspring file--->
	<cfset application.Thor = createObject("component","thor.com.fusionlink.Thor").init()/>
	<cfset lib = createObject("component","thor.com.fusionlink.libraries.BasicValidators").init()/>
	<cfset application.Thor.import(lib)/>
	
	<cfset request.errorText = ""/>

	<cfif structkeyexists(form,"item") and structkeyexists(form,"data")>
		<cfset request.jQueryData[form.item] = form.data/>
		<cfset request.errors = application.Thor.validate(request.jQueryData)/>
		<cfif arraylen(request.errors) eq 1>
			<cfset request.errorText = request.errors[1].errorCode/>
		</cfif>
	</cfif>
</cfsilent>
<cfoutput><error>#request.errorText#</error></cfoutput>

