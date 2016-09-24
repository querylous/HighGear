function updateTodaySalesTotals() {
  $('.actual_vlh, .actual_sales').change(function(){
    console.log("changed!")
  })
}

var ready;

ready = function() {
  updateTodaySalesTotals();
}

$(document).ready(ready);
$(document).on('page:load', ready);

