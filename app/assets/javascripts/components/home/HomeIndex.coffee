@HomeIndex = Vue.component('HomeIndex',
  template: '''
    <div>
      <Nav></Nav>
      <div class='main-wrapper'>
        <div class='container-fluid'>
          <div class="row">
            <div class='col-xs-12 col-sm-6 col-md-4 col-lg-3' v-for='position in positions'><Position :position='position'></Position></div>
          </div>
        </div>
      </div>
      <ModalMenu></ModalMenu>
      <ModalMove></ModalMove>
    </div>''',

  data: ->
    store.state
  mounted: ->
    $.ajax
      url: '/positions'
      type: 'get'
      success: (data) ->
        store.state.metrics = [
          data.metrics.positions
          data.metrics.count
          data.metrics.orders_count
        ]
        store.state.positions = data.positions
        return
    return
)
