import $ from 'jquery';
import 'select2';
import 'select2/dist/css/select2.css';

$(document).ready(function() {
  $('#select2-subject').select2({
    allowClear:true,
    placeholder: "select Role",
    closeOnSelect: true
  });
  $('#select2-user').select2({
    allowClear:true,
    placeholder: "select Role",
    closeOnSelect: true
  });
  $('#assign-trainee-select').select2({
    allowClear:true,
    placeholder: "select Role",
    closeOnSelect: true,
  });
  $('#remove-trainee-select').select2({
    allowClear:true,
    placeholder: "select Role",
    closeOnSelect: true
  });
});
