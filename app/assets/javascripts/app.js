$(function() {
  'use strict';

  $('.input-daterange').datepicker({format: 'yyyy-mm-dd'});

  $('.form-search')
     .bind("ajax:success", function(evt, data, status, xhr){
       var list = $('#links');
       list.html(xhr.responseText);
     })
});
