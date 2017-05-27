const routes = [
  { path: '/', component: HomeIndex },

  { path: '/products/:id', component: ProductShow },

  { path: '/positions/new', component: PositionsNew },
  { path: '/positions/:id', component: PositionShow },
  { path: '/positions', component: Positions },

  { path: '/locations/:slug', component: LocationsShow },

  { path: '/orders', component: OrdersIndex },
  { path: '/orders/new', component: OrdersNew },
  { path: '/orders/me', component: OrdersShow },
  { path: '/orders/:id', component: OrdersContent }
]

const router = new VueRouter({
  routes
})
