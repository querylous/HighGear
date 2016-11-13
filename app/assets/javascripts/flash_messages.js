var ready;
ready = function() {
  if ( $('#flash-message').length ) {
    $('#flash-message' ).delay( 3000 ).fadeOut( 'slow' )
  }
}

$(document).ready(ready);
$(document).on('page:load', ready);


