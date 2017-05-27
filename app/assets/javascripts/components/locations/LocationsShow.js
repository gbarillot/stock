const LocationsShow = Vue.component('LocationsShow', {
  template: `
    <div>
      <ul class=breadcrumb>
        <li><a href='/#/'><i class='fa fa-home'></i></a></li>
        <li v-html="tree" class='tree-path'></li>
        <li class='metrics'>{{metrics[0]}} / {{metrics[1]}}</li>
      </ul>
      <div class='main-wrapper'>
        <div class='container-fluid'>
          <div class='row'>
            <div class='col-xs-12 col-sm-6 col-md-4 col-lg-3' v-for='position in positions'><Position :position='position'></Position></div>
          </div>
        </div>
      </div>
    </div>`,

  data: function(){
    return {
      metrics: [0, 0],
      positions: [],
      tree: ""
    }
  },

  mounted: function () {
    let that = this
    $.ajax({
       url: '/locations/' + that.$route.params.slug,
       type: 'get',
       success: function (data) {
         that.metrics = [data.metrics.positions, data.metrics.count]
         that.positions = data.positions;
         that.tree = data.tree;
       }
    });
  },

  watch: {
    '$route' (to, from) {
      let that = this;
      $.ajax({
         url: '/locations/' + to.params.slug,
         type: 'get',
         success: function (data) {
           that.metrics = [data.metrics.positions, data.metrics.count]
           that.positions = data.positions;
           that.tree = data.tree;
         }
      });
    }
  },

  methods: {
    reload: function(e) {
      let that = this
      $.ajax({
         url: '/locations/' + that.$route.params.slug,
         type: 'get',
         success: function (data) {
           that.metrics = [data.metrics.positions, data.metrics.count]
           that.positions = data.positions;
           that.tree = data.tree;
         }
      });
    }
  }
})
