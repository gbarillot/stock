@Position = Vue.component 'Position',

  template: '''
    <div class="card">
      <div class="card-block">
        <h4 class="card-title"><a v-bind:href="'/#/products/' + position.product.id">{{position.product.reference}}</a></h4>
        <hr />
        <p class="card-text">
          <p v-if="position.product.name != ''"><a v-bind:href="'/#/products/' + position.product.id">{{position.product.name}}</a></p>
        </p>
        <hr />
        <p class="card-footer">
          <strong style='float: right'><a class='btn btn-primary' v-bind:href="'/#/locations/' + position.location">{{position.name}}</a></strong>
          <a class='btn btn-primary' v-on:click="toggleMoveModal(this, position.id, position.quantity)">{{position.quantity}}</a></button>
        </p>
      </div>
    </div>
  ''',

  props:
    position:
      type: Object
      default: ->
        {}

  methods:
    toggleMoveModal: (e, id, quantity) ->
      store.state.position.id = id
      store.state.position.quantity = quantity
      $('#moveProduct').modal()
