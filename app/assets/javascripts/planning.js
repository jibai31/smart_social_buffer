$(function($){
  $('.js-preview').click(function(){
    $(this).hide();
    $(this).parent().find('.js-plan').css("display", "block");
  });
});
