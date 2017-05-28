@PositionShow = Vue.component('PositionShow',
  template: '''
    <div>
      <Nav></Nav>
      <div class='main-wrapper'>
        <div class='container-fluid'>
          <div class='row'>

          </div>
        </div>
      </div>
      <ModalCreate></ModalCreate>
    </div>'''

  data: ->
    { positions: [] }
  mounted: ->
    $.ajax
      url: '/positions/' + @$route.params.id
      type: 'get'
      success: (data) ->
        store.state.positions = data.positions
        return
    return
)
