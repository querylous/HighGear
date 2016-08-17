
var ready;
ready = function() {
  function sortOrder(){
    var food_item = ""

    function updateOrder(id, sort_order){
      $.ajax({
        url: '/foods/sort',
        type: 'post',
        data: {'id': id, 'sort_order': sort_order},
        dataType: 'json',
      });
    };

    $('.food_item').each(function (index) {
      $(this).attr("data-sort", index);
      var id = $(this).attr("id");
      var sort_order = $(this).attr("data-sort");
      food_item = "id: " + id +", sort_order: " + sort_order; 
      updateOrder(id, sort_order); 
    }) 
  };

  $('.sortable').sortable();
  $('.sortable').sortable('disable');
  $(document).on('click', '#turn_sort_on', function(){
    $(this).attr('id', 'turn_sort_off');
    $(this).find('button').addClass('btn-primary');
    $('.sortable').sortable('enable',{
      stop: function(event,ui){ sortOrder()  }
    });
  });
  $(document).on('click', '#turn_sort_off', function(){
    $('.sortable').sortable('disable');
    $(this).attr('id', 'turn_sort_on');
    $(this).find('button').removeClass('btn-primary');
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);
