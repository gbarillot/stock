@ModalOrders = Vue.component('ModalOrders',
  template: '''
    <div aria-hidden='true' aria-labelledby='myModalLabel' class='modal' id='ordersMenu' role='dialog' tabindex='-1'>
      <div class='modal-dialog' role='document'>
        <div class='modal-content'>
          <div class='modal-header'>
            <button aria-label='Close' class='close' data-dismiss='modal' type='button'>
              <span aria-hidden='true'>×</span>
            </button>
            <h4 class='modal-title w-100' style='color: #000'>Commandes</h4>
          </div>

          <div class='modal-body'>

            <ul class='editor'>
              <li>
                <a href='/#/orders/me' v-on:click="goToPage"><span>+</span> Mes commandes</a>
              </li>
              <li class='separator'></li>
              <li>
                <a href='/#/orders' v-on:click="goToPage"><span>+</span> Toutes les commandes</a>
              </li>
              <li class='separator'></li>
              <li>
                <a href='/#/orders/new' v-on:click="goToPage"><span>+</span> Créer</a>
              </li>
            </ul>
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
    $('#ordersMenu').modal 'hide'
    location.href = $(lnk).attr('href')
    return
)
