$(function() {
  $(document).on('click', '.hide-btn', function(e) {
    e.preventDefault();

    var btn = $(this);
    var target = btn.parents("." + btn.data('target'));
    var elementToShow = target.parent().find("." + btn.data('show'));
    target.remove();
    elementToShow.show();
  });
});
