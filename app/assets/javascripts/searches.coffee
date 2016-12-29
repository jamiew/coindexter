# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ -> 
	$('ul#info-menu > li').click ->
		selector = 'ul#' + $(this).attr 'id'
		$('#info-menu > li').removeClass 'active-item'
		$('ul.full-category-cnt').hide()
		$(this).addClass('active-item')
		$(selector).show()
	$('#show-all').click ->
		$('ul.full-category-cnt').show()
		$(this).addClass('active-item')
