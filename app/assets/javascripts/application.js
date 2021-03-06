// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui/datepicker
//= require jquery-ui/accordion

//= require underscore
//= require moment

//= require_self
//= require_tree .

window.App || (window.App = {});

App.init = function() {
  if($('#visits')) {
    App.Visits.init();
  }

  $('.facebook-share').click(function() {
    FB.ui({
      method: 'share',
      href: 'http://www.berniebnb.com',
      caption: 'feel the bern',
      name: 'I just signed up!',
      description: 'Get involved with the Bernie Sanders campaign by offering ' +
                   'volunteers out on the campaign trail a place to stay. Sign up today!'
    }); // second parameter is callback function
  });
};

$(document).ready(function() {
  return App.init();
});
