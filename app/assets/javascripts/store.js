const store = new Vuex.Store({
  state: {
    positions: [],
    metrics: [0, 0, 0],
    q: '',
    orders: [],
    current_order: {
      state: 'busy',
      id: 0,
      klass: 'btn-primary',
      state_name: ''
    },
    new_position: {
      product_name: '',
      product_id: '',
      quantity: '',
      reference: ''
    },
    availabilities: []
  },
  mutations: {
     addPosition (state, position) {
       state.positions.unshift(position)
    }
  }
})
