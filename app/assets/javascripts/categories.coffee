# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ -> 
	$('#info-menu > li').on 'click', ->
		$('#info-menu > li').removeClass 'active-item'
		$(this).addClass 'active-item'
