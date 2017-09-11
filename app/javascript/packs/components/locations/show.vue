<template>
  <div>
    <ul class=breadcrumb>
      <li><a href='/#/'><i class='fa fa-home'></i></a></li>
      <li v-html="tree" class='tree-path'></li>
    </ul>
    <v-touch @swipe="travel" class='main-wrapper'>
      <div class='container-fluid'>
        <div class='row'>
          <div class='col-xs-12' v-if="level < 4">
            <a href='#' data-toggle="modal" data-target="#locationNew">+ Ajouter un emplacement</a>
            <hr />
          </div>
          <div class='col-xs-12 col-sm-6 col-md-4 col-lg-3' v-for='location in locations'><Location :location='location'></Location></div>
        </div>
      </div>
    </v-touch>
    <!-- <LocationNew></LocationNew> -->
  </div>
</template>

<script>

import Location from './_location.vue'

export default {
  components: {
    Location
  },
  data: function() {
    return this.$store.state.LocationStore;
  },
  mounted: function() {
    this.$store.dispatch('LocationStore/show', this.$route.params.slug)
  },
  watch: {
    '$route': function(to, from) {
      this.$store.dispatch('LocationStore/show', to.params.slug)
    }
  },
  methods: {
    reload: function() {
      this.$store.dispatch('LocationStore/show', to.params.slug)
    }
  }
}
</script>
