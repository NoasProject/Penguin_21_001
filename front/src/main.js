import Vue from "vue";
import App from "./lib/App.vue";
import Todo from "./lib/Todo.vue";
import axios from "axios";
import vueAxios from "vue-axios";
// axios.defaults.baseURL = process.env.APP_API_ENDPOINT;

Vue.config.productionTip = false;

Vue.use(vueAxios, axios);

new Vue({
  render: (h) => h(Todo),
  data: {
    newItem: "",
    todos: []
  }
}).$mount("#todo");

new Vue({
  render: (h) => h(App),
}).$mount("#app");