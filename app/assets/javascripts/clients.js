$(document).ready(function(){

$("#client_institution_id_ps").change(function(){  
  
  var url = '/clients/get_team_options/' + $("#client_institution_id_ps").val();
  var url2 = '/institutions/get_clients/' + $("#client_institution_id_ps").val();

    if(window.location.href.indexOf("edit") > -1) {
         $("#client_team_id_ps option").remove();
         $("#grant_id option").remove();

  			$.getJSON(url, function(data){
        $("#client_team_id_ps").append($("<option></option>").attr("value", "").text('---Wybierz zespół---'));
        $("#grant_id").append($("<option></option>").attr("value", "").text('---Wybierz grant---'));        
  	 		$.each(data, function(value,key){
        	$("#client_team_id_ps").append($("<option></option>").attr("value", value).text(key));
      		});
  		});

        $.getJSON(url2, function(data){
          $("#client_id").append($("<option></option>").attr("value", "").text('---Wybierz klienta---'));
        $.each(data, function(value,key){
          $("#client_id").append($("<option></option>").attr("value", value).text(key));
          });
      });

    }
	else{
  			$("#client_team_id_ps option:gt(0)").remove();
        $("#grant_id option:gt(0)").remove();

  			$.getJSON(url, function(data){
  			$.each(data, function(value,key){
        	$("#client_team_id_ps").append($("<option></option>").attr("value", value).text(key));
      		});
		});

        $.getJSON(url2, function(data){
        $.each(data, function(value,key){
          $("#client_id").append($("<option></option>").attr("value", value).text(key));
          });
      });

	}
});
});
