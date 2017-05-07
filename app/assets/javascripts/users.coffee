# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	width = $('#header-link-account').width() + 16
	$('#header-link-account').css 'min-width', width

