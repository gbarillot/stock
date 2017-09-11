<template>
  <div>
    <ul class=breadcrumb>
      <li><a href='/#/'><i class='fa fa-home'></i></a></li>
      <li><a href="/#/orders">Commandes</a></li>
      <li>{{metrics.order.reference}}</li>
    </ul>
    <v-touch @swipe="travel" class='main-wrapper'>
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
    </v-touch>
  </div>
</template>

<script>

export default {

  data: function() {
    return this.$store.state.BasketStore;
  },

  mounted: function() {
    this.$store.dispatch('BasketStore/show', this.$route.params.id)
  },

  methods: {
    itemKlass: function(picked) {
      if(picked == true) {
        return "btn-danger"
      } else {
        return ""
      }
    },

    itemLabel: function(picked) {
      if(picked == true) {
        return "Reposer"
      } else {
        return "Prendre"
      }
    },

    pick: function(id) {
      this.$store.dispatch('BasketStore/pick', id)
    }
  }

}

</script>
