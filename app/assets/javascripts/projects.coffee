# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ -> 
	$(".add-another").on "click", ->
		$(this).before "<input type='text' name='founders[]'' id='founders'>"