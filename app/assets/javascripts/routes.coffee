# routes = [
#   { path: '/', component: HomeIndex }
#   { path: '/products/:id', component: ProductShow }
#   { path: '/positions/new', component: PositionsNew }
#   { path: '/positions/:slug', component: PositionsShow }
#   { path: '/locations/new', component: LocationsNew }
#   { path: '/locations/:slug', component: LocationsShow }
#   { path: '/orders', component: OrdersIndex }
#   { path: '/orders/new', component: OrdersNew }
#   { path: '/orders/me', component: OrdersShow }
#   { path: '/orders/:id', component: OrdersContent }
#   { path: '/orders/:id/edit', component: OrdersEdit }
#   { path: '/users', component: UsersEdit }
#   { path: '/users/:id', component: UsersEdit }
#   { path: '/stats', component: StatsIndex }
# ]
# @router = new VueRouter(routes: routes)

#//= require_tree ./vendor
#//= require helpers
#//= require qrcode

#= require_tree ./components
#= require store
#= require setup
#= require routes
