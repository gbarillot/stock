@ModalOrderState = Vue.component 'ModalOrderState',

  template: '''
    <div aria-hidden='true' aria-labelledby='myModalLabel' class='modal' id='orderState' role='dialog' tabindex='-1'>
      <div class='modal-dialog' role='document'>
        <div class='modal-content'>
          <div class='modal-header'>
            <button aria-label='Close' class='close' data-dismiss='modal' type='button'>
              <span aria-hidden='true'>×</span>
            </button>
            <h4 class='modal-title w-100' style='color: #000'>Status</h4>
          </div>

          <div class='modal-body'>
            <ul class='editor'>
              <li>
                <p style='padding-left: 20px'><input name='state' type='radio' v-on:click="setState(this, 'busy', order.id)" :checked="order.state == 'busy'"><span style='padding-left: 20px'>En préparation</span></p>
              </li>
              <li class='separator'></li>
              <li>
                <p style='padding-left: 20px'><input name='state' type='radio' v-on:click="setState(this, 'done', order.id)" :checked="order.state == 'done'"><span style='padding-left: 20px'>Prête</span></p>
              </li>
              <li class='separator'></li>
              <li>
                <p style='padding-left: 20px'><input name='state' type='radio' v-on:click="setState(this, 'delivered', order.id)" :checked="order.state == 'delivered'"><span style='padding-left: 20px'>Livrée</span></p>
              </li>
            </ul>
          </div>

        </div>
      </div>
    </div>
  '''

  data: ->
    store.state

  methods:
    setState: (e, state, id) ->
      that = this
      $.ajax
        url: '/orders/' + id
        method: 'PUT'
        data: order: state: state
        success: (data) ->
          updated_orders = store.state.orders
          i = 0
          while i < updated_orders.length
            if data.orders[0].id == updated_orders[i].id
              updated_orders[i] = data.orders[0]
            i++
          store.state.orders = []
          store.state.orders = updated_orders
          $('#orderState').modal 'hide'
