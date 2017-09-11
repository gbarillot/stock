<template>
  <div>
    <ul class=breadcrumb>
      <li><a href='/#/'><i class='fa fa-home'></i></a></li>
      <li><a href='#'>Produits</a></li>
      <li>{{product.reference}}</li>
    </ul>
    <v-touch @swipe="travel" class='main-wrapper'>
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
    </v-touch>
  </div>
</template>

<script>

export default {
  data: function() {
    return {
      product: {},
      position: [],
      metrics: {
        total: 0
      }
    };
  },

  mounted: function() {
    var that;
    that = this;
    return $.ajax({
      url: '/products/' + this.$route.params.id,
      type: 'get',
      success: function(data) {
        that.metrics = {total: data.metrics.count};
        that.product = data.product;
        that.position = data.product.positions;
      }
    });
  }
}

</script>
