// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function() {
    // materialize side nav
    $(".button-collapse").sideNav();
    // materialize select drop down
    $('select').material_select();
    // open profile modal
    $('.add-profile').on('click',function(){
      $('#add-profile-modal').show();
      $('body').addClass('no-scroll');
    });

    // close modal
    $('.modal-head a').on('click', function(){
      $('.modal-container').hide();
      $('body').removeClass('no-scroll');
    });

    $('.hamburger').on('click', function() {
      const isOpen = $('.hamburger').hasClass('open')
      if(!isOpen)
        $('body, .hamburger, .side-navi-fade,.side-navi')
        .addClass('open');
      else {
        $('body, .hamburger, .side-navi-fade,.side-navi')
        .removeClass('open')
      }
    });
});
