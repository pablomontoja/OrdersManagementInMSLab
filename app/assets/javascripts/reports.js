$(document).ready(function(){

if( $( "#i_type option:selected" ).text() == "NON-COMMERCIAL" ) {
    $("#client_institution_id_ps").empty().append($("<option></option>").attr("value", "").text('--- Select institution ---'));
    $("#client_team_id_ps").empty().append($("<option></option>").attr("value", "").text('--- Select Team ---'));
    $("#grant_id").empty().append($("<option></option>").attr("value", "").text('--- Select Grant ---'));

    $("label[for='report_institution']").parent().hide();
    $("label[for='report_team']").parent().hide();
    $("label[for='report_grant']").parent().hide();
}

if( $( "#i_type option:selected" ).text() == "COMMERCIAL" ) {
    $("#client_institution_id_ps").empty().append($("<option></option>").attr("value", "").text('--- Select institution ---'));
    $("#client_team_id_ps").empty().append($("<option></option>").attr("value", "").text('--- Select Team ---'));
    $("#grant_id").empty().append($("<option></option>").attr("value", "").text('--- Select Grant ---')); 

    $("label[for='report_institution']").parent().hide();
    $("label[for='report_team']").parent().hide();
    $("label[for='report_grant']").parent().hide();  
}


if( $( "#i_type option:selected" ).text() == "1 INSTITUTION" ) {

    $("#client_team_id_ps").empty().append($("<option></option>").attr("value", "").text('--- Select Team ---'));
    $("#grant_id").empty().append($("<option></option>").attr("value", "").text('--- Select Grant ---')); 

    $("label[for='report_team']").parent().hide();
    $("label[for='report_grant']").parent().hide();  
}

$.datepicker.setDefaults( $.datepicker.regional[ "pl" ] );

$( "#report_date_from, #report_date_to" ).datepicker({
  dateFormat: "yy-mm-dd"
});


/* walidacja pól */
            $(".new_report, .edit_report").validate({
                rules: {
                  "report[name]": "required",
                  "report[date_from]": "required",
                  "report[date_to]": "required",
                  "report[i_type]": "required",
                  "report[institution]": {
                    required: function(element) {
                    return $( "#i_type option:selected" ).text() == "1 INSTITUTION" || $( "#i_type option:selected" ).text() == "1 GRANT";
                }},
                  "report[team]": {
                    required: function(element) {
                    return $( "#i_type option:selected" ).text() == "1 GRANT";
                }},
                  "report[grant]": {
                    required: function(element) {
                    return $( "#i_type option:selected" ).text() == "1 GRANT";
                }},                                      
                },
                messages: {
                    "report[name]": "Please enter report name",
                    "report[date_from]": "Please enter 'Date from'",
                    "report[date_to]": "Please enter 'Date to'",
                    "report[i_type]": "Please choose report type",
                    "report[institution]": "Please choose institution",
                    "report[team]": "Please choose team",
                    "report[grant]": "Please choose grant",                     
                }
            });



$("#i_type").change(function(){

  var text = $( "#i_type option:selected" ).text();  
  console.log(text);
  if( text == "---  Select type of Report  ---" ) {
    $("label[for='report_institution']").parent().hide();
    $("label[for='report_team']").parent().hide();
    $("label[for='report_grant']").parent().hide();

    $("#client_institution_id_ps").append($("<option></option>").attr("value", "").text('--- Select institution ---'));
    $("#client_team_id_ps").append($("<option></option>").attr("value", "").text('--- Select Team ---'));
    $("#grant_id").append($("<option></option>").attr("value", "").text('--- Select Grant ---'));
  }

  if( text == "NON-COMMERCIAL" ) {
    $("#client_institution_id_ps").empty().append($("<option></option>").attr("value", "").text('--- Select institution ---'));
    $("#client_team_id_ps").empty().append($("<option></option>").attr("value", "").text('--- Select Team ---'));
    $("#grant_id").empty().append($("<option></option>").attr("value", "").text('--- Select Grant ---'));

    $("label[for='report_institution']").parent().hide();
    $("label[for='report_team']").parent().hide();
    $("label[for='report_grant']").parent().hide();

  }

  if( text == "COMMERCIAL" ) {
    $("#client_institution_id_ps").empty().append($("<option></option>").attr("value", "").text('--- Select institution ---'));
    $("#client_team_id_ps").empty().append($("<option></option>").attr("value", "").text('--- Select Team ---'));
    $("#grant_id").empty().append($("<option></option>").attr("value", "").text('--- Select Grant ---')); 

    $("label[for='report_institution']").parent().hide();
    $("label[for='report_team']").parent().hide();
    $("label[for='report_grant']").parent().hide();
   
  }

  if( text == "1 INSTITUTION" ) {

    $("label[for='report_institution']").parent().show();


    var url = '/institutions/get_institutions/';
    if(window.location.href.indexOf("edit") > -1) {
         $("#client_institution_id_ps option").remove();
             $("#client_institution_id_ps").empty().append($("<option></option>").attr("value", "").text('--- Select institution ---'));
        $.getJSON(url, function(data){         
        $.each(data, function(i,obj){
          $("#client_institution_id_ps").append($("<option></option>").attr("value", obj.id).text(obj.name));
          });
      });
    }
    else{
        $("#client_institution_id_ps option:gt(0)").remove();
          $("#client_institution_id_ps").empty().append($("<option></option>").attr("value", "").text('--- Select institution ---'));
        $.getJSON(url, function(data){         
        $.each(data, function(i,obj){
          $("#client_institution_id_ps").append($("<option></option>").attr("value", obj.id).text(obj.name));
          });
    });
    }



    $("label[for='report_team']").parent().hide();
    $("label[for='report_grant']").parent().hide();

            $(".new_report, .edit_report").validate({
                rules: {
                  "report[institution]": {
                    required: function(element) {
                    return $( "#i_type option:selected" ).text() == "1 INSTITUTION";
                }}                           
                },
                messages: {
                    "report[institution]": "Please choose institution" 
                }
            });

    $("#client_team_id_ps").append($("<option></option>").attr("value", "").text('--- Select Team ---'));
    $("#grant_id").append($("<option></option>").attr("value", "").text('--- Select Grant ---'));   
  }


  if( text == "1 GRANT" ) {
    $("label[for='report_institution']").parent().show();
    $("label[for='report_team']").parent().show();
    $("label[for='report_grant']").parent().show();

    var url = '/institutions/get_institutions/';
    if(window.location.href.indexOf("edit") > -1) {
         $("#client_institution_id_ps option").remove();
             $("#client_institution_id_ps").empty().append($("<option></option>").attr("value", "").text('--- Select institution ---'));
        $.getJSON(url, function(data){         
        $.each(data, function(i,obj){
          $("#client_institution_id_ps").append($("<option></option>").attr("value", obj.id).text(obj.name));
          });
      });
    }
    else{
        $("#client_institution_id_ps option:gt(0)").remove();
          $("#client_institution_id_ps").empty().append($("<option></option>").attr("value", "").text('--- Select institution ---'));
        $.getJSON(url, function(data){         
        $.each(data, function(i,obj){
          $("#client_institution_id_ps").append($("<option></option>").attr("value", obj.id).text(obj.name));
          });
    });
    }
     
  }

});



$("#client_team_id_ps").change(function(){

var url2 = '/teams/get_team_grants/' + $("#client_team_id_ps").val();

    if(window.location.href.indexOf("edit") > -1) {
        
        $("#grant_id option").remove();
  			$.getJSON(url2, function(data){
        $("#grant_id").append($("<option></option>").attr("value", "").text('---Select Grant---'));
  	 		$.each(data, function(value,key){
        	$("#grant_id").append($("<option></option>").attr("value", value).text(key));
      		});
  		});	
    }
	else{
  		
  		$("#grant_id option:gt(0)").remove();
  			$.getJSON(url2, function(data){
  			$.each(data, function(value,key){
        	$("#grant_id").append($("<option></option>").attr("value", value).text(key));
      		});
		});  			
	}

});



});