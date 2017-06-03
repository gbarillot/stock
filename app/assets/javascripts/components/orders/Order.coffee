@Order = Vue.component 'Order',

  template: '''
    <div class="card">
      <div class="card-block">
        <h4 class="card-title"><a :href="'/#/orders/'+order.id">{{order.reference}}</a></h4>
        <hr />
        <p class="card-text">
          <strong>{{order.user_name}}</strong>
          <div class='load'>
            <i class='fa fa-cart-arrow-down'></i>
            <span :class="'w-' + order.countdown_refs"><em>{{order.done}}/{{order.references}}</em></span>
          </div>
          <div class='load'>
            <i class='fa fa-clock-o'></i>
            <span :class="'time w-' + order.countdown_time"><em>{{order.due_at}}</em></span>
          </div>
          <p>
            <a :href="'/#/orders/'+order.id+'/edit'">{{order.count}} Produits</a>
          </p>
        </p>
        <hr />
        <p class="card-footer">
          <a :class="'btn btn-block ' + order.klass" v-on:click="toggleStateModal(this, order.state, order.id)">{{order.state_name}}</a></button>
        </p>
      </div>
    </div>
  '''

  props:
    order:
      type: Object
      default: ->
        {}

  methods:
    toggleStateModal: (e, state, id) ->
      store.state.order.state = state
      store.state.order.id = id
      $('#orderState').modal()
