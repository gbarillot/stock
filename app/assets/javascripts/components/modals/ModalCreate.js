const ModalCreate = Vue.component('ModalCreate', {
  template: `
    <div aria-hidden='true' aria-labelledby='myModalLabel' class='modal fade' id='createProduct' role='dialog' tabindex='-1'>
      <div class='modal-dialog' role='document'>
        <div class='modal-content'>
          <div class='modal-header'>
            <button aria-label='Close' class='close' data-dismiss='modal' type='button'>
              <span aria-hidden='true'>×</span>
            </button>
            <h4 class='modal-title w-100' style='color: #000'>Ajouter un produit</h4>
          </div>

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
                <input type="text" v-model="new_position.quantity" class="form-control" />
              </div>
              <div class='form-group'>
                <label class='form-label'>
                  Emplacement<em>*</em>
                  <span class='error hide' data-error="name">Composantes de l'emplacement séparées par des espaces</span>
                </label>
                <input type="text" v-model="new_position.name" class="form-control" />
              </div>
            </div>
            <div class='modal-footer'>
              <input type="submit" name="commit" value="Enregistrer" class="btn btn-primary pull-right" />
              <button class='btn btn-secondary pull-right' data-dismiss='modal' type='button'>Fermer</button>
            </div>
          </form>

        </div>
      </div>
    </div>
  `,

  data: function(){
    return store.state
  },

  methods: {
    linkProduct: function(e) {
      e.preventDefault();
      that = this;
      $("[data-error]").addClass('hide');
      $('.btn-primary.btn.pull-right').prop("disabled", false);

      $.post('/positions', {
          position: {
            product_id: this.new_position.product_id,
            name: this.new_position.name,
            quantity: this.new_position.quantity
          }
        }).always(function(data) {
          $('.btn-primary.btn.pull-right').prop("disabled", false);
        }).done(function(data) {
          store.commit('addPosition', {
            id: data.position.id,
            name: data.position.name,
            quantity: data.position.quantity,
            product: {
              id: data.position.product.id,
              name: data.position.product.name,
              ean13: data.position.product.ean13,
              reference: data.position.product.reference
            }
          });
          $('#createProduct').modal('hide');
        }).fail(function(data){
          $('.btn-primary.btn.pull-right').prop("disabled", false);
          for (var key in data.responseJSON.errors) {
            $("[data-error='"+key+"']").removeClass('hide');
          }
        }
      );
    }
  }
})
