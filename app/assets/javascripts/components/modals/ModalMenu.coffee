@ModalMenu = Vue.component 'ModalMenu',
  template: '''
    <div aria-hidden='true' aria-labelledby='myModalLabel' class='modal' id='showMenu' role='dialog' tabindex='-1'>
      <div class='modal-dialog' role='document'>
        <div class='modal-content'>
          <div class='modal-header'>
            <button aria-label='Close' class='close' data-dismiss='modal' type='button'>
              <span aria-hidden='true'>×</span>
            </button>
            <h4 class='modal-title w-100' style='color: #000'>Menu</h4>
          </div>

          <div class='modal-body'>

            <ul class='editor'>
              <li>
                <a href='/#/orders/me' v-on:click="goToPage">Mes commandes</a>
              </li>
              <li class='separator'></li>
              <li>
                <a href='/#/orders' v-on:click="goToPage">Toutes les commandes</a>
              </li>
              <li class='separator'></li>
              <li>
                <a href='/#/orders/new' v-on:click="goToPage">Nouvelle commande</a>
              </li>
              <li class='separator'></li>
              <li>
                <a href='/#/positions/new' v-on:click="goToPage">Rentrer des produits</a>
              </li>
              <li class='separator'></li>
              <li>
                <a href='/#/locations/*' v-on:click="goToPage">Emplacements</a>
              </li>
              <li class='separator'></li>
              <li>
                <a href='/#/stats' v-on:click="goToPage">Statistiques</a>
              </li>
              <li class='separator'></li>
              <li>
                <a href='/#/users' v-on:click="goToPage">Mon compte</a>
              </li>
            </ul>

          </div>
        </div>
      </div>
    </div>
  '''

  data: ->
    store.state

  methods: goToPage: (e) ->
    e.preventDefault()
    lnk = $(e.target)
    $('#showMenu').modal 'hide'
    location.href = $(lnk).attr('href')
