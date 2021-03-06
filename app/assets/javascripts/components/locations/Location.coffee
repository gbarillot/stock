@Location = Vue.component 'Location',

  template: '''
    <div class="card">
      <div class="card-block">
        <p class="card-text">
          <p style='text-align: center'>{{location.type}}</p>
          <h3 style='text-align: center'>
            <a :href="'/#/locations/' + location.slug" v-if="location.kind == 'node'">{{location.name}}</a>
            <div v-if="location.kind == 'position'">{{location.name}}</div>
          </h3>
        </p>
        <hr />
        <p class="card-footer">
          <p style='text-align: center'><a v-on:click.prevent.stop="" href='#' class='btn btn-primary'>+ Modifier</a></p>
        </p>
      </div>
    </div>
  ''',

  props:
    location:
      type: Object
      default: ->
        {}

  methods:
    toggleMoveModal: (e, id, quantity) ->
      store.state.position.id = id
      store.state.position.quantity = quantity
      $('#moveProduct').modal()
