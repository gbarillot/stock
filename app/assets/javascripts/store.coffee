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

    locations: []
    location: {}
    tree: ''
    level: 0
    availabilities: []
    metrics: [0, 0, 0]
    quantity_to_move: 0
    q: ''
    qq: ''

  mutations: addPosition: (state, position) ->
    state.positions.unshift position
