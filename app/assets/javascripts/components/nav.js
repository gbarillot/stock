const Nav = Vue.component('Nav', {
  template: `
    <nav class="navbar navbar-light bg-primary">
      <a type="button" class="pull-right btn-floating btn-large btn-add waves-effect waves-light" data-toggle="modal" data-target="#createProduct"><i>+</i></a>
      <form class="form-inline pull-xs-right">
          <input id='search' class="form-control col-md-12" type="text" placeholder="Rechercher un produit ou un #emplacement..." >
      </form>
    </nav>
  `
})
