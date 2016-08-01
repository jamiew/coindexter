# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$text = $('.account').text()
	$img = $('.account').find('img')
	$('.has-application').bootstrapSwitch 'state', true
	$switchState = true
	$('.account').mouseover ->
		$(this).text ' Signout'
		$(this).prepend $img 
	$('.account').mouseout ->
		$(this).text $text
		$(this).prepend $img
	$('.bootstrap-switch-id-coin_has_application').on 'switchChange.bootstrapSwitch', ->
		$switchState = !$switchState
		$('.application-info').prop 'disabled', $switchState


	



	

