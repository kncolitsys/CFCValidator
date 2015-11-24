
<h1>Dumping the validator log and list of imported validators</h1>
<p>
Might need to run one of the other example pages first before hitting this.
</p>

	<cfdump label="Thor Log" var="#application.Thor.getLog()#">
	<p>&nbsp;</p>
	<cfdump label="List of Imported Validators" var="#application.Thor.getValidators()#">
