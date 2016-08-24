$(document).ready(function() {
	$(".optional-toggle").on("click", function() {
		$(this).hide();
		$(this).parent().parent().find(".optional-field").show();
	}); 

	$("#add-another-founder").on("click", function() {
		$(this).before("<input type='text' name='founders[]'' id='founders'>");
	});

	$(".remove-founder-field").on("click", function() {
		$(this).closest('.founder-field').remove();
	});

	$("#add-another-exchange").on("click", function() {
		parent_id = $(this).parent().attr('id');
		parent_id_length = parent_id.length;
		repo_number = parseInt(parent_id.substring(parent_id_length - 1,parent_id_length));
		repo_plus_one = repo_number + 1;
		parent_html = $(this).parent().parent().clone(true);
		parent_html.first().find("input").attr('name', 'coin[exchanges_attributes][' + repo_plus_one + '][url]');
		parent_html.first().find("input").attr('value', '');
		parent_html_to_insert = '<div class="row grouped-row grouped-row-last">' + parent_html.html() + '</div>'
		prev_parent_html = $(this).parent().parent().prev().clone(true);
		prev_parent_html.first().find("input").attr('name', 'coin[exchanges_attributes][' + repo_plus_one + '][name]');
		prev_parent_html.first().find("input").attr('value', '');
		prev_parent_html_to_insert = '<div class="row grouped-row grouped-row-first">' + prev_parent_html.html() + '</div>'
		$(this).hide();
		$(this).parent().parent().after(prev_parent_html_to_insert + parent_html_to_insert);
	});

	$("#add-another-founder").on("click", function() {
		parent_id = $(this).parent().attr('id');
		parent_id_length = parent_id.length;
		repo_number = parseInt(parent_id.substring(parent_id_length - 1,parent_id_length));
		repo_plus_one = repo_number + 1;
		parent_html = $(this).parent().parent().clone(true);
		parent_html.first().find("input").attr('name', 'coin[whitepapers_attributes][' + repo_plus_one + '][url]');
		parent_html.first().find("input").attr('value', '');
		parent_html_to_insert = '<div class="row grouped-row grouped-row-last">' + parent_html.html() + '</div>'
		prev_parent_html = $(this).parent().parent().prev().clone(true);
		prev_parent_html.first().find("input").attr('name', 'coin[whitepapers_attributes][' + repo_plus_one + '][name]');
		prev_parent_html.first().find("input").attr('value', '');
		prev_parent_html_to_insert = '<div class="row grouped-row grouped-row-first">' + prev_parent_html.html() + '</div>'
		$(this).hide();
		$(this).parent().parent().after(prev_parent_html_to_insert + parent_html_to_insert);
	});

	$("#add-another-repo").on("click", function() {
		parent_id = $(this).parent().attr('id');
		parent_id_length = parent_id.length;
		repo_number = parseInt(parent_id.substring(parent_id_length - 1,parent_id_length));
		repo_plus_one = repo_number + 1;
		parent_html = $(this).parent().parent().clone(true);
		parent_html.first().find("input").attr('name', 'coin[repositories_attributes][' + repo_plus_one + '][url]');
		parent_html.first().find("input").attr('value', '');
		parent_html_to_insert = '<div class="row grouped-row grouped-row-last">' + parent_html.html() + '</div>'
		prev_parent_html = $(this).parent().parent().prev().clone(true);
		prev_parent_html.first().find("input").attr('name', 'coin[repositories_attributes][' + repo_plus_one + '][name]');
		prev_parent_html.first().find("input").attr('value', '');
		prev_parent_html_to_insert = '<div class="row grouped-row grouped-row-first">' + prev_parent_html.html() + '</div>'
		$(this).hide();
		$(this).parent().parent().after(prev_parent_html_to_insert + parent_html_to_insert);
	});

	$("a.remove-repository-fields").on("click", function() {
		$(this).parent().parent().find("input:hidden").val(true);
		alert($(this).parent().parent().find("input:hidden").val());
		$(this).parent().find("input").hide();
		$(this).parent().parent().find("label").hide();
		$(this).parent().parent().prev().find("input").hide();
		$(this).parent().parent().prev().find("label").hide();
		$(this).hide();
	});
			
});
	