$ ->
  token = $('meta[name="csrf-token"]').attr('content')
  $.ajaxSetup
    beforeSend: (xhr) ->
      xhr.setRequestHeader 'X-CSRF-Token', token
      return
    complete: (xhr, status) ->
      if xhr.status == 401
        window.location.href = '/users/sign_in'
