@ModalMove = Vue.component 'ModalMove',

  template: '''
    <div aria-hidden='true' aria-labelledby='myModalLabel' class='modal' id='moveProduct' role='dialog' tabindex='-1'>
      <div class='modal-dialog' role='document'>
        <div class='modal-content'>
          <div class='modal-header'>
            <button aria-label='Close' class='close' data-dismiss='modal' type='button'>
              <span aria-hidden='true'>×</span>
            </button>
            <h4 class='modal-title w-100 before' style='color: #000'>Déplacer</h4>
            <h4 class='modal-title w-100 after' style='color: #000'>Confirmation</h4>
          </div>

          <div class='modal-body'>
            <form data-component="Products" v-on:submit="moveProduct" accept-charset="UTF-8" method="post">
              <div class='form-group'>
                <label>Quantité à déplacer</label>
                <select class='form-control' v-on:change='setQuantity'>
                  <option v-for="i in position.quantity" :value='i' >{{i}}</option>
                </select>
              </div>
              <div class='form-group mt-20'>
                <label>Nouvel emplacement<em>*</em></label>
                <AutocompletePositions></AutocompletePositions>
              </div>
            </form>
            <div class='success-msg'>
              <p>{{position.quantity}} produits déplacés</p>
              <strong><span>A 7 B 4</span> -> <span>B 7 3 5</span></strong>
            </div>
          </div>

        </div>
      </div>
    </div>
  '''

  data: ->
    store.state

  mounted: ->
    console.log
    this.quantity = 6
    $('#moveProduct form').show()
    $('#moveProduct .success-msg').hide()
    $('#moveProduct h4.before').show()
    $('#moveProduct h4.after').hide()

  methods:
    setQuantity: (e) ->
      #console.log $(e.target).val()
      store.state.quantity_to_move = $(e.target).val()

    moveProduct: ->
      console.log 'here'
