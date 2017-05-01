# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', -> 
	$('ul#category-info-menu > li').click ->
		cat = $(this).attr 'data-category'
		selector = 'ul[data-category="' + cat + '"]'
		$('ul#category-info-menu > li').removeClass 'active-item'
		$(this).addClass 'active-item'
		$('ul.full-category-cnt').hide()
		$(selector).show()
		window.scrollTo(0, 0)

	$('#category-show-all').click ->
		$('ul.networks-in-categories').show()

	$('ul#category-dropdown > li').click ->
		cat = $(this).attr 'data-category'
		selector = 'ul[data-category="' + cat + '"]'
		$('ul.full-category-cnt').hide()
		$('button.dropdown-toggle').text $(this).text()
		$(selector).show()

	$('ul#status-info-menu > li').click ->
		cat = $(this).attr 'data-status'
		selector = 'a[data-status="' + cat + '"]'
		$('ul#status-info-menu > li').removeClass 'active-item'
		$(this).addClass 'active-item'
		$('a.network-widget').hide()
		$(selector).show()
		window.scrollTo(0, 0)
	