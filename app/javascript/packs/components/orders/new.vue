<template>
  <div>
    <ul class=breadcrumb>
      <li><a href='/#/'><i class='fa fa-home'></i></a></li>
      <li><a href='/#/orders'>Commandes</a></li>
      <li>Nouvelle commande</li>
    </ul>
    <v-touch @swipe="travel" class='main-wrapper'>
      <div class='container-fluid'>
        <div class='row'>
          <div class='col-xs-12 col-sm-12 col-md-6 col-lg-6 col-md-offset-3 col-lg-offset-3'>
            <form data-component="Products" v-on:submit.prevent="createOrder" accept-charset="UTF-8" method="post">
              <div class='form-group'>
                <label>Réference<em>*</em><span class='error'>{{errors.reference}}</span></label>
                <input v-model="order.reference" type="text" value="" />
              </div>
              <div class='form-group'>
                <label>Nom</label>
                <input v-model="order.name" type="text" value="" />
              </div>
              <div class='form-group'>
                <label>Assigner à<em>*</em><span class='error'>{{errors.user}}</span></label>
                <select v-model="order.user_id" name='user_id' class='form-control'>
                  <option v-for='user in users' :value="user.id">{{user.first_name}} {{user.last_name}}</option>
                </select>
              </div>
              <div class='form-group mt-30'>
                <div class='row'>
                  <div class='col-sm-12 col-xs-12'>
                    <label>Date d'échéance<em>*</em><span class='error'>{{errors.due_at}}</span></label>
                    <div class='pick-date'>
                      <div></div>
                    </div>
                  </div>
                </div>
                <br />
                <div class='row'>
                  <div class='col-xs-12'>
                    <label>Heure<em>*</em></label>
                    <div class='pick-time'>
                      <select v-model='order.due_hour' class='form-control' style='width: 45%; float: left;'>
                        <option value=''>Choisir...</option>
                        <option value='0'>00</option>
                        <option value='1'>01</option>
                        <option value='2'>02</option>
                        <option value='3'>03</option>
                        <option value='4'>04</option>
                        <option value='5'>05</option>
                        <option value='6'>06</option>
                        <option value='7'>07</option>
                        <option value='8'>08</option>
                        <option value='9'>09</option>
                        <option value='10'>10</option>
                        <option value='11'>11</option>
                        <option value='12'>12</option>
                        <option value='13'>13</option>
                        <option value='14'>14</option>
                        <option value='15'>15</option>
                        <option value='16'>16</option>
                        <option value='17'>17</option>
                        <option value='18'>18</option>
                        <option value='19'>19</option>
                        <option value='20'>20</option>
                        <option value='21'>21</option>
                        <option value='22'>22</option>
                        <option value='23'>23</option>
                      </select>
                      <select v-model='order.due_minutes' class='form-control' style='width: 45%; float: left;margin-left: 10px;'>
                        <option value=''>Choisir...</option>
                        <option value='0'>00</option>
                        <option value='5'>05</option>
                        <option value='10'>10</option>
                        <option value='15'>15</option>
                        <option value='20'>20</option>
                        <option value='25'>25</option>
                        <option value='30'>30</option>
                        <option value='35'>35</option>
                        <option value='40'>40</option>
                        <option value='45'>45</option>
                        <option value='50'>50</option>
                        <option value='55'>55</option>
                      </select>
                    </div>
                  </div>
                </div>
              </div>
              <div class='form-group mt-30'>
                <input type='submit' class='btn btn-primary btn-block'>
              </div>
            </form>
          </div>
        </div>
      </div>
    </v-touch>
  </div>
</template>

<script>

export default {

  data: function() {
    return this.$store.state.OrderStore;
  },

  mounted: function() {
    var that = this;
    window.$('.pick-date div').datepicker({format: 'yyyy-mm-dd'}).on('changeDate', function() {
      that.order.due_date = window.$(this).datepicker('getFormattedDate')
    })
    this.$store.dispatch('OrderStore/users', this.order);
  },

  methods: {
    createOrder: function(e) {
      this.$store.dispatch('OrderStore/create', this.order).then(
        response => {
          window.location.href = `/#/orders/${response.id}/edit`
      });
    }
  }

}
</script>
