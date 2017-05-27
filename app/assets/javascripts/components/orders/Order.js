const Order = Vue.component('Order', {
  template: `
    <div class="card">
      <div class="card-block">
        <h4 class="card-title"><a :href="'/#/orders/'+order.id">{{order.reference}}</a></h4>
        <hr />
        <p class="card-text">
          <p>
            <strong>{{order.user_name}}</strong>
            <br />
            {{order.due_at}}
            <br />
            {{order.references}} Réf., {{order.count}} Produits
          </p>
        </p>
        <hr />
        <p class="card-footer">
          <a :class="'btn btn-block ' + order.klass" v-on:click="toggleStateModal(this, order.state, order.id)">{{order.state_name}}</a></button>
        </p>
      </div>
    </div>
  `,

  props: {
    order: {
      type: Object,
      default: function() {
        return {}
      }
    }
  },

  methods : {
    toggleStateModal: function(e, state, id) {
       store.state.current_order.state = state;
       store.state.current_order.id = id;

      $('#orderState').modal()
    }
  }

})
