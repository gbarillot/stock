const OrdersShow = Vue.component('OrdersShow', {
  template: `
    <div>
      <ul class=breadcrumb>
        <li><a href='/#/'><i class='fa fa-home'></i></a></li>
        <li><a href='/#/orders'>Commandes</a></li>
        <li>Mes commandes</li>
      </ul>
      <div class='main-wrapper'>
        <div class='container-fluid'>
          <div class='row'>
            <div class='col-xs-12 col-sm-6 col-md-4 col-lg-3' v-for='order in orders'><Order :order='order'></Order></div>
          </div>
        </div>
      </div>
      <ModalOrderState></ModalOrderState>
    </div>`,

  data: function(){
    return store.state;
  },

  mounted: function () {
    let that = this;
    $.ajax({
       url: '/orders/me',
       type: 'get',
       success: function (data) {
         store.state.orders = data.orders
       }
    });
  }
})
