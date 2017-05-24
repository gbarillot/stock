const Product = Vue.component('Product', {
  template: `
    <div class="card">
      <div class="card-block">
        <h4 class="card-title"><a href="/products/3">56789</a></h4>
        <hr>
        <p class="card-text">
          Nom: <a href="/products/3">Produit 3</a>
          <br>
          Emplacement: <a href="/positions/a-1-b-4">a-1-b-4</a>
          <br>
          Stock: <strong>4</strong>
        </p>
      </div>
    </div>
  `
})
