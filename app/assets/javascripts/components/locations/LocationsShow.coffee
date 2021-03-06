@LocationsShow = Vue.component 'LocationsShow',

  template: '''
    <div>
      <ul class=breadcrumb>
        <li><a href='/#/'><i class='fa fa-home'></i></a></li>
        <li v-html="tree" class='tree-path'></li>
      </ul>
      <div class='main-wrapper'>
        <div class='container-fluid'>
          <div class='row'>
            <div class='col-xs-12' v-if="level < 4">
              <a href='#' data-toggle="modal" data-target="#locationNew">+ Ajouter un emplacement</a>
              <hr />
            </div>
            <div class='col-xs-12 col-sm-6 col-md-4 col-lg-3' v-for='location in locations'><Location :location='location'></Location></div>
          </div>
        </div>
      </div>
      <ModalLocationNew></ModalLocationNew>
    </div>''',

  data: ->
    store.state

  mounted: ->
    that = this
    $.ajax
      url: '/locations/' + that.$route.params.slug
      type: 'get'
      success: (data) ->
        store.state.tree = data.tree
        store.state.level = data.level
        store.state.locations = data.locations

  watch: '$route': (to, from) ->
    that = this
    $.ajax
      url: '/locations/' + to.params.slug
      type: 'get'
      success: (data) ->
        store.state.tree = data.tree
        store.state.level = data.level
        store.state.locations = data.locations

  methods:
    reload: ->
      that = this
      $.ajax
        url: '/locations/' + that.$route.params.slug
        type: 'get'
        success: (data) ->
          store.state.tree = data.tree
          store.state.level = data.level
          store.state.locations = data.locations
