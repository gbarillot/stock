import helpers from '../../helpers';

const PositionStore = {
  namespaced: true,
  state: {
    positions: [],
    metrics: [0, 0, 0],
    q: '',
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
      state.positions = data.positions;
      if(data.metrics){
        state.metrics = [
          data.metrics.positions,
          data.metrics.count,
          data.metrics.orders_count
        ];
      }

      return state.positions;
    }
  },
  actions: {
    index(context) {
      $.ajax({
        url: '/positions',
        type: 'get',
        success: function(data) {
          context.commit('all', data);
        }
      });
    },
    search(context, q) {
      if (q.length > 2) {
        if (timer){
          clearTimeout(timer);
        }
        var timer = setTimeout(function(){
          $.ajax({
            url: '/autocomplete/positions',
            type: 'get',
            data: {
              q: q
            },
            success: function(data) {
              context.commit('all', data);
            }
          })
        }, 400);
      }
      if(q.length == 0) {
        $.ajax({
          url: '/positions',
          type: 'get',
          success: function(data) {
            context.commit('all', data);
          }
        });
      }
    }
  }
};

export default PositionStore;
