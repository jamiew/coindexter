# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
	$text = $('.account').text()
	$img = $('.account').find('img')
	$('.account').mouseover ->
			$(this).text ' Signout'
			$(this).prepend $img 
	$('.account').mouseout ->
			$(this).text $text
			$(this).prepend $img 
