@ProductShow = Vue.component('ProductShow',
  template: '''
    <div>
      <ul class=breadcrumb>
        <li><a href='/#/'><i class='fa fa-home'></i></a></li>
        <li><a href='#'>Produits</a></li>
        <li>{{product.reference}}</li>
      </ul>
      <div class='main-wrapper'>
        <div class='container-fluid'>
          <div class='row'>
            <div class='col-md-6'>
              <h3>Détail produit</h3>
              <p><strong>Nom</strong><br />{{product.name}}</p>
              <p><strong>Réference</strong><br />{{product.reference}}</p>
              <p><strong>Code barre</strong>
                <div v-html="product.ean13"></div>
              </p>
              <p><strong>Quantité encore disponible</strong><br />{{product.quantity}}</p>
              <p><strong>Quantité en entrepôt</strong><br />{{metrics.total}}</p>
            </div>
            <div class='col-md-6 history'>
              <h3>Historique</h3>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>'''

  data: ->
    {
      product: {}
      position: []
      metrics: total: 0
    }
  mounted: ->
    that = this
    $.ajax
      url: '/products/' + @$route.params.id
      type: 'get'
      success: (data) ->
        store.state.metrics = [
          data.metrics.positions
          data.metrics.count
        ]
        that.product = data.product
        that.position = data.product.positions
        that.metrics.total = data.metrics.count
        return
    return
)
