@PositionsNew = Vue.component('PositionsNew',
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
                  <input type="hidden" v-model="new_position.product_id" class="form-control" disabled='true'/>
                </div>
                <div class='form-group'>
                  <label class='form-label'>Nom<em>*</em></label>
                  <input type="text" v-model="new_position.product_name" class="form-control" disabled='true'/>
                </div>
                <div class='form-group'>
                  <label class='form-label'>
                    Quantité<em>*</em>
                    <span class='error hide' data-error="quantity">Doit être un entier supérieur ou égal à 0</span>
                  </label>
                  <input type="text" v-model='new_position.quantity' class="form-control" />
                </div>
              </div>
            </form>

          </div>
          <div class='col-xs-12 col-md-6 history'>
            <h4>Emplacement disponibles</h4>
            <p class='loading' v-if="new_position.product_id == '' || new_position.quantity == ''">En attente de la sélection du produit et de la quantité</p>
            <a class='availability' v-for='availability in availabilities' v-on:click='linkProduct(this, availability.name)'><strong>{{availability.name}}</strong>{{availability.free}}</a>
            </ul>
          </div>
        </div>
      </div>
    </div>
    <ModalPositionCreateSuccess></ModalPositionCreateSuccess>
  </div>'''

  data: ->
    store.state
  watch: 'new_position':
    deep: true
    handler: (to, from) ->
      if store.state.new_position.product_id != '' and store.state.new_position.quantity != ''
        $.ajax
          url: '/positions/available'
          type: 'get'
          data:
            id: store.state.new_position.product_id
            quantity: store.state.new_position.quantity
          success: (data) ->
            store.state.availabilities = data
            return
      else
        store.state.availabilities = []
      return
  methods:
    saveQuantity: (e) ->
      store.state.new_position.quantity = $(e.target).val()
      return
    linkProduct: (e, name) ->
      $.post('/positions', position:
        product_id: store.state.new_position.product_id
        name: name
        quantity: store.state.new_position.quantity).done((data) ->
        $('#positionCreateSuccess').modal()
        return
      ).fail (data) ->
        alert 'An error has occured'
        return
      return
)
