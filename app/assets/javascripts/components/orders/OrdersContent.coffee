@OrdersContent = Vue.component 'OrdersContent',

  template: '''
    <div>
      <ul class=breadcrumb>
        <li><a href='/#/'><i class='fa fa-home'></i></a></li>
        <li><a href="/#/orders">Commandes</a></li>
        <li>{{order.reference}}</li>
      </ul>
      <div class='main-wrapper'>
        <div class='container-fluid'>
          <div class='row'>
            <div class='col-xs-12 col-sm-6 col-md-4 col-lg-3' v-for='item in items'>
              <div class="card">
                <div class="card-block">
                  <h4 class="card-title"><a v-bind:href="'/#/products/'+item.product.id">{{item.position.name}}</a></h4>
                  <hr />
                  <p class="card-text">
                    <p>Réf: {{item.product.reference}}</p>
                    <p>Qté: <strong>{{item.quantity}}</strong></p>
                  </p>
                  <hr />
                  <p class="card-footer">
                    <a :class="'btn btn-primary btn-block ' + itemKlass(item.picked)" v-on:click="pick(item.id)">{{itemLabel(item.picked)}}</a></button>
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>'''

  data: ->
    order: {}
    items: []

  mounted: ->
    that = this
    $.get('/baskets/' + that.$route.params.id).done (data) ->
      that.order = data.metrics.order
      that.items = data.items
      return

  methods:
    itemKlass: (picked) ->
      if picked == true
        "btn-danger"
      else
        ""

    itemLabel: (picked) ->
      if picked == true
        "Reposer"
      else
        "Prendre"

    pick: (id) ->
      that = this
      $.ajax
        url: '/baskets/'+id
        type: 'put'
        success: (data) ->
          for item in that.items
            if item.id == data.id
              item.picked = data.picked
