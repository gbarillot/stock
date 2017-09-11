import helpers from './helpers';
import Vue from 'vue';
import VueI18n from 'vue-i18n';
import store from './vuex';
import router from './routes.js';
import VueTouch from 'vue-touch';
import Storyteller from './mixins/storyteller.js';

Vue.use(VueI18n);
Vue.mixin(Storyteller);
Vue.use(VueTouch);

const i18n = new VueI18n({
  locale: 'en',
  messages
})

let token = $('meta[name="csrf-token"]').attr('content');

$.ajaxSetup({
  beforeSend: function(xhr) {
    xhr.setRequestHeader('X-CSRF-Token', token);
  },
  complete: function(xhr, status) {
    if (xhr.status === 401) {
      return window.location.href = '/users/sign_in';
    }
  }
})

const app = new Vue({
  i18n,
  router,
  store
}).$mount('#app')
