import $ from 'jquery';
import 'select2';
import 'select2/dist/css/select2.css';

$(document).ready(function() {
  $('.select').select2({
    allowClear:true,
    placeholder: "select Role",
    closeOnSelect: true
  });
});
