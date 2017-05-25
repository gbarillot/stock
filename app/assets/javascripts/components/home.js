const Home = Vue.component('Home', {
  template: `
    <div>
      <Nav></Nav>
      <div class='main-wrapper'>
        <div class='container-fluid'>
          <div class='row'>
            <div class='col-md-4' v-for='position in positions'><Position :position='position'></Position></div>
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
       url: '/positions',
       type: 'get',
       success: function (data) {
         store.state.positions = data.positions;
       }
    });
  }
})
