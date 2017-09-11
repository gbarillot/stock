import helpers from '../../helpers';

const UserStore = {
  namespaced: true,
  state: {
    user: {
      first_name: '',
      last_name: ''
    },
    errors: {}
  },
  mutations: {
    update(state, data) {
      if(data.user){
        state.user = data.user;
      }
      return state.user;
    },
    errors(state, data) {
      state.errors = helpers.showErrors(data);
      return state.errors;
    }
  },
  actions: {
    edit(context) {
      $.ajax({
        url: '/users/me',
        type: 'get',
        success: function(data) {
          context.commit('update', data);
        }
      });
    },
    show(context, user_id) {
      $.ajax({
        url: '/users/' + user_id,
        type: 'get',
        success: function(data) {
          context.commit('update', data);
        }
      });
    },
    update(context, form) {
      return $.ajax({
        url: '/users',
        type: 'post',
        data: {
          user: form
        },
        success: function(data) {
          context.commit('update', data);
        },
        error: function(data) {
          context.commit('errors', data);
        }
      })
    }
  }
};

export default UserStore;
