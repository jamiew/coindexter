# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$text = $('.account').text()
	$img = $('.account').find('img')
	$('.has-application').bootstrapSwitch 'state', true
	$switchState = $('.has-application').bootstrapSwitch 'state'
	$('.application-info').prop 'disabled', !$switchState
	$('.account').mouseover ->
		$(this).text ' Signout'
		$(this).prepend $img 
	$('.account').mouseout ->
		$(this).text $text
		$(this).prepend $img
	$('.bootstrap-switch-id-coin_has_application').on 'switchChange.bootstrapSwitch', ->
		$('.application-info').prop 'disabled', $switchState
	$('ul#info-menu > li').click ->
		selector = 'ul#' + $(this).attr 'id'
		$('.show-all').removeClass 'active-item'
		$('ul.full-category-cnt').hide()
		$(selector).show()
	$('#show-all').click ->
		$('ul.full-category-cnt').show()
	chart = new (cryptowatch.Embed)('coinbase', 'btcusd',
		height: 400
		customColorScheme:
			bg: 'fdeee9'
			text: '545454'
			textStrong: '545454'
			textWeak: 'CCCCCC'
			short: 'EB3333'
			shortFill: 'EB3333'
			long: '23a06d'
			longFill: '23a06d'
			cta: '000000'
			ctaHighlight: '000000'
			alert: '000000')

	chart.mount '#chart'


	



	

