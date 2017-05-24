import Vue from 'vue/dist/vue.esm'
import VueRouter from 'vue-router'

const Home = { template: '<div>Homepage</div>' }
const Foo = { template: '<div>foo</div>' }
const Bar = { template: '<div>bar</div>' }


const routes = [
  { path: '/aa', component: Home },
  { path: '/foo', component: Foo },
  { path: '/bar', component: Bar }
]


const router = new VueRouter({
  routes
})

s
const app = new Vue({
  router
}).$mount('#app')
