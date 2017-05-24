const Home = Vue.component('Home', {
  template: `
    <div>
      <Nav></Nav>
      <div class='main-wrapper'>
        <div class='container-fluid'>
          <div class='row'>
            <div class='col-md-4' v-for='product in products'><Product></Product></div>
          </div>
        </div>
      </div>
      <ModalCreate></ModalCreate>
    </div>`,

  data: function(){
    return {
      products: [
        { name: 'Foo' },
        { name: 'Bar' }
      ]
    }
  }
})
