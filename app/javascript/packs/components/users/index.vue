<template>
  <div>
    <ul class=breadcrumb>
      <li><a href='/#/'><i class='fa fa-home'></i></a></li>
      <li>Mon compte</li>
    </ul>
    <v-touch @swipe="travel" class='main-wrapper'>
      <div class='container-fluid'>
        <div class='row'>
          <div class='col-xs-12 col-sm-12 col-md-6 col-lg-6 col-md-offset-3 col-lg-offset-3'>
            <form data-component="Products" v-on:submit.prevent="update" accept-charset="UTF-8">
              <div class='form-group'>
                <label>Prénom<em>*</em><span class='error'>{{errors.first_name}}</span></label>
                <input v-model="user.first_name" type="text" value="" />
              </div>
              <div class='form-group'>
                <label>Nom<em>*</em><span class='error'>{{errors.last_name}}</span></label>
                <input v-model="user.last_name" type="text" value="" />
              </div>
              <div class='form-group'>
                <label>Mot de passe<span class='error'>{{errors.password}}</span></label>
                <input v-model="user.password" type="password" value="" />
              </div>
              <div class='form-group'>
                <label>Confirmer le mot de passe<span class='error'>{{errors.password_confirmation}}</span></label>
                <input v-model="user.password_confirmation" type="password" value="" />
              </div>

              <div class='form-group'>
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
    return this.$store.state.UserStore;
  },
  mounted: function() {
    this.$store.dispatch('UserStore/edit');
  },
  methods: {
    update: function(e) {
      this.$store.dispatch('UserStore/update', this.user);
    }
  }
}

</script>
