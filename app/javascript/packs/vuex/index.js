import Vue from 'vue';
import Vuex from 'vuex';
Vue.use(Vuex);

import PositionStore from './stores/position_store';

const store = new Vuex.Store({
  modules: {
    positions: PositionStore
  }
});

export default store;
