const Position = Vue.component('Position', {
  template: `
    <div class="card">
      <div class="card-block">
        <h4 class="card-title"><a href="/#/products/3">{{position.product.reference}}</a></h4>
        <hr />
        <p class="card-text">
          <p v-if="position.product.name != ''"><a href="/#/products/3">{{position.product.name}}</a></p>
        </p>
        <hr />
        <p class="card-footer">
          <strong style='float: right'><a class='btn btn-action' v-bind:href="'/#/positions/' + position.id">{{position.name}}</a></strong>
          <a class='btn btn-action'>{{position.quantity}}</button>
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

})
