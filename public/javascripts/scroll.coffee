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
		$('.action-links').css 'bottom', 40
