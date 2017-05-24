const Product = Vue.component('Product', {
  template: `
    <div class="card">
      <div class="card-block">
        <h4 class="card-title"><a href="/#/products/3">{{product.name}}</a></h4>
        <hr>
        <p class="card-text">
          Nom: <a href="/products/3">eqer</a>
          <br>
          Emplacement: <a href="/positions/a-1-b-4">a-1-b-4</a>
          <br>
          Stock: <strong>4</strong>
          <br>
          <button type='button' v-on:click='doaction' class='btn btn-primary'>Change state</button>
        </p>
      </div>
    </div>
  `,

  props: {
    product: {
      type: Object,
      default: function() {
        return {}
      }
    }
  },

  methods: {
    doaction: function() {
      store.state.products = [
        {name: 'State changed !'}
      ]
    }
  }
})
