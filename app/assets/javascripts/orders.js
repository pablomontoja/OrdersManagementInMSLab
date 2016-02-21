$(document).ready(function(){

 
  if(window.location.href == "http://213.135.38.172:3001/") {
    console.log(window.location.href)
    setInterval('window.location.reload()', 900000)
  }

/* ponizej validacja formularza */
            $(".new_order, .edit_order").validate({
                messages: {
                    "order[sample_name]": "Please enter sample name",
                    client_name: "Please enter client name",
                    "order[grant_id]": "Please choose grant",
                    "order[measurements_attributes][0][technique_id]": "Please choose technique",
                    "order[measurements_attributes][1][technique_id]": "Please choose technique",
                    "order[measurements_attributes][2][technique_id]": "Please choose technique",
                    "order[measurements_attributes][3][technique_id]": "Please choose technique",
                }
            });





/*ponizej fragment odpowiedzialny za czyszczenie defaultowej wartosci multiplier*/
if(window.location.href.indexOf("edit") > -1) {
    var wart = $("div.bg-info:last").find("input").val("");
  }




$.datepicker.setDefaults( $.datepicker.regional[ "pl" ] );

$( "#order_order_date" ).datepicker({
  dateFormat: "yy-mm-dd"
});


if(window.location.href.indexOf("edit") > -1){
$("#techniki .panel").last().hide();
}

$("#new_measurement").click( function()
        {
            if($("#new_measurement").text()=='Add new measurement') {
                $(".panel").last().show();
                $("#new_measurement").text('Hide new measurement');
            }
            else{
                $(".panel").last().hide();
                $("#new_measurement").text('Add new measurement');   
            }
        }
             );


$("#client_name").autocomplete({
    source: "/orders/autocomplete_client_name",
    select: function (event, ui) {
        $("#clientID").val(ui.item.id);
          var url = '/orders/get_grant_options/' + $("#clientID").val();

    if(window.location.href.indexOf("edit") > -1) {
         $("#order_grant_id option").remove();
        $.getJSON(url, function(data){
        $.each(data, function(value,key){
          $("#order_grant_id").append($("<option></option>").attr("value", value).text(key));
          });
      });
    }
  else{
        $("#order_grant_id option:gt(0)").remove();
        $.getJSON(url, function(data){
        $.each(data, function(value,key){
          $("#order_grant_id").append($("<option></option>").attr("value", value).text(key));
          });
    });
  }
    }

  });


$(".done, .start, .end").click(function(event){
   $("#confirm").data('caller', this.id);


$.ajax({
                 url: "/orders/get_alertcontent", // Route to the Script Controller method
                type: "GET",
            dataType: "script",
                data: { status: this.id }, // This goes to Controller in params hash, i.e. params[:status]
            complete: function() {}
      });

$('#alertmodal').on('hidden.bs.modal', function (e) {
  $( "#alertcontent" ).empty();

});

});



$("#confirm").click(function(){
  var ident = $(this).data('caller');
  var rowid = ident.split("_");
  console.log(rowid)
  console.log(ident)

  /* zmiana statusu */
  $.ajax({
                 url: "/orders/change_status", // Route to the Script Controller method
                type: "POST",
            dataType: "json",
                data: { status: ident }, // This goes to Controller in params hash, i.e. params[:status]
            complete: function() {},
             success: function(data, textStatus, xhr) {
                  $("#status_" + rowid[1]).text(data.new_status);
                        
                        if(data.new_final_price == null){
                        $("#final_price_" + rowid[1]).text("");
                  }
                        else{
                        $("#final_price_" + rowid[1]).text(data.new_final_price);
                        }

                        if(data.order_end_date == null){
                        $("#order_end_date_" + rowid[1]).text("");
                        }
                        else{
                        $("#order_end_date_" + rowid[1]).text(data.order_end_date);
                        }

                        if(ident=="done_"+rowid[1]) {                     
                    wybor = "#" + ident + " span:first";                    
              $( "#glyph_" + rowid[1] + " span" ).show();
              $( wybor ).hide();              
                  }
                  if(ident=="start_"+rowid[1]) {                    
                            wybor = "#" + ident + " span:first";                            
                            $( "#glyph_" + rowid[1] + " span" ).show();
                            $( wybor ).hide();
                  }
                        if(ident=="end_"+rowid[1]) {                          
                            wybor = "#" + ident + " span:first";                            
                            $( "#glyph_" + rowid[1] + " span" ).hide();                            
                        }
                      $("#alertmodal").modal("hide");                   
                      },
               error: function() {
                        alert("Server Error")
                      }
    });
/* zmiana statusu koniec */

});










});