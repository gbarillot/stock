const Nav = Vue.component('Nav', {
  template: `
    <nav class="navbar navbar-light bg-primary">
      <a type="button" class="pull-right btn-floating btn-large btn-add" data-toggle="modal" data-target="#createProduct"><i>+</i></a>
      <form class="form-inline pull-xs-right autocomplete">
          <input
           v-model="q"
           v-on:keyup="search"
           v-on:focus="redirect"

           class="form-control col-md-12 col-sm-8"
           type="text"
           placeholder="Référence ou #emplacement..."
          />
      </form>
      <span class="metrics">{{metrics[0]}}/{{metrics[1]}}</span>
    </nav>
  `,

  data: function() {
    return store.state
  },

  methods: {
    search: function() {
      that = this
      delay(function() {
        $.get('/positions/autocomplete', {q: that.q})
          .done(function(data) {
            store.state.metrics = [data.metrics.positions, data.metrics.count]
            store.state.positions = data.positions
          }
        )
      }, 300 )
    },
    redirect: function() {
      window.location.href= '/#/'
    }
  }
})
