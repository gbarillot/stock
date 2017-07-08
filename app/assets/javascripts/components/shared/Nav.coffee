Nav = Vue.component 'Nav',
  template: '''
    <nav class="navbar navbar-light bg-primary">
      <div class='action-buttons'>
        <a type="button" class="btn-floating btn-large btn-menu" data-toggle="modal" data-target="#showMenu"><i class='fa fa-bars'></i></a>
        <a href="/#/orders/me" type="button" class="btn-floating btn-large btn-orders">{{metrics[2]}}</a>
      </div>
      <div class='action-form'>
        <form class="form-inline pull-xs-right autocomplete">
            <input
             v-model="q"
             v-on:keyup="search"
             v-on:focus="redirect"

             class="form-control col-md-12 col-xs-12"
             type="text"
             placeholder="Référence ou #emplacement"
            />
            <a href='#' class='barcode-scan' v-on:click="startScan()"><i class='fa fa-qrcode'></i></a>

        </form>

      </div>
      <div class='metrics'>
        <span class="metrics">{{metrics[0]}}/{{metrics[1]}}</span>
      </div>
    </nav>
  '''

  data: ->
    store.state

  methods:
    search: ->
      that = this
      delay (->
        $.ajax
          url: '/autocomplete/positions'
          type: 'get'
          data:
            q: that.q
          success: (data) ->
            store.state.metrics = [
              data.metrics.positions
              data.metrics.count
              data.metrics.orders_count
            ]
            store.state.positions = data.positions
      ), 300

    redirect: ->
      window.location.href = '/#/'

    startScan: ->
      $('.modal-body.scanner').removeClass('done')
      $(".modal-body .result").hide()
      $("#modalScanner").modal()
      Qrcode.read().then (out) ->
        $('.modal-body.scanner').addClass('done')
        $(".modal-body .status-#{out.status}").show()
        delay (->
          $("#modalScanner").modal('hide')
        ), 1000
        if out.status == 0
          $.ajax
            url: '/autocomplete/positions'
            type: 'get'
            data:
              q: out.content
            success: (data) ->
              store.state.metrics = [
                data.metrics.positions
                data.metrics.count
                data.metrics.orders_count
              ]
              store.state.positions = data.positions
