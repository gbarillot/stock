const routes = [
  { path: '/', component: Home },
  { path: '/products', component: Products }
]

const router = new VueRouter({
  routes
})

const app = new Vue({
  router: router
}).$mount('#app')
