const routes = [
  { path: '/', component: Home },
  { path: '/products/:id', component: ProductDetail },
  { path: '/positions', component: Positions }
]

const router = new VueRouter({
  routes
})
