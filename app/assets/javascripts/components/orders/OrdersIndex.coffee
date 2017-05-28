@OrdersIndex = Vue.component('OrdersIndex',
  template: '''
    <div>
      <ul class=breadcrumb>
        <li><a href='/#/'><i class='fa fa-home'></i></a></li>
        <li>Commandes</li>
      </ul>
      <div class='main-wrapper'>
        <div class='container-fluid'>
          <div class='row'>
            <div class='col-xs-12 col-sm-6 col-md-4 col-lg-3' v-for='order in orders'><Order :order='order'></Order></div>
          </div>
        </div>
      </div>
      <ModalOrderState></ModalOrderState>
    </div>'''

  data: ->
    store.state
  mounted: ->
    that = this
    $.ajax
      url: '/orders/all'
      type: 'get'
      success: (data) ->
        store.state.orders = data.orders
        return
    return
)
