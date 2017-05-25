(function() {
  if ($) {
    var token = $( 'meta[name="csrf-token"]' ).attr( 'content' );

    $.ajaxSetup( {
      beforeSend: function ( xhr ) {
        xhr.setRequestHeader( 'X-CSRF-Token', token );
      },
      complete: function(xhr, status) {
        if(xhr.status == 401) {
          window.location.href = '/users/sign_in';
        }
      }
    });
  }
})();
