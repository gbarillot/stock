<template>
  <div>
    <ul class=breadcrumb>
      <li><a href='/#/'><i class='fa fa-home'></i></a></li>
      <li><a href="/#/orders">Commandes</a></li>
      <li><a :href="'/#/baskets/'+order.id">{{order.reference}}</a></li>
      <li>Modifier</li>
    </ul>
    <div class='main-wrapper'>
      <div class='container-fluid'>
        <div class='row'>
          <div class='col-xs-12 col-sm-12 col-md-6 col-lg-6'>
            <div class='form-group'>
              <label>Ajouter des produits à cette commande</label>
              <input type="text" value=""
               v-model="q"
               v-on:keyup="search"
               placeholder="Chercher par référence ou nom..."/>

              <ul class='order-products'>
                <li v-for="position in positions">
                  <div class='action-form'>
                    <input name='quantity' value='' :data-ref="position.id" :data-max="position.quantity" type='text' placeholder='Quantité'>
                    <input type='button' v-on:click="addProduct" class='btn btn-primary' value='Ajouter'>
                  </div>
                  <div class='description'>
                    <h5>{{position.product.reference}}</h5>
                    <span>{{position.product.name}} ({{position.name}} / {{position.quantity}})</span>
                  </div>
                </li>
              </ul>

            </div>
          </div>
          <div class='col-xs-12 col-sm-12 col-md-6 col-lg-6 history'>
            <ul class='order-products'>
              <li v-for="position in basket">
                <div class='action-form'>
                  <input name='quantity' :value="position.quantity" :data-ref="position.id" :data-max="position.quantity" type='text' placeholder='Quantité' disabled='true'>
                  <input type='button' v-on:click="removeProduct" class='btn btn-danger' value='RETIRER'>
                </div>
                <div class='description'>
                  <h5>{{position.product.reference}}</h5>
                  <span>{{position.product.name}} ({{position.name}} / {{position.quantity}})</span>
                </div>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

export default {
  data: function() {
    return {
      q: '',
      order: {},
      positions: [],
      basket: []
    };
  },
  mounted: function() {
    var that;
    that = this;
    return $.get('/baskets/' + that.$route.params.id).done(function(data) {
      that.order = data.metrics.order;
      that.basket = data.items;
    });
  },
  methods: {
    search: function() {
      var that;
      that = this;
        if (that.q === '') {
          that.positions = [];
        } else {
        if (that.q.length > 2) {
          $.ajax({
            url: '/autocomplete/positions',
            type: 'get',
            data: {
              q: that.q
            },
            success: function(data) {
              return that.positions = data.positions;
            }
          });
        }
      }
    },
    addProduct: function(e) {
      var btn, qty, that;
      that = this;
      btn = $(e.target);
      qty = btn.parent().find('[name=quantity]');
      if (parseInt(qty.val(), 10) !== 'NaN' && qty.val() % 1 === 0 && qty.val() !== '' && qty.val() !== void 0) {
        $.post('/baskets/add', {
          position_id: qty.data('ref'),
          order_id: that.$route.params.id,
          quantity: parseInt(qty.val(), 10)
        }).always(function(data) {
          btn.prop('disabled', true);
        }).done(function(data) {
          var i, position;
          btn.prop('disabled', false);
          i = 0;
          while (i < that.positions.length) {
            position = that.positions[i];
            if (position.id === qty.data('ref')) {
              position.quantity = parseInt(qty.val(), 10);
              qty.val('');
              that.basket.push(position);
              that.positions.splice(i, 1);
            }
            i++;
          }
        });
      }
    },
    removeProduct: function(e) {
      var btn, qty, that;
      that = this;
      btn = $(e.target);
      qty = btn.parent().find('[name=quantity]');
      return $.post('/baskets/remove', {
        position_id: qty.data('ref'),
        order_id: that.$route.params.id
      }).always(function(data) {
        btn.prop('disabled', true);
      }).done(function(data) {
        var i, position, results;
        i = 0;
        results = [];
        while (i < that.basket.length) {
          position = that.basket[i];
          if (position.id === qty.data('ref')) {
            that.basket.splice(i, 1);
          }
          results.push(i++);
        }
        return results;
      });
    }
  }
};

</script>
