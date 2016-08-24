$(document).ready(function() {
	
	if ($('p.alert').text() == '') {
		$('p.alert').hide();
	}
	if ($('p.notice').text() == '') {
		$('p.notice').hide();
	}
	
	text = $('#header-link-account').find('span').text();
	alert(text);
	img = $('.account').find('img')
	$('#header-link-account').mouseover(function() {
		$(this).find("span").remove();
		$(this).append('<a href="<span class="glyphicon glyphicon-cog" aria-hidden="true"></span><span class="glyphicon glyphicon-off" aria-hidden="true"></span> ');
	});
		
	$('#header-link-account').mouseout(function() {
		$(this).find("span").remove();
		$(this).append('<span class="username">' + text + '</span>');
	});

});
	
