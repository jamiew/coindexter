# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# css 'background-image', 'url("http://image.com")'  

$prev_scroll_top = 0

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

$ -> 
	$('a.reply-to-comment').on 'click', ->
		$(this).hide()
		$(this).parent().children("form").toggle()
	$('a.cancel-form').on 'click', ->
		$(this).parent().toggle()	

	$('.network-option').each ->
		url = $(this).data 'icon'
		$(this).css 'background-image', "url('" + url + "')"

	$('.coin-option').each ->
		url = $(this).data 'icon'
		$(this).css 'background-image', "url('" + url + "')"