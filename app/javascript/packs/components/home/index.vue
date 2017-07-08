<template lang='pug'>
  div
    //-nav
    .main-wrapper
      .container-fluid
        .row
          .col-xs-12.col-sm-6.col-md-4.col-lg-3(v-for='position in positions')
            Position(:position='position')
    //- modalmenu
    //- modalmove
    //- modalscanner
</template>

<script>

import Position from './_position.vue'

export default {

  components: {
    Position: Position
  },

  data () {
    return this.$store.state.positions
  },

  created: function() {
    this.$store.dispatch('positions_index')
  }

}

</script>
