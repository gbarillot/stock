@StatsIndex = Vue.component 'StatsIndex',

  template: '''
    <div>
      <ul class=breadcrumb>
        <li><a href='/#/'><i class='fa fa-home'></i></a></li>
        <li>Statistiques</li>
      </ul>
      <div class='main-wrapper'>
        <div class='container-fluid'>
          <div class='row stats'>
            <div class='figure col-xs-12 col-sm-12 col-md-10 col-md-offset-1 col-lg-8 col-lg-offset-2'>
              <h3>Nombres de commandes traitées</h3>
              <div class='chart-1'></div>
            </div>
            <div class='figure col-xs-12 col-sm-12 col-md-10 col-md-offset-1 col-lg-8 col-lg-offset-2'>
              <h3>Taux de remplissage</h3>
              <div class='chart-2'></div>
            </div>
            <div class='figure col-xs-12 col-sm-12 col-md-10 col-md-offset-1 col-lg-8 col-lg-offset-2'>
              <h3>Temps de traitement des commandes</h3>
              <div class='chart-3'></div>
            </div>
            <div class='figure col-xs-12 col-sm-12 col-md-10 col-md-offset-1 col-lg-8 col-lg-offset-2'>
              <h3>Durée de vie d'un produit dans l'entrepôt</h3>
              <div class='chart-4'></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  '''

  mounted: ->
    new (Chartist.Line)('.chart-1', {
        labels: [
          'Lundi'
          'Mardi'
          'Mercredi'
          'Jeudi'
          'Vendredi'
        ]
        series: [
          [12, 9, 7, 8, 5],
          [2, 1, 3.5, 7, 3]
        ]
      },
      fullWidth: true,
      chartPadding:
        right: 40
        left: 0
    )

    new (Chartist.Line)('.chart-2', {
        labels: [
          'Lundi'
          'Mardi'
          'Mercredi'
          'Jeudi'
          'Vendredi'
        ]
        series: [
          [12, 12, 12, 12, 12],
          [7, 2, 3.5, 1, 3]
        ]
      },
      fullWidth: true
      chartPadding:
        right: 40
        left: 0
    )

    new (Chartist.Line)('.chart-3', {
        labels: [
          'Lundi'
          'Mardi'
          'Mercredi'
          'Jeudi'
          'Vendredi'
        ]
        series: [
          [12, 12, 12, 12, 12],
          [7, 2, 3.5, 1, 3]
        ]
      },
      fullWidth: true
      chartPadding:
        right: 40
        left: 0
    )

    new (Chartist.Line)('.chart-4', {
        labels: [
          'Lundi'
          'Mardi'
          'Mercredi'
          'Jeudi'
          'Vendredi'
        ]
        series: [
          [12, 12, 12, 12, 12],
          [7, 2, 3.5, 1, 3]
        ]
      },
      fullWidth: true
      chartPadding:
        right: 40
        left: 0
    )
