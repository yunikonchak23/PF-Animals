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

//= require jquery3
//= require popper
//= require bootstrap-sprockets

//= require jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
/*global $*/

// ハンバーガーメニュー
$(document).on('turbolinks:load', function() {
    $('.hamburger').click(function() {
        $(this).toggleClass('active');
        if ($(this).hasClass('active')) {
            $('.nav-box1').addClass('active');
        } else {
            $('.nav-box1').removeClass('active');
        }
    });
});

// フラッシュメッセージ
$(function(){
  $('.alert-info').fadeOut(4000);  //４秒かけて消えていく
});

// トップに戻るリンク
$(document).on('turbolinks:load', function() {
  $('#page-top a').on('click',function(event){
    $('body, html').animate({
      scrollTop:0
    }, 800);
    event.preventDefault();
  });
});

// aboutページ
$(function () {
  $(window).scroll(function () {
    $('.animationTarget').each(function () {
      //ターゲットの位置を取得
      const targetElement = $(this).offset().top;
      //スクロール量を取得
      const scroll = $(window).scrollTop();
      //ウィンドウの高さを取得
      const windowHeight = $(window).height();
      //ターゲットまでスクロールするとフェードインする
      if (scroll - 250 > targetElement - windowHeight) {
        //クラスを付与
        $(this).addClass('view');
      }
    });
  });
});