Nav = Vue.component('Nav',
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
             placeholder="Réf, #emplacement, @commande"
            />
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
        $.get('/autocomplete/positions', q: that.q).done (data) ->
          store.state.metrics = [
            data.metrics.positions
            data.metrics.count
            data.metrics.orders_count
          ]
          store.state.positions = data.positions
          return
        return
      ), 300
      return
    redirect: ->
      window.location.href = '/#/'
      return
)
