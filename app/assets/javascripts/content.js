$(function() {
  $('.contents').on('click', '.edit_content .hide-btn', function(e) {
    e.preventDefault();

    var item = $(this).closest('.content');
    var backup = item.find('.backup');
    item.find('.content-header').html(backup.html());
    backup.remove();
  });
});
