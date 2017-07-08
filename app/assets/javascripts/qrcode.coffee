class @Qrcode

  @read = ->
    dfd = new $.Deferred();

    scanner = new (Instascan.Scanner)(
      scanPeriod: 5
      video: document.getElementById('qr-preview')
    )

    Instascan.Camera.getCameras().then((cameras) ->
      if cameras.length > 0
        scanner.start cameras[0]
      else
        scanner.stop()
        dfd.resolve({status: 1, content: ''})
    ).catch (e) ->
      scanner.stop()
      dfd.resolve({status: 2, content: ''})

    scanner.addListener 'scan', (content) ->
      scanner.stop()
      dfd.resolve({status: 0, content: content})

    delay (->
      scanner.stop()
      dfd.resolve({status: 3, content: ''})
    ), 10000

    return dfd.promise()
