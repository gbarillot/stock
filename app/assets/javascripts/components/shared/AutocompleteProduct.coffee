@AutocompleteProduct = Vue.component('AutocompleteProduct',
  template: '''
    <div class='autocomplete'>
      <input type="text"
       v-model="q"
       v-on:keyup="search"

       class="form-control"
       placeholder="Saisir les premiers caractères..."
      />
      <ul>
        <li v-for="product in products" v-on:click="pick">
          <strong>{{product.reference}}</strong>
          <span>{{product.name}}</span><i>{{product.id}}</i>
        </li>
      </ul>
    </div>'''

  data: ->
    {
      q: ''
      products: []
    }
  methods:
    search: ->
      that = this
      delay (->
        $.get('/products/autocomplete', q: that.q).done (data) ->
          that.products = data.products
          return
        return
      ), 300
      return
    pick: (e) ->
      el = $(e.currentTarget)
      @q = el.find('strong').text()
      @products = []
      store.state.new_position.product_name = el.find('span').text()
      store.state.new_position.product_id = el.find('i').text()
      return
)
