@AutocompletePositions = Vue.component 'AutocompletePositions',

  template: '''
    <div class='autocomplete autocomplete-positions'>
      <input type="text"
       v-model="q"
       v-on:keyup="search"
       class="form-control"
       placeholder="Saisir les premiers caractères..."
      />
      <ul>
        <li v-for="availability in availabilities" v-on:click="pick">
          <strong :data-destination="availability.id">{{availability.name}}</strong>
          <span>{{availability.free}}</span>
        </li>
      </ul>
    </div>'''

  data: ->
    store.state

  mounted: ->
    store.state.availabilities = []

  methods:
    search: ->
      that = this
      delay (->
        $.ajax
          url: '/autocomplete/availabilities'
          type: 'get'
          data:
            q:
              id: store.state.position.id
              quantity: store.state.position.quantity
          success: (data) ->
            store.state.availabilities = data.positions
      ), 300

    pick: (e) ->
      that = this
      el = $(e.currentTarget)
      $.ajax
        url: "/positions/#{store.state.position.id}"
        type: 'put'
        data:
          quantity: store.state.position.quantity
          destination: el.find('[data-destination]').data('destination')
        success: (data) ->
          $('#moveProduct form').hide()
          $('#moveProduct .success-msg').show()
          $('#moveProduct h4.before').hide()
          $('#moveProduct h4.after').show()
          #that.positions = data
