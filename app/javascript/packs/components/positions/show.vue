<template>
  <div>
    <ul class=breadcrumb>
      <li><a href='/#/'><i class='fa fa-home'></i></a></li>
      <li v-html="tree" class='tree-path'></li>
      <li class='metrics'>{{metrics[0]}} / {{metrics[1]}}</li>
    </ul>
    <v-touch @swipe="travel" class='main-wrapper'>
      <div class='container-fluid'>
        <div class='row'>
          <div class='col-xs-12 col-sm-6 col-md-4 col-lg-3' v-for='position in positions'><Position :position='position'></Position></div>
        </div>
      </div>
    </v-touch>
    <!-- <ModalMove></ModalMove> -->
  </div>
 </template>

<script>

export default {
  data: function() {
    this.$store.positions
  },

  // mounted: ->
  //   that = this
  //   $.ajax
  //     url: '/positions/list/' + that.$route.params.slug
  //     type: 'get'
  //     success: (data) ->
  //       that.metrics = [
  //         data.metrics.positions
  //         data.metrics.count
  //       ]
  //       that.positions = data.positions
  //       that.tree = data.tree
  //
  // watch: '$route': (to, from) ->
  //   that = this
  //   $.ajax
  //     url: '/positions/list/' + to.params.slug
  //     type: 'get'
  //     success: (data) ->
  //       that.metrics = [
  //         data.metrics.positions
  //         data.metrics.count
  //       ]
  //       that.positions = data.positions
  //       that.tree = data.tree
  //
  // methods: reload: (e) ->
  //   that = this
  //   $.ajax
  //     url: '/positions/list/' + that.$route.params.slug
  //     type: 'get'
  //     success: (data) ->
  //       that.metrics = [
  //         data.metrics.positions
  //         data.metrics.count
  //       ]
  //       that.positions = data.positions
  //       that.tree = data.tree
}
