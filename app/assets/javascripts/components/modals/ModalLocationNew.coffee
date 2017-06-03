@ModalLocationNew = Vue.component 'ModalLocationNew',

  template: '''
    <div aria-hidden='true' aria-labelledby='myModalLabel' class='modal' id='locationNew' role='dialog' tabindex='-1'>
      <div class='modal-dialog' role='document'>
        <div class='modal-content'>
          <div class='modal-header'>
            <button aria-label='Close' class='close' data-dismiss='modal' type='button'>
              <span aria-hidden='true'>×</span>
            </button>
            <h4 class='modal-title w-100' style='color: #000'>Type</h4>
          </div>

          <div class='modal-body'>

            <ul class='editor'>
              <li>
                <a href='#' v-on:click="toggleForm"><span>+</span> Noeud</a>
                <p>Un repère qui mène à d'autres emplacements et dans lequel ne sont pas directement stockés de produit. Exemples: Batiment, allée, étage... </p>
                <form class='form hidden-forms' v-on:submit.prevent="createLocation('node')" accept-charset="UTF-8" method="post">
                  <input v-model="location.type" type='hidden' value='node'>
                  <label class='form-label'>Nom du noeud<em>*</em></label>
                  <div class='clearfix'></div>
                  <div style='float: left; width: 40%;clear: both;'>
                    <input v-model="location.name" type='text' value='' class='form-control' placeholder='Ex: A ou 1 ou 42...'>
                  </div>
                  <div style='float: left; width: 50%'>
                    <input type='submit' value='Enregistrer' class='btn btn-primary'>
                  </div>
                  <div class='clearfix'></div>
                </form>
              </li>
              <li class='separator'></li>
              <li>
                <a href='#' v-on:click="toggleForm"><span>+</span> Emplacement</a>
                <p>Un emplacement précis au sein duquel des produits sont stockés</p>
                <form class='form hidden-forms' v-on:submit.prevent="createLocation('position')" accept-charset="UTF-8" method="post">
                  <div class='form-group'>
                    <label>Nom de l'emplacement<em>*</em><span class='error'>{{errors.name}}</span></label>
                    <input v-model="location.name" type='text' value='' class='form-control' placeholder="Chiffres ou lettres, sans espace">
                  </div>
                  <div class='form-group'>
                    <label>Largeur<em>*</em></label>
                    <input v-model="location.width" type='text' value='' class='form-control' placeholder="En Centimètres">
                  </div>
                  <div class='form-group'>
                    <label class='form-label'>Hauteur<em>*</em></label>
                    <input v-model="location.height" type='text' value='' class='form-control' placeholder="En Centimètres">
                  </div>
                  <div class='form-group'>
                    <label class='form-label'>Profondeur<em>*</em></label>
                    <input v-model="location.depth" type='text' value='' class='form-control' placeholder="En Centimètres">
                  </div>
                  <hr />
                  <div style='width: 100%;'>
                    <input type='submit' value='Enregistrer' class='btn btn-primary' style='margin: auto; text-align: center;'>
                  </div>
                </form>
              </li>
            </ul>

          </div>
        </div>
      </div>
    </div>
  ''',

  data: ->
    location: {}
    errors: {}

  methods:
    goToPage: (e) ->
      e.preventDefault()
      lnk = $(e.target)
      $('.modal').modal 'hide'
      location.href = $(lnk).attr('href')

    toggleForm: (e) ->
      e.preventDefault()
      el = $(e.target)

      if el.parent().find('a > span').text() == '+'
        el.parent().parent().find('li').hide()
        el.parent().show()
        el.parent().find('form').show()
        el.parent().find('p').hide()
        el.parent().find('a > span').text('-')
      else
        el.parent().parent().find('li').show()
        el.parent().find('form').hide()
        el.parent().find('p').show()
        el.parent().find('a > span').text('+')

      return false

    createLocation: (kind) ->
      that = this
      $.ajax
        url: '/locations'
        type: 'post'
        data:
          kind: kind
          location: that.location
          slug: that.$route.params.slug
        success: (data) ->
          store.state.tree = data.tree
          store.state.locations = data.locations
          $('.modal').modal('hide')
        error: (data) ->
          errors = {}
          for error, messages of data.responseJSON.errors
            for message in messages
              msg = message
            errors[error] = msg
          that.errors = errors
