const Position = Vue.component('Position', {
  template: `
    <div class="card">
      <div class="card-block">
        <h4 class="card-title"><a v-bind:href="'/#/products/' + position.product.id">{{position.product.reference}}</a></h4>
        <hr />
        <p class="card-text">
          <p v-if="position.product.name != ''"><a v-bind:href="'/#/products/' + position.product.id">{{position.product.name}}</a></p>
        </p>
        <hr />
        <p class="card-footer">
          <strong style='float: right'><a class='btn btn-action' v-bind:href="'/#/positions/' + position.id">{{position.name}}</a></strong>
          <a class='btn btn-action' data-toggle="modal" data-target="#moveProduct">{{position.quantity}}</a></button>
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
