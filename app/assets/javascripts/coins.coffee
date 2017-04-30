# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

	###
	if $(".coin-main-info").length > 0
	chart = new (cryptowatch.Embed)('coinbase', 'btcusd',
		height: 300
		customColorScheme:
			bg: 'fdeee9'
			text: '545454'
			textStrong: '545454'
			textWeak: '999999'
			short: 'EB3333'
			shortFill: 'EB3333'
			long: '23a06d'
			longFill: '23a06d'
			cta: '000000'
			ctaHighlight: '000000'
			alert: '000000')

	chart.mount '#chart'
	###

	$prev_scroll_top = 0

	$('.network-option').each ->
		url = $(this).data 'icon'
		$(this).css 'background-image', "url('http://coindexter.io" + url + "')"

	$(window).on "scroll", ->
		$scroll_height = $('body').prop 'scrollHeight'
		$scroll_top = $('body').scrollTop()
		$up_or_down
		if $prev_scroll_top > $scroll_top
			$up_or_down = "up"
		else
			$up_or_down = "down"
		$body_height = $('body').height()
		$remaining = $scroll_height - ($scroll_top + $body_height)
		if $remaining < 40
			$curr_bottom = $('.action-links').css('bottom')
			$curr_bottom = 40 + (40 - $remaining)
			$('.action-links').css 'bottom', $curr_bottom
		else 
			$('.action-links').css 'bottom', 30


	$('ul#related-dropdown > li').click ->
		selector = $(this).attr 'data-link'
		$.get selector, (data) ->
  			$('body').html data





		

