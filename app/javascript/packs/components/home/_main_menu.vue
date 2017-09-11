<template>
  <ul class="main-nav" data-is='mainNav'>
    <li><a href='/#/orders/me' @click.prevent="goToPage">Mes commandes</a></li>
    <li><a href='/#/orders' @click.prevent="goToPage">Toutes les commandes</a></li>
    <li><a href='/#/orders/new' @click.prevent="goToPage">Nouvelle commande</a></li>
    <li><a href='/#/positions/new' @click.prevent="goToPage">Rentrer des produits</a></li>
    <li><a href='/#/locations/*' @click.prevent="goToPage">Emplacements</a></li>
    <li><a href='/#/stats' @click.prevent="goToPage">Statistiques</a></li>
    <li><a href='/#/users' @click.prevent="goToPage">Mon compte</a></li>
  </ul>
</template>

<script>

export default {

  methods: {
    goToPage: function(e){
      var lnk = $(e.target);
      window.$('#showMenu').modal('hide');
      location.href = $(lnk).attr('href');
    }
  }

}

</script>
