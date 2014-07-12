$(function() {
  'use strict';

  $('.input-daterange').datepicker({format: 'yyyy-mm-dd'});

  function bind_pagination_links() {
    $('.pagination-link').on('click', function(){
      $('#search_page').val($(this).data('page'));
      $('.form-search').trigger("submit");
      return false;
    });
  };

  bind_pagination_links();

  $('.form-search')
     .bind("ajax:success", function(evt, data, status, xhr){
       var list = $('#links');
       list.html(xhr.responseText);
       bind_pagination_links();
     });
});
