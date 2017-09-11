<template>
  <div aria-hidden='true' aria-labelledby='myModalLabel' class='modal' id='orderState' role='dialog' tabindex='-1'>
    <div class='modal-dialog' role='document'>
      <div class='modal-content'>
        <div class='modal-header'>
          <button aria-label='Close' class='close' data-dismiss='modal' type='button'>
            <span aria-hidden='true'>×</span>
          </button>
          <h4 class='modal-title w-100' style='color: #000'>Status</h4>
        </div>

        <div class='modal-body'>
          <ul class='editor'>
            <li>
              <p style='padding-left: 20px'><input name='state' type='radio' v-on:click="setState(this, 'busy', order.id)" :checked="order.state == 'busy'"><span style='padding-left: 20px'>En préparation</span></p>
            </li>
            <li class='separator'></li>
            <li>
              <p style='padding-left: 20px'><input name='state' type='radio' v-on:click="setState(this, 'done', order.id)" :checked="order.state == 'done'"><span style='padding-left: 20px'>Prête</span></p>
            </li>
            <li class='separator'></li>
            <li>
              <p style='padding-left: 20px'><input name='state' type='radio' v-on:click="setState(this, 'delivered', order.id)" :checked="order.state == 'delivered'"><span style='padding-left: 20px'>Livrée</span></p>
            </li>
          </ul>
        </div>

      </div>
    </div>
  </div>
</template>

<script>

export default {

  data: function() {
    return this.$store.state.OrderStore;
  },

  methods: {
    setState: function(e, state, id) {
      this.$store.dispatch('OrderStore/update', {
        state: state,
        id: id
      });
      window.$('#orderState').modal('hide');
    }
  }

}

</script>
