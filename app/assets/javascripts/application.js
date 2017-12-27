//= require jquery
//= require rails-ujs
//= require twitter/bootstrap
//= require moment
//= require daterangepicker
//= require_tree .

$(document).ready(function() {
  $('input[class="daterange"]').daterangepicker({
    locale: {
      format: 'YYYY-MM-DD'
    }
  });
});
