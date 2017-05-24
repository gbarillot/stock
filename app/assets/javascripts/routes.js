const routes = [
  { path: '/', component: Home },
  { path: '/positions', component: Positions }
]

const router = new VueRouter({
  routes
})

const app = new Vue({
  router: router
}).$mount('#app')
