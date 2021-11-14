import Vue from "vue";
import vueCookie from "vue-cookies";
import router from "./router";
import axios from "axios";
import vueAxios from "vue-axios";
import bootstrapVue from "bootstrap-vue";
import "bootstrap/dist/css/bootstrap.css";
import "bootstrap-vue/dist/bootstrap-vue.css";

import FirstView from "./views/App.vue";

// axios.defaults.baseURL = process.env.APP_API_ENDPOINT;

Vue.config.productionTip = false;

Vue.use(vueCookie);
Vue.use(vueAxios, axios);
Vue.use(bootstrapVue);

const vue = new Vue({
  router: router,
  // comments: { FirstView },
  render: (h) => h(FirstView),
}).$mount("#app");

export default {
  vue,
  created() {

  },
  methods: {
  }
};
