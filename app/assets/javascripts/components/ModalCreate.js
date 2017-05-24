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

          <form data-component="Products" data-do="create" data-on="submit" action="/products" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" />
            <div class='modal-body'>
              <div class='form-group'>
                <label class='form-label'>Référence<em>*</em></label>
                <input type="text" name="product[reference]" id="product_reference" class="form-control" />
              </div>
              <div class='form-group'>
                <label class='form-label'>Nom<em>*</em></label>
                <input type="text" name="product[name]" id="product_name" class="form-control" />
              </div>
              <div class='form-group'>
                <label class='form-label'>Quantité<em>*</em></label>
                <input type="text" name="product[quantity]" id="product_quantity" class="form-control" />
              </div>
              <div class='form-group'>
                <label class='form-label'>Emplacement<em>*</em></label>
                <input type="text" name="product[position]" id="product_position" class="form-control" />
              </div>
            </div>
            <div class='modal-footer'>
              <input type="submit" name="commit" value="Enregistrer" class="btn btn-primary pull-right" data-disable-with="Enregistrer" />
              <button class='btn btn-secondary pull-right' data-dismiss='modal' type='button'>Fermer</button>
            </div>
          </form>
          
        </div>
      </div>
    </div>
  `
})
