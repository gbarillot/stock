const store = new Vuex.Store({
  state: {
    positions: [],
    metrics: [0, 0],
    q: '',
    new_position: {
      product_name: '',
      product_id: '',
      quantity: '',
      reference: ''
    }
  },
  mutations: {
     addPosition (state, position) {
       state.positions.unshift(position)
    }
  }
})
