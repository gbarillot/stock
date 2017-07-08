import Vue from 'vue';
import store from './vuex';
import router from './router';

const app = new Vue({
  router,
  store
}).$mount('#app')
