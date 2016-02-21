$(document).ready(function(){

$.datepicker.setDefaults( $.datepicker.regional[ "pl" ] );

$( "#measurement_measurement_at" ).datepicker({
  dateFormat: "yy-mm-dd"
});

$("#technique_name_in_measurement").autocomplete({
    source: "/measurements/autocomplete_technique_name",
    select: function (event, ui) {
        $("#techniqueID").val(ui.item.id);
    }
  });

});