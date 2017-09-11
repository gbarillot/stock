import helpers from '../../helpers';

const OrderStore = {
  namespaced: true,
  state: {
    orders: [],
    users: [],
    order: {
      state: 'busy',
      id: 0,
      klass: 'btn-primary',
      reference: '',
      state_name: '',
      user_id: null,
      due_hour: '',
      due_minutes: ''
    },
    errors: {
      user: '',
      created_by: '',
      reference: '',
      due_at: ''
    }
  },
  mutations: {
    errors(state, data) {
      state.errors = helpers.showErrors(data);
      return state.errors;
    },
    all(state, data) {
      state.orders = data.orders;
      if(data.users){
        state.users = [{id: null, first_name: 'Choisir...', last_name: ''}];
        data.users.map(function(user){
          state.users.push(user);
        })
      }
      return state;
    },
    update(state, data) {
      state.order = data;
    },
    resetAll(state, data){
      let newOrders = [];
      state.orders.map(function(order) {
        if(order.id == data.orders[0].id) {
          newOrders.push(data.orders[0])
        } else {
          newOrders.push(order)
        }
      })
      state.orders = newOrders;
    }
  },
  actions: {
    index(context) {
      $.ajax({
        url: '/orders/all',
        type: 'get',
        success: function(data) {
          context.commit('all', data);
        }
      })
    },
    show(context) {
      $.ajax({
        url: '/orders/me',
        type: 'get',
        success: function(data) {
          context.commit('all', data);
        }
      })
    },
    create(context, form) {
      return new Promise((resolve, reject) => {
        $.ajax({
          url: '/orders',
          type: 'post',
          data: {
            order: form
          },
          success: function(data) {
            resolve(data);
          },
          error: function(data) {
            context.commit('errors', data);
            reject(false);
          }
        })
      })
    },
    update(context, order) {
      $.ajax({
        url: '/orders/' + order.id,
        method: 'PUT',
        data: {
          order: order
        },
        success: function(data) {
          context.commit('resetAll', data)
        }
      });
    },
    users(context) {
      $.ajax({
        url: '/users',
        type: 'get',
        success: function(data) {
          context.commit('all', data)
        }
      })
    }
  }
};

export default OrderStore;
