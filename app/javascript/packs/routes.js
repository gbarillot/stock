import Vue from 'vue';
import VueRouter from 'vue-router';
Vue.use(VueRouter);

import HomeIndex from './components/home/index.vue';
import OrderIndex from './components/orders/index.vue';
import OrderShow from './components/orders/show.vue';
import OrderNew from './components/orders/new.vue';
import BasketShow from './components/baskets/show.vue';
import OrdersEdit from './components/orders/edit.vue';
import StatsIndex from './components/stats/index.vue';
import UsersIndex from './components/users/index.vue';
import LocationShow from './components/locations/show.vue';
import ProductShow from './components/products/show.vue';
import PositionShow from './components/products/show.vue';

const router = new VueRouter({
  routes: [
    { path: '/', component: HomeIndex },
    { path: '/orders', component: OrderIndex },
    { path: '/orders/new', component: OrderNew },
    { path: '/orders/me', component: OrderShow },
    { path: '/orders/:id/edit', component: OrdersEdit },
    { path: '/baskets/:id', component: BasketShow },
    { path: '/stats', component: StatsIndex },
    { path: '/users', component: UsersIndex },
    { path: '/locations/:slug', component: LocationShow },
    { path: '/products/:id', component: ProductShow },
    { path: '/positions/:slug', component: PositionShow }
  ]
});

export default router;
