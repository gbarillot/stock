@LocationsNew = Vue.component 'LocationsNew',

  template: '''
    <div>
      <ul class=breadcrumb>
        <li><a href='/#/'><i class='fa fa-home'></i></a></li>
        <li><a href='/#/locations/*'>Emplacements</a></li>
        <li>Nouveau</li>
      </ul>
      <div class='main-wrapper'>
        <div class='container-fluid'>
          <div class='row'>
            <div class='col-xs-12'>
              <a href='#' data-toggle="modal" data-target="#locationNew">+ Ajouter un emplacement ici</a>
              <hr />
            </div>
            <div class='col-xs-12 col-sm-6 col-md-4 col-lg-3' v-for='location in locations'><Location :location='location'></Location></div>
          </div>
        </div>
      </div>
      <ModalLocationNew></ModalLocationNew>
    </div>''',

  data: ->
    {
      locations: []
      tree: ''
    }

  mounted: ->
    that = this
    $.ajax
      url: '/locations/' + that.$route.params.slug
      type: 'get'
      success: (data) ->
        that.tree = data.tree
        that.locations = data.locations
        console.log data.locations

  watch: '$route': (to, from) ->
    that = this
    $.ajax
      url: '/locations/' + to.params.slug
      type: 'get'
      success: (data) ->
        that.tree = data.tree
        that.locations = data.locations

  methods: reload: (e) ->
    that = this
    $.ajax
      url: '/locations/' + that.$route.params.slug
      type: 'get'
      success: (data) ->
        that.tree = data.tree
        that.locations = data.locations
