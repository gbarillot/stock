<template>
  <div class='playground'>
    <Navbar></Navbar>
    <v-touch @swipe="travel">
      <div class='main-wrapper'>
        <div class='container-fluid'>
          <div class='row'>
            <div class='col-xs-12 col-sm-6 col-md-4 col-lg-3' v-for='position in positions'>
              <Position :position='position'></Position>
            </div>
          </div>
        </div>
      </div>
    </v-touch>
    <MainMenu></MainMenu>
    <Scanner></Scanner>
    <ModalMove></ModalMove>
  </div>
</template>

<script>

import Navbar from './_navbar.vue'
import Position from './_position.vue'
import MainMenu from './_main_menu.vue'
import Scanner from '../modals/scanner.vue'
import ModalMove from '../modals/move.vue'

export default {
  components: {
    Position,
    Navbar,
    MainMenu,
    Scanner,
    ModalMove
  },

  data () {
    return this.$store.state.PositionStore;
  },

  mounted: function() {
    this.$store.dispatch('PositionStore/index')
  }

}

</script>
