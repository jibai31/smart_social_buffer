$(function() {
  $('.msg-text').each(function() {
    autoLink($(this));
  });

  $('.contents').on('input', '.msg-text-input', function() {
    var msgInput = $(this),
        charsCounter = $('.msg-chars-left'),
        submitBtn = msgInput.parents('.new_message').find('.add-msg'),
        tweet = msgInput.val(),
        charsLeft = 140 - twttr.txt.getTweetLength(tweet);

    charsCounter.text(charsLeft);

    if (charsLeft < 0) {
      charsCounter.addClass('overflow');
      submitBtn.attr("disabled", "disabled");
    }
    else {
      charsCounter.removeClass('overflow');
      submitBtn.removeAttr("disabled");
    }
  });

  $('.contents').on('click', '.edit_message .hide-btn', function(e) {
    e.preventDefault();

    var item = $(this).closest('.message');
    var backup = item.find('.msg-backup');
    item.find('.msg-text').html(backup.html());
    backup.remove();
    item.find('.msg-actions').removeClass('hide');
    item.closest('.content').find('.show-msg-form').removeClass('hide');
  });
});

function autoLink(message) {
  message.html(twttr.txt.autoLink(message.text()));
}

(function($){
  $.fn.autoLink = function(){
    autoLink(this.find('.msg-text'));
  }
})(jQuery);
