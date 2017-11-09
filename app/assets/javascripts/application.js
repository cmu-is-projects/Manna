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
//= require jquery_nested_form


//= require materialize-sprockets
//= require_tree .

//= require filterrific/filterrific-jquery

$( document ).ready(function(){
	// $(".button-collapse").sideNav();
	$('select').material_select();
    $('.button-collapse').sideNav({
        closeOnClick: true
    });
});

jQuery.expr[':'].contains = function(a, i, m) {
  return jQuery(a).text().toUpperCase()
      .indexOf(m[3].toUpperCase()) >= 0;
};

$(document).ready(function(){
    $(".queue-search").keyup(function(){
        var query = $(".queue-search").val();
        $('.timeline-item').hide();
        // console.log($('.timeline-title:contains('+query+')'));
        if ($('.timeline-title:contains('+query+')').length > 0){
            // console.log($('.timeline-title:contains('+query+')').closest('.timeline-item'));
            $('.timeline-title:contains('+query+')').closest('.timeline-item').show();
                // ('.timeline-item:contains('+query+')').show();
        }
    });
});
