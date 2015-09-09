$(document).ready(function() {
   
   $("#update-tweet").submit(function(event){
   		event.preventDefault();
   		var $button = $(this).children("#update-submit");
   		$button.val("Loading..");
   		$button.attr("disable", true);
   		
   		$.ajax({
   			url: $(this).attr("action"),
   			method: $(this).attr("method"),
   			data: $(this).serialize(),
   			cache: false,
   			success: function(response){
   				$("#status").html("</br>Tweet successfully updated!");
   				$button.attr('disable',false);
   				$button.val('post it!');
   			},
   			error: function(){
   				$("#status").html("</br>Unable to tweet");
   				$button.attr('disable',false);
   				$button.val('post it!');
   			}
   		});
   });
});
