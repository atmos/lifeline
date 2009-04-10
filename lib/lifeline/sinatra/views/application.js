$(function() {
  function time_ago_in_words(timestamp_id) {
    var now = (new Date).getTime();
    var timestamp = timestamp_id.replace(/created_at_\d+_/, '');
    var result = null;
    if(timestamp.match(/\d+/)) {
      var dt = Math.round(parseInt((now / 1000) - timestamp)/60);
      if(dt == 0) { result = "less than a minute"; }
      else if(dt == 1) { result = "1 minute"; }
      else if(dt >= 2 && dt <= 45) { result = dt + ' minutes'; }
      else if(dt >= 46 && dt <= 90) { result = 'about 1 hour'; }
      else if(dt >= 90 && dt <= 1440) { result = 'about ' + Math.round(parseFloat(dt)/60.0) + ' hours'; }
      else if(dt >= 1440 && dt <= 2880) { result = '1 day'; }
      else { result = Math.round(parseInt(dt)/1440) + ' days'; }
    }
    return(result);
  }
  function fix_tweetstamps() {
    $('ol li span.entry-meta').each(function() {
      var result = time_ago_in_words(this.id);
      var content = $(this).html().replace(/.*? ago/, result+ ' ago');
      $(this).html(content);
    });
  }
  function refresh_page(since_id) {
    $.get("/refresh/"+since_id, function(html) {
      $('ol.statuses').prepend(html)
      $(html).show('Explode',{},500);
    });
    fix_tweetstamps();
    var list_length = $('ol#timeline li').length;

    $('ol#timeline li').slice(45, list_length).remove();
  };

  $('ol.statuses').everyTime(50000, function(i) {
    refresh_page($('ol.statuses li')[0]['id'].replace('status_', ''));
  })

  jQuery(document).ready(function($) {
    fix_tweetstamps();
    var list_length = $('ol#timeline li').length;
    $('ol#timeline li').slice(45, list_length).remove();
  });
});
