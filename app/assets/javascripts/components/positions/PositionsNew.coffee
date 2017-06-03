@PositionsNew = Vue.component 'PositionsNew',

  template: '''
  <div>
    <ul class=breadcrumb>
      <li><a href='/#/'><i class='fa fa-home'></i></a></li>
      <li>Rentrer des produits</li>
    </ul>
    <div class='main-wrapper'>
      <div class='container-fluid'>
        <div class='row'>
          <div class='col-xs-12 col-md-6'>

            <form data-component="Products" v-on:submit="linkProduct" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" />
              <div class='modal-body'>
                <div class='form-group'>
                  <label class='form-label'>
                    Référence<em>*</em>
                    <span class='error hide' data-error="product">La référence est manquante</span>
                  </label>
                  <AutocompleteProduct></AutocompleteProduct>
                  <input type="hidden" v-model="position.product_id" class="form-control" disabled='true'/>
                </div>
                <div class='form-group'>
                  <label class='form-label'>Nom<em>*</em></label>
                  <input type="text" v-model="position.product_name" class="form-control" disabled='true'/>
                </div>
                <div class='form-group'>
                  <label class='form-label'>
                    Quantité<em>*</em>
                    <span class='error hide' data-error="quantity">Doit être un entier supérieur ou égal à 0</span>
                  </label>
                  <input type="text" v-model='position.quantity' class="form-control" />
                </div>
              </div>
            </form>

          </div>
          <div class='col-xs-12 col-md-6 history'>
            <h4>Emplacement disponibles</h4>
            <p class='loading' v-if="position.product_id == '' || position.quantity == ''">En attente de la sélection du produit et de la quantité</p>
            <a class='availability' v-for='availability in availabilities' v-on:click='linkProduct(this, availability.id)'><strong>{{availability.name}}</strong>{{availability.free}}</a>
            </ul>
          </div>
        </div>
      </div>
    </div>
    <ModalPositionCreateSuccess></ModalPositionCreateSuccess>
  </div>'''

  data: ->
    store.state

  watch: 'position':
    deep: true
    handler: (to, from) ->
      if store.state.position.product_id != '' and store.state.position.quantity != ''
        $.ajax
          url: '/autocomplete/availabilities'
          type: 'get'
          data:
            q:
              id: store.state.position.product_id
              quantity: store.state.position.quantity
          success: (data) ->
            store.state.availabilities = data.positions
            return
      else
        store.state.availabilities = []

  mounted: ->
    store.state.availabilities = []
    store.position = {}
    
  methods:
    saveQuantity: (e) ->
      store.state.position.quantity = $(e.target).val()

    linkProduct: (e, position_id) ->
      $.ajax
        url: "/positions"
        type: 'post'
        data:
          product_id: store.state.position.product_id
          id: position_id
          quantity: store.state.position.quantity
        success: (data) ->
          $('#positionCreateSuccess').modal()
        error: (data) ->
          alert 'An error has occured'
