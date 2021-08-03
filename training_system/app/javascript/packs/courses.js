import $ from 'jquery';
import 'select2';
import 'select2/dist/css/select2.css';

$(document).ready(function() {
  $('.select').select2({
    allowClear:true,
    placeholder: "select Role",
    closeOnSelect: true
  });

  $( ".js-start-course" ).click(function() {
    var id = $(this).data("id")
    $.ajax({
      type: 'POST',
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      url: '/trainer/courses/'+id+'/start_course',
      data: ""
    }).done(function(response){
        console.log(response)
    });
  });
});
