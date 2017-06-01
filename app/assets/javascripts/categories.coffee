# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', -> 

	$('ul#category-info-menu > li').click ->
		cat = $(this).attr 'data-category'
		$('ul#category-info-menu > li').removeClass 'active-item'
		$(this).addClass 'active-item'
		if cat == 'all'
			$('ul.full-category-cnt').show()
		else
			selector = 'ul[data-category="' + cat + '"]'
			$('ul.full-category-cnt').hide()
			$(selector).show()
			$(selector).addClass 'full-category-cnt-active'
			window.scrollTo(0, 0)

	$('ul#search-filter-categories > li').click ->
		cat = $(this).attr 'data-group'
		$('ul#search-filter-categories > li').removeClass 'active-item'
		$(this).addClass 'active-item'
		if cat == 'all'
			$('li.sale-block').show()
		else
			selector = 'li[data-group="' + cat + '"]'
			alert selector
			$('li.sale-block').hide()
			$(selector).show()
			window.scrollTo(0, 0)

	$('div#category-dropdown > ul > li').click ->
		cat = $(this).attr 'data-category'
		selector = 'ul[data-category="' + cat + '"]'
		$('ul.full-category-cnt').hide()
		$('button.dropdown-toggle').text $(this).text()
		$(selector).show()

	$('ul#status-info-menu > li').click ->
		cat = $(this).attr 'data-status'
		$('ul#status-info-menu > li').removeClass 'active-item'
		$(this).addClass 'active-item'
		$('.offset-removed').addClass 'col-md-offset-1'
		$('#none-matching').remove()
		$('.first-network-widget').removeClass 'col-md-offset-1'
		if cat == 'all'	
			$('a.network-widget').show()
			$('ul.full-category-cnt').each ->
				networksShown = $(@).find('a.network-widget')
				networksShown.each (index, element) -> 
					if index == 0 || index % 3 == 0
						$(@).find('div').removeClass 'col-md-offset-1'
						$(@).find('div').addClass 'col-md-offset-0'
					else 
						$(@).find('div').removeClass 'col-md-offset-0'
						$(@).find('div').addClass 'col-md-offset-1'
		else
			selector = 'a[data-status="' + cat + '"]'
			$('a.network-widget').hide()
			$(selector).show()
			$('ul.full-category-cnt').each ->
				networksShown = $(@).find('a.network-widget').filter(->
					$(this).css('display') != 'none'
				)
				if networksShown.length == 0
					$(@).find('h1').after '<p id="none-matching">None are ' + cat + '</p>'
				else
					networksShown.each (index, element) -> 
						if index == 0 || index % 3 == 0
							$(@).find('div').removeClass 'col-md-offset-1'
							$(@).find('div').addClass 'col-md-offset-0'
						else 
							$(@).find('div').removeClass 'col-md-offset-0'
							$(@).find('div').addClass 'col-md-offset-1'



	