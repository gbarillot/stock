import helpers from '../../helpers';

const BasketStore = {
  namespaced: true,
  state: {
    items: [],
    metrics: {
      order: {
        id: null,
        reference: ''
      },
      positions: null,
      count: null
    }
  },
  mutations: {
    content(state, data) {
      state.items = data.items;
      state.metrics = data.metrics;

      return state;
    },
    pick(state, data) {
      state.items.map(function(item) {
        if(item.id == data.id) {
          item.picked = data.picked
        }
      })

      return state;
    }
  },
  actions: {
    show(context, id) {
      $.ajax({
        url: '/baskets/' + id,
        type: 'get',
        success: function(data) {
          context.commit('content', data);
        }
      })
    },
    pick(context, id) {
      $.ajax({
        url: '/baskets/'+id,
        type: 'put',
        success: function(data) {
          context.commit('pick', data)
        }
      })
    }
  }
};

export default BasketStore;
