$(function() {
  $('.msg-text-input').on('input', function() {
    var msgInput = $(this),
        charsCounter = $('.msg-chars-left'),
        submitBtn = msgInput.parents('.new_message').find('.add-msg-btn'),
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
