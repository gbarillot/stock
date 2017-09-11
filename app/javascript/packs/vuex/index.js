import Vue from 'vue';
import Vuex from 'vuex';
Vue.use(Vuex);

import PositionStore from './stores/position_store';
import OrderStore from './stores/order_store';
import UserStore from './stores/user_store';
import LocationStore from './stores/location_store';
import BasketStore from './stores/basket_store';

const store = new Vuex.Store({
  modules: {
    PositionStore,
    OrderStore,
    UserStore,
    LocationStore,
    BasketStore,
  }
});

export default store;
