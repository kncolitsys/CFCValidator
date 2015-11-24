<cfapplication name="ThorExamples" applicationTimeout="#createTimeSpan(0,2,0,0)#"/>
<cfsetting showDebugOutput="false">
<cfparam name="url.action" default="display"/>

<cfif cgi.script_name does not contain "example9-checker.cfm">
<!---For simplicity we have some header logic here--->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en" dir="ltr">
<head>
<link href="css/default.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery-1.2.6.min.js"></script>
</head>

<body>
<cfinclude template="header.cfm">
</cfif>