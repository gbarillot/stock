const AutocompleteProduct = Vue.component('AutocompleteProduct', {
  template: `
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
    </div>
  `,

  data: function() {
    return {
      q: '',
      products: []
    }
  },

  methods: {
    search: function() {
      that = this
      delay(function(){
        $.get('/products/autocomplete', {q: that.q})
          .done(function(data) {
            that.products = data.products
          }
        )
      }, 300 )
    },
    pick: function(e) {
      el = $(e.currentTarget);
      this.q = el.find('strong').text()
      this.products = []
      store.state.new_position = {
        product_name: el.find('span').text(),
        product_id: el.find('i').text()
      }

    }
  }
})
