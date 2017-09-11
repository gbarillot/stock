import helpers from '../../helpers';

const LocationStore = {
  namespaced: true,
  state: {
    metrics: [0, 0, 0],
    locations: [],
    location: {},
    tree: '',
    level: 2
  },
  mutations: {
    all(state, data) {
      state.locations = data.locations;
      state.level = data.level;
      state.tree = data.tree;

      return state.locations;
    }
  },
  actions: {
    show(context, slug) {
      $.ajax({
        url: '/locations/' + slug,
        type: 'get',
        success: function(data) {
          context.commit('all', data);
        }
      });
    }
  }
};

export default LocationStore;
