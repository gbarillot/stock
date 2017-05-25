const PositionDetail = Vue.component('PositionDetail', {
  template: `
    <div>
      <Nav></Nav>
      <div class='main-wrapper'>
        <div class='container-fluid'>
          <div class='row'>

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
       url: '/positions/' + this.$route.params.id,
       type: 'get',
       success: function (data) {
         store.state.positions = data.positions;
       }
    });
  }
})
