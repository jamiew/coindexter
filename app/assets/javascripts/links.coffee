# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# css 'background-image', 'url("http://image.com")'  

$prev_scroll_top = 0

if $('.pagination').length == 0
	$(window).on "scroll", ->
		$url = $('.pagination .next_page').attr('href')
		if $url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
			$('.pagination').text 'Loading...'
			return $.getScript($url)
		return
	return $(window).scroll()
return

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