$(document).ready(function () {
  $(".add-task").on("click", function () {
    addAddressField();
  });
  $(".remove-task").on("click", function () {
    var numOfForms = $(".fields_form_task").length;
    if (numOfForms >= 1) {
      $(".form-fields_for_new").find(".fields_form_task").first().remove();
    }
  });
});

function addAddressField() {
  var length = $(".name-count").length;
  var div = document.createElement("div");
  var label_task = document.createElement("label");
  var label_name = document.createElement("label");
  var input_name = document.createElement("input");
  var label_description = document.createElement("label");
  var input_description = document.createElement("input");
  var label_duration = document.createElement("label");
  var input_duration = document.createElement("input");

  div.className = "fields_form_task";

  label_task.htmlFor = "subject_tasks_attributes_" + length + "_task";
  label_task.textContent = "Task";
  label_task.className = "label-task";

  label_name.htmlFor = "subject_tasks_attributes_" + length + "_name_task";
  label_name.textContent = "Name Task";
  input_name.type = "text";
  input_name.name = "subject[tasks_attributes][" + length + "][name]";
  input_name.className = "form-control name-count";
  input_name.id = "subject_tasks_attributes_" + length + "_name";

  label_description.htmlFor =
    "subject_tasks_attributes_" + length + "_description_task";
  label_description.textContent = "Description Task";
  input_description.type = "text";
  input_description.name =
    "subject[tasks_attributes][" + length + "][description]";
  input_description.className = "form-control";
  input_description.id = "subject_tasks_attributes_" + length + "_description";

  label_duration.htmlFor =
    "subject_tasks_attributes_" + length + "_duration_task";
  label_duration.textContent = "Duration Task";
  input_duration.type = "number";
  input_duration.name = "subject[tasks_attributes][" + length + "][duration]";
  input_duration.className = "form-control";
  input_duration.id = "subject_tasks_attributes_" + length + "_duration";

  div.appendChild(label_task);

  div.appendChild(label_name);
  div.appendChild(input_name);

  div.appendChild(label_description);
  div.appendChild(input_description);

  div.appendChild(label_duration);
  div.appendChild(input_duration);

  $(".form-fields_for_new").append(div);
}
