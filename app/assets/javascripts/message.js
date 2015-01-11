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
});

function autoLink(message) {
  message.html(twttr.txt.autoLink(message.text()));
}

(function($){
  $.fn.autoLink = function(){
    autoLink(this.find('.msg-text'));
  }
})(jQuery);
