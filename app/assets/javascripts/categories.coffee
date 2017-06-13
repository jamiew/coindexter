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
			$('.results > div > .widget').hide()
			search_selector = 'a[data-category="' + cat + '"]'
			$(search_selector).show()
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

	$('ul#status-info-menu > li,ul#category-info-menu > li').click ->
		cat = $(this).attr 'data-status'
		cat2 = $(this).attr 'data-category'
		$('ul#status-info-menu > li').removeClass 'active-item'
		$('ul#status-info-menu > li#status-show-all, ul#categoryinfo-menu > li#category-show-all').addClass 'active-item'
		$('.offset-removed').addClass 'col-md-offset-1'
		$('#none-matching').remove()
		$('.first-network-widget').removeClass 'col-md-offset-1'
		if cat == 'all'	
			$('p#none-matching').remove()
			$('li.status-show-all').addClass 'active-item'
			$('.widget').show()
			$('.results > div > .widget').show()
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
			selector = 'a[data-status="' + cat + '"]'
			$('a.widget').hide()
			$(selector).show()
			$('ul.full-category-cnt, .network-results, .coin-results').each ->
				networksShown = $(@).find('a.network-widget, a.coin-widget').filter(->
					$(this).css('display') != 'none'
				)
				if networksShown.length == 0
					if cat == null
						alert 'hey'
						$(@).find('h1').after '<p id="none-matching">None match ' + cat2 + '</p>'
					else
						alert 'hey'
						$(@).find('h1').after '<p id="none-matching">None match ' + cat + '</p>'
				else
					networksShown.each (index, element) -> 
						if index == 0 || index % 3 == 0
							$(@).find('div').removeClass 'col-md-offset-1'
							$(@).find('div').addClass 'col-md-offset-0'
						else 
							$(@).find('div').removeClass 'col-md-offset-0'
							$(@).find('div').addClass 'col-md-offset-1'



	