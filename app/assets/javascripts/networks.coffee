# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ -> 
	$("#add-another-founder").on "click", ->
		$(this).before "<input type='text' name='founders[]'' id='founders'>"
	$whitepaperCount = 0
	$("#add-another-whitepaper").on "click", ->
		$whitepaperCount += 1
		$("#add-another-whitepaper").first().hide()
		$toAppend1 = $(".whitepaper1").html()
		$toAppend2 = $(".whitepaper2").html()
		$(".whitepaper2").after "<div class='row whitepaper1'><div class='col-md-4 label'><label class='form-label' for='whitepapers[" + $whitepaperCount + "]title'>Whitepaper Title</label></div><div class='col-md-8'><input type='text' name='whitepapers[" + $whitepaperCount + "][title]' id='whitepaper_0_title' value='' class='form-input'></div></div><div class='row whitepaper2'><div class='col-md-4 label'><label class='form-label' for='whitepapers[" + $whitepaperCount + "]url'>Whitepaper URL</label></div><div class='col-md-8'><input type='text' name='whitepapers[" + $whitepaperCount + "][url]' id='whitepaper_0_url' value='' class='form-input'><a class='add-another' id='add-another-whitepaper'>Add another whitepaper</a></div></div>"


		