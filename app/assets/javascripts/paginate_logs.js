$(document).ready(function() {
  prev_scroll_top = 0;
  body_height = $('body').height();
  if (body_height > 1200) {
    $('.action-links').css('bottom',body_height - (body_height - 80));
  }
  $(window).scroll(function() {
    if(window.pagination_loading) {
      return;
    }
    scroll_height = $('body').prop('scrollHeight');
    scroll_top = $('body').scrollTop();
    body_height = $('body').height();
    remaining = scroll_height - (scroll_top + body_height);
    if (remaining < 40) {
      curr_bottom = $('.action-links').css('bottom');
      curr_bottom = 40 + (40 - remaining);
      $('.action-links').css('bottom', curr_bottom);
    } else {
      $('.action-links').css('bottom',15);
    };
    if ($('.pagination').length) {
      var url = $('.pagination a[rel=next]').attr('href');
      if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 100) {
        window.pagination_loading = true;
        $('.loading-more').show();
        $.getScript(url).always(function() {
          window.pagination_loading = false;
        });
      }
    }
  });
});
