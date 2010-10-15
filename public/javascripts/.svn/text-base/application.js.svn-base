// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function rank(id,v) {
	v = 100 - (v * 100);
	
	
	new Ajax.Request('/rankings/update/',
			  {
			    method:'post',
			    parameters: {story_id: id, score: v , authenticity_token : window._token},
			    onSuccess: function(transport){       },
			    onFailure: function(transport){
			        var response = transport.responseText || "no response text";
			        alert("Error! \n\n" + response);}
			  });
	
	
}

function change_tooltip (v) {
	v = 100 - (v * 100);
	text =
		(v<0) ? "Error" :
		(v<20) ? "lame" :
		(v<40) ? "meh" :
		(v<60)? "not bad" :
		(v<80)? "impressive" :
		(v<100)? "awesome" :
		"out-of-range" ;
	$('tooltip').update(text);
}

// This code will run when the page is loaded
$(function() {
	$('#new_comment_form').submit(function() {
		$.post($(this).attr('action'), 
		$(this).serializeArray(), null, 'script');
		return false;
	});
	
});
