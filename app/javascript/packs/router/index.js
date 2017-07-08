import Vue from 'vue';
import VueRouter from 'vue-router';
Vue.use(VueRouter);

import HomeIndex from '../components/home/index.vue';

const router = new VueRouter({
  mode: 'history',
  base: __dirname,
  routes: [
    {path: '/', component: HomeIndex}
  ]
});

export default router;
