# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

if $('.pagination').length == 0
	$(window).on "scroll", ->
		$url = $('.pagination .next_page').attr('href')
		if $url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
			$('.pagination').text 'Loading...'
			return $.getScript($url)
		return
	return $(window).scroll()
return