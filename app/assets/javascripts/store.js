const store = new Vuex.Store({
  state: {
    positions: [],
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
