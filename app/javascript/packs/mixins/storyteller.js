export default{
  methods: {
    travel: function(e) {
      if(e.direction === 4){
        window.history.go(-1);
        return false;
      };
      if(e.direction === 2){
        window.history.go(+1);
        return false;
      }
    }
  }
}
