const PositionStore = {
  state: {
    positions: [],
    position: {
      id: null,
      product_name: '',
      product_id: '',
      quantity: '',
      reference: '',
    }
  },
  mutations: {
    all(state, data) {
      return state.positions = data.positions;
    }
  },
  actions: {
    positions_index({ commit }) {
      $.ajax({
        url: '/positions',
        type: 'get',
        success: function(data) {
          commit('all', data);
        }
      });
    }
  }
};

export default PositionStore;
