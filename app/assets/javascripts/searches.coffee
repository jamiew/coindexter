# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ -> 
	$('.search-filter-categories > li').on "click", ->
		ids = $(this).attr 'id'
		$('.search-filter-categories > li').removeClass "active-item"
		$(this).addClass "active-item"
		$(".coins-in-categories").hide()
		$("div." + ids).show()

