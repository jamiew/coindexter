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

	$whitepaperCount = 0
	$("#add-another-whitepaper").on "click", ->
		$parent_id = $(this).parent().attr 'id'
		$parent_id_length = $parent_id.length
		$repo_number = parseInt($parent_id.substring($parent_id_length - 1,$parent_id_length))
		$repo_plus_one = $repo_number + 1
		$parent_html = $(this).parent().parent()
		$parent_html.first().find("input").attr 'name', 'network[whitepapers][' + $repo_plus_one + '][name]'
		$parent_html_to_insert = '<div class="row grouped-row grouped-row-last">' + $parent_html.html() + '</div>'
		$prev_parent_html = $(this).parent().parent().prev()
		$prev_parent_html.first().find("input").attr 'name', 'network[whitepapers][' + $repo_plus_one + '][name]'
		$prev_parent_html_to_insert = '<div class="row grouped-row grouped-row-first">' + $prev_parent_html.html() + '</div>'
		$(this).hide()
		$(this).parent().parent().after $prev_parent_html_to_insert + $parent_html_to_insert
		$(this).parent().parent().next().find("input").val ''
		$(this).parent().parent().next().next().find("input").val ''

	$("#add-another-founder").on "click", ->
		$(this).before "<input type='text' name='founders[]'' id='founders'>"

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
			$('.action-links').css 'bottom', 10
	
	$('input#coin_name').on "keyup", ->
		$network_name = $('.quick-search-results').data("network-name")
		$inputVal = $(this).val()
		if ($inputVal.length > 2) 
			$.get '/coin_search',
		      query: $inputVal,
		      network: $network_name