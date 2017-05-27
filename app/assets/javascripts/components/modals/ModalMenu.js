const ModalMenu = Vue.component('ModalMenu', {
  template: `
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
                <a href='/#/orders/me' v-on:click="goToPage"><span>+</span> Mes commandes</a>
              </li>
              <li class='separator'></li>
              <li>
                <a href='/#/orders' v-on:click="goToPage"><span>+</span> Toutes les commandes</a>
              </li>
              <li class='separator'></li>
              <li>
                <a href='/#/orders/new' v-on:click="goToPage"><span>+</span> Nouvelle commande</a>
              </li>
              <li class='separator'></li>
              <li>
                <a href='/#/positions/new' v-on:click="goToPage"><span>+</span> Rentrer des produits</a>
              </li>
              <li class='separator'></li>
              <li>
                <a href='/#/' v-on:click="goToPage"><span>+</span> Mon compte</a>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  `,

  data: function(){
    return store.state
  },

  methods: {
    goToPage: function(e) {
      e.preventDefault();
      lnk = $(e.target);
      $('#showMenu').modal('hide');
      location.href = $(lnk).attr('href')
    }
  }
})
