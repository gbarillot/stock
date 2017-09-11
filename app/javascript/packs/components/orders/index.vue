<template>
    <div>
      <ul class=breadcrumb>
        <li><a href='/#/'><i class='fa fa-home'></i></a></li>
        <li>Commandes</li>
      </ul>
      <v-touch @swipe="travel" class='main-wrapper'>
        <div class='container-fluid'>
          <div class='row'>
            <div class='col-xs-12 col-sm-6 col-md-4 col-lg-3' v-for='order in orders'><Order :order='order'></Order></div>
          </div>
        </div>
      </v-touch>
      <OrderState></OrderState>
    </div>
</template>

<script>

import Order from './_order.vue';
import OrderState from '../modals/order_state.vue';

export default {

  components: {
    Order,
    OrderState
  },

  data: function() {
    return this.$store.state.OrderStore;
  },

  mounted: function() {
    this.$store.dispatch('OrderStore/index')
  }

}

</script>
