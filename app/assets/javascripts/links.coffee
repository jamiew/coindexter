# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# css 'background-image', 'url("http://image.com")'  

$ ->
	$('.coin-option').each ->
		$url = $(this).data 'icon'
		$(this).css 'background-image', "url('http://coindexter.herokuapp.com" + $url + "')"
	$('.network-option').each ->
		$url = $(this).data 'icon'
		$(this).css 'background-image', "url('http://coindexter.herokuapp.com" + $url + "')"	

		