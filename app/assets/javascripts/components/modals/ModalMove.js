const ModalMove = Vue.component('ModalMove', {
  template: `
    <div aria-hidden='true' aria-labelledby='myModalLabel' class='modal fade' id='moveProduct' role='dialog' tabindex='-1'>
      <div class='modal-dialog' role='document'>
        <div class='modal-content'>
          <div class='modal-header'>
            <button aria-label='Close' class='close' data-dismiss='modal' type='button'>
              <span aria-hidden='true'>×</span>
            </button>
            <h4 class='modal-title w-100' style='color: #000'>Modifier un emplacement</h4>
          </div>

          <div class='modal-body'>

            <ul class='editor'>
              <li>
                <a href='#' v-on:click="openToggleForm"><span>+</span> Déplacer</a>
                <form data-component="Products" v-on:submit="moveProduct" accept-charset="UTF-8" method="post">
                  <div class='form-group'>
                    <label>Nouvel emplacement<em>*</em></label>
                    <input name="position[name]" type="text" value="" />
                  </div>
                </form>
              </li>
              <li></li>
              <li>
                <a href='#' v-on:click="openToggleForm"><span>+</span> Sortir</a>
                <form data-component="Products" v-on:submit="moveProduct" accept-charset="UTF-8" method="post">
                  <div class='form-group'>
                    <label>Réference de la commande<em>*</em></label>
                    <input name="position[name]" type="text" value="" />
                  </div>
                </form>
              </li>
            </ul>

            <div class='modal-footer'>
              <input type="submit" name="commit" value="Enregistrer" class="btn btn-primary" />
              <button class='btn btn-secondary' data-dismiss='modal' type='button'>Annuler</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  `,

  data: function(){
    return store.state
  },

  methods: {
    openToggleForm: function(e) {
      e.preventDefault();
      lnk = $(e.target);
      if (lnk.find('span').text() == '+'){
        lnk.find('span').text('-')
        lnk.parent().find('form').show();
        lnk.parent().parent().find('li').hide();
        lnk.parent().parent().find('li').css('border-color: #fff')
        lnk.parent().show();
      } else {
        lnk.find('span').text('+')
        lnk.parent().find('form').hide();
        lnk.parent().parent().find('li').show();
      }
    },
    moveProduct: function(e) {
      // e.preventDefault();
      // that = this;
      // $("[data-error]").addClass('hide');
      // $('.btn-primary.btn.pull-right').prop("disabled", false);
      //
      // $.post('/positions', {
      //     position: {
      //       product_id: this.new_position.product_id,
      //       name: this.new_position.name,
      //       quantity: this.new_position.quantity
      //     }
      //   }).always(function(data) {
      //     $('.btn-primary.btn.pull-right').prop("disabled", false);
      //   }).done(function(data) {
      //     store.commit('addPosition', {
      //       id: data.position.id,
      //       name: data.position.name,
      //       quantity: data.position.quantity,
      //       product: {
      //         id: data.position.product.id,
      //         name: data.position.product.name,
      //         ean13: data.position.product.ean13,
      //         reference: data.position.product.reference
      //       }
      //     });
      //     $('#createProduct').modal('hide');
      //   }).fail(function(data){
      //     $('.btn-primary.btn.pull-right').prop("disabled", false);
      //     for (var key in data.responseJSON.errors) {
      //       $("[data-error='"+key+"']").removeClass('hide');
      //     }
      //   }
      // );
    }
  }
})
