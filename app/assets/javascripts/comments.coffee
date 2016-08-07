# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ -> 
	$('a.reply-to-comment').on 'click', ->
		$(this).hide()
		$(this).parent().children("form").toggle()
	$('a.cancel-form').on 'click', ->
		$(this).parent().toggle()	