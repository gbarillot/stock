const ModalOrderState = Vue.component('ModalOrderState', {
  template: `
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
                <p style='padding-left: 20px'><input name='state' type='radio' v-on:click="setState(this, 'busy', current_order.id)" :checked="current_order.state == 'busy'"><span style='padding-left: 20px'>En préparation</span></p>
              </li>
              <li class='separator'></li>
              <li>
                <p style='padding-left: 20px'><input name='state' type='radio' v-on:click="setState(this, 'done', current_order.id)" :checked="current_order.state == 'done'"><span style='padding-left: 20px'>Prête</span></p>
              </li>
              <li class='separator'></li>
              <li>
                <p style='padding-left: 20px'><input name='state' type='radio' v-on:click="setState(this, 'delivered', current_order.id)" :checked="current_order.state == 'delivered'"><span style='padding-left: 20px'>Livrée</span></p>
              </li>
            </ul>
          </div>

        </div>
      </div>
    </div>
  `,

  data: function(){
    return store.state
  },

  methods: {
    setState: function(e, state, id) {
      let that = this;
      $.ajax({
        url: ('/orders/' + id),
        method: 'PUT',
        data: {
          order: {
            state: state
          }
        },
        success: function(data) {
          let updated_orders = store.state.orders
          for(var i = 0; i < updated_orders.length; i++){
            if(data.orders[0].id === updated_orders[i].id){
              updated_orders[i] = data.orders[0]
            }
          }
          store.state.orders = []
          store.state.orders = updated_orders;
          $('#orderState').modal('hide');
        }
      });
    }
  }
})
