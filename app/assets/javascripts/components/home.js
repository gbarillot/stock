const Home = Vue.component('Home', {
  template: `
    <div>
      <Nav></Nav>
      <div class='main-wrapper'>
        <div class='container-fluid'>
          <div class='row'>
            <div class='col-md-4' v-for='product in products'><Product :product='product'></Product></div>
          </div>
        </div>
      </div>
      <ModalCreate></ModalCreate>
    </div>`,

  data: function(){
    return store.state
  },

  mounted: function () {
    $.ajax({
       url: '/products',
       type: 'get',
       success: function (data) {
         store.state.products = data.products;
       }
    });
  }
})
