const Position = Vue.component('Position', {
  template: `
    <div class="card">
      <div class="card-block">
        <h4 class="card-title"><a href="/#/products/3">{{position.product.reference}}</a></h4>
        <hr>
        <p class='barcode' v-html="position.product.ean13"></p>
        <p class="card-text">
          <p v-if="position.product.name != ''">Nom: <a href="/products/3">{{position.product.name}}</a></p>
          <p>Emplacement: <a href="/positions/a-1-b-4">{{position.name}}</a></p>
          <p>Stock: <strong>{{position.quantity}}</strong></p>
        </p>
      </div>
    </div>
  `,

  props: {
    position: {
      type: Object,
      default: function() {
        return {}
      }
    }
  }

  // methods: {
  //   doaction: function() {
  //     store.state.products = [
  //       {name: 'State changed !'}
  //     ]
  //   }
  // }
})
