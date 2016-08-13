# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$text = $('.account').text()
	$img = $('.account').find('img')
	$('.has-application').bootstrapSwitch 'state', true
	$switchState = $('.has-application').bootstrapSwitch 'state'
	$('.application-info').prop 'disabled', !$switchState
	$('.account').mouseover ->
		$(this).text ' Signout'
		$(this).prepend $img 
	$('.account').mouseout ->
		$(this).text $text
		$(this).prepend $img
	$('.bootstrap-switch-id-coin_has_application').on 'switchChange.bootstrapSwitch', ->
		$('.application-info').prop 'disabled', $switchState
	$('ul#info-menu > li').click ->
		selector = 'ul#' + $(this).attr 'id'
		$('.show-all').removeClass 'active-item'
		$('ul.full-category-cnt').hide()
		$(selector).show()
	$('#show-all').click ->
		$('ul.full-category-cnt').show()
	$("a#add-another-repo").on "click", ->
		$parent_id = $(this).parent().attr 'id'
		$parent_id_length = $parent_id.length
		$repo_number = parseInt($parent_id.substring($parent_id_length - 1,$parent_id_length))
		$repo_plus_one = $repo_number + 1
		$(this).hide()
		$(this).parent().parent().after '<div class="row"><div class="col-md-4 label"><label class="form-label" for="coin_repositories_attributes_1_Repo Name">Repo name</label></div><div class="col-md-8"><input type="text" name="coin[repositories_attributes][' + $repo_plus_one + '][name]" id="coin_repositories_attributes_1_name"></div></div><div class="row"><div class="col-md-4 label"><label class="form-label" for="coin_repositories_attributes_1_Repo URL">Repo url</label></div><div class="col-md-8" id="repository-' + $repo_plus_one + '"><input type="text" name="coin[repositories_attributes][' + $repo_plus_one + '][url]" id="coin_repositories_attributes_1_url"></div></div>'
	if $(".coin-main-info").length > 0
		chart = new (cryptowatch.Embed)('coinbase', 'btcusd',
			height: 300
			customColorScheme:
				bg: 'fdeee9'
				text: '545454'
				textStrong: '545454'
				textWeak: '999999'
				short: 'EB3333'
				shortFill: 'EB3333'
				long: '23a06d'
				longFill: '23a06d'
				cta: '000000'
				ctaHighlight: '000000'
				alert: '000000')

		chart.mount '#chart'


		



		

