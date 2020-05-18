// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui/widgets/datepicker
//= require jquery-ui/i18n/datepicker-ja
//= require rails-ujs
//= require activestorage
//= require_tree .
$(document).ready(function () {
  // デフォルトで1番目を開くようにする
  // $('ul').eq(0).show();

  //ボタンを押した時、ボタンの色を変える
  colored = false
  $('#menu_switch').click(function() {
    // ボタンの色をつける
    if (colored) {
      $(this).css('background-color','')
      colored = false
    }else {
      $(this).css('background-color','#ffd242')
      colored = true
    }
    // メニュー表示/非表示
    $('.side_menu').animate({
      height : 'toggle'
    }, 'normal')

  });
});
