@store = new (Vuex.Store)
  state:
    positions: []
    position:
      id: ''
      product_name: ''
      product_id: ''
      quantity: ''
      reference: ''

    orders: []
    order:
      state: 'busy'
      id: 0
      klass: 'btn-primary'
      state_name: ''

    availabilities: []
    metrics: [0, 0, 0]
    q: ''

  mutations: addPosition: (state, position) ->
    state.positions.unshift position
