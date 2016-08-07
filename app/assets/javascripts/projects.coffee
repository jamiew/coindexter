# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ -> 
	$(".add-another").on "click", ->
		$(this).before "<input class='form-input appended-form-input' type='text' name='project[founders]' id='project_founders'>"