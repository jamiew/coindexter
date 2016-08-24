$(document).ready(function() {
	
	if ($('p.alert').text() == '') {
		$('p.alert').hide();
	}
	if ($('p.notice').text() == '') {
		$('p.notice').hide();
	}
	
	text = $('#header-link-account').find('p').text();
	$('#header-link-account').hover(
		function() {
			$(this).find("a.user-activity > p").hide();
			$(this).find("a.header-link-account-glyphicon").show();
		}, function() {
			$(this).find("a.user-activity > p").show();
			$(this).find("a.header-link-account-glyphicon").hide();
		});
});
	
