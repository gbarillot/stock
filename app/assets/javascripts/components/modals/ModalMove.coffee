@ModalMove = Vue.component('ModalMove',
  template: '''
    <div aria-hidden='true' aria-labelledby='myModalLabel' class='modal' id='moveProduct' role='dialog' tabindex='-1'>
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
                  <div class='form-group' style='text-align: center'>
                    <input type="submit" name="commit" value="Enregistrer" class="btn btn-primary" />
                  </div>
                </form>
              </li>
              <li class='separator'></li>
              <li>
                <a href='#' v-on:click="openToggleForm"><span>+</span> Sortir</a>
                <form data-component="Products" v-on:submit="moveProduct" accept-charset="UTF-8" method="post">
                  <div class='form-group'>
                    <label>Réference de la commande<em>*</em></label>
                    <input name="position[name]" type="text" value="" />
                  </div>
                  <div class='form-group' style='text-align: center'>
                    <input type="submit" name="commit" value="Enregistrer" class="btn btn-primary" />
                  </div>
                </form>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  '''

  data: ->
    store.state
  methods:
    openToggleForm: (e) ->
      e.preventDefault()
      lnk = $(e.target)
      if lnk.find('span').text() == '+'
        lnk.find('span').text '-'
        lnk.parent().find('form').show()
        lnk.parent().parent().find('li').hide()
        lnk.parent().parent().find('li').css 'border-color: #fff'
        lnk.parent().show()
      else
        lnk.find('span').text '+'
        lnk.parent().find('form').hide()
        lnk.parent().parent().find('li').show()
      return
    moveProduct: (e) ->
      e.preventDefault()
      false
)
