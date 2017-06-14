# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', -> 

	$('ul#network-category-info-menu > li').click ->
		set_menu($(this), 'category')	
		value = $(this).attr 'data-category'
		hide_show_matching_groups(value, 'category')

	$('ul#network-status-info-menu > li').click ->
		set_menu($(this), 'status')	
		value = $(this).attr 'data-status'
		hide_show_matching_items(value, 'status')	

	$('ul#search-category-info-menu > li').click ->
		set_menu($(this), 'category')	
		value = $(this).attr 'data-category'
		hide_show_matching_items(value, 'category')

	$('ul#search-status-info-menu > li').click ->
		set_menu($(this), 'status')	
		value = $(this).attr 'data-status'
		hide_show_matching_items(value, 'status')
		
	set_menu = (selected, type) ->
		selector = 'ul.' + type + '-info-menu > li'	
		$(selector).removeClass 'active-item'
		selected.addClass 'active-item'

	hide_show_matching_items = (value, type) ->
		$('.first-network-widget').removeClass 'col-md-offset-1'
		$('.offset-removed').addClass 'col-md-offset-1'
		$('p#none-matching').remove()
		if value == 'all'
			$('a.widget').show()
			$('ul.full-category-cnt, .network-results, .coin-results').each ->
				networksShown = $(@).find('a.network-widget, a.coin-widget')
				networksShown.each (index, element) -> 
					if index == 0 || index % 3 == 0
						$(@).find('div').removeClass 'col-md-offset-1'
						$(@).find('div').addClass 'col-md-offset-0'
					else 
						$(@).find('div').removeClass 'col-md-offset-0'
						$(@).find('div').addClass 'col-md-offset-1'
		else
			$('a.widget').hide()
			$('a[data-' + type + '="' + value + '"]').show()
			$('ul.full-category-cnt, .network-results, .coin-results').each ->
				networksShown = $(@).find('a.network-widget, a.coin-widget').filter(->
					$(this).css('display') != 'none'
				)
				if networksShown.length == 0
					if !$(@).find('p').length > 0
						$(@).find('h1').after '<p id="none-matching">None match ' + value.substr(0,1).toUpperCase()+value.substr(1) + '</p>'					
				else
					networksShown.each (index, element) -> 
						if index == 0 || index % 3 == 0
							$(@).find('div').removeClass 'col-md-offset-1'
							$(@).find('div').addClass 'col-md-offset-0'
						else 
							$(@).find('div').removeClass 'col-md-offset-0'
							$(@).find('div').addClass 'col-md-offset-1'


	hide_show_matching_groups = (value, type) ->
		if value == 'all'
			$('ul.full-category-cnt').show()
		else
			$('ul.full-category-cnt').hide()
			$('ul[data-' + type + '="' + value + '"]').show()




	