ModalPositionCreateSuccess = Vue.component('ModalPositionCreateSuccess',
  template: '''
    <div aria-hidden='true' aria-labelledby='myModalLabel' class='modal' id='positionCreateSuccess' role='dialog' tabindex='-1'>
      <div class='modal-dialog' role='document'>
        <div class='modal-content'>
          <div class='modal-header'>
            <button aria-label='Close' class='close' data-dismiss='modal' type='button'>
              <span aria-hidden='true'>×</span>
            </button>
            <h4 class='modal-title w-100' style='color: #000'>Ajouté</h4>
          </div>
          <div class='modal-body'>
             <h5>Le produit a bien été ajouté au stock, souhaitez-vous en ajouter un autre ?</h5>
          </div>
          <div class='modal-footer'>
            <a href="/#/positions/new" v-on:click="goToPage" class='btn btn-primary'>Oui</a>
            <a href="/#/" v-on:click="goToPage" class='btn'>Non</a>
          </div>
        </div>
      </div>
    </div>
  ''',

  data: ->
    store.state
  methods: goToPage: (e) ->
    e.preventDefault()
    lnk = $(e.target)
    $('.modal').modal 'hide'
    $('.autocomplete input').val ''
    store.state.new_position =
      product_name: ''
      product_id: ''
      quantity: ''
      reference: ''

    location.href = $(lnk).attr('href')

)
