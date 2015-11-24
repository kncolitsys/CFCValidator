<script type="text/javascript">
//You shouldn't have to change this jQuery code very much - it pretty much figures everything out for you
jQuery(document).ready(function() {
	var $j = jQuery.noConflict();
	
	$j('input[type="text"]').addClass("idleField");  
	$j('.error').hide();  

    $j('input[type="text"]').focus(function() {  
         $j(this).removeClass().addClass("focusField");  
    });  

    $j('input[type="text"]').blur(function() {
    	var fieldData = $j(this).val();
    	var fieldName = $j(this).attr("name");
    	var errorField = fieldName + "_error";
    	var errorText = '';

	   $j.post(
       'example9-checker.cfm',
       {item : fieldName,data : fieldData},
       function(xml){
       		if ($j(xml).text() > ''){
    	    	$j("input[name='"+fieldName+"']").removeClass().addClass("errorField");
	    		$j("label[id='"+errorField+"']").text($j(xml).text());
	    		$j("label[id='"+errorField+"']").show();
       		}else{
    	    	$j("input[name='"+fieldName+"']").removeClass().addClass("idleField");
	    		$j("label[id='"+errorField+"']").text('');
	    		$j("label[id='"+errorField+"']").hide();
       		}
       });
        
    });  
   
});

</script>

<cfparam name="form.email" default=""/>
<cfparam name="form.age" default=""/>	
<cfparam name="form.creditcard" default=""/>	

<h1>Using Thor with jQuery for Client side Validation</h1>
<p>jQuery calls example9-checker.cfm each time you leave an input field to check if the value passes validation. This method works well, but can be very chatty with the server. Feel free to pass along your experiences on how this scales.</p>
<form method="post" action="example9.cfm?action=process">
<cfoutput>	
<label>Email:</label> <label id="email_error" class="error"></label>
<input id="email" type="text" name="email" value="#form.email#"/>

<label>Age:</label> <label id="age_error" class="error"></label>
<input id="age" type="text" name="age" value="#form.age#"/>

<label>Credit Card:</label> <label id="creditcard_error" class="error"></label>
<input id="creditcard" type="text" name="creditcard" value="#form.creditcard#"/>
</cfoutput>
<input type="submit" value="Submit" class="submitbtn"/>
</form>


</body>
</html>


