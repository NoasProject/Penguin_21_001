import Vue from "vue";
import App from "./views/App.vue";
import axios from "axios";
import vueAxios from "vue-axios";
// axios.defaults.baseURL = process.env.APP_API_ENDPOINT;
import BootstrapVue from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

Vue.config.productionTip = false;

Vue.use(vueAxios, axios);
Vue.use(BootstrapVue)

new Vue({
  render: (h) => h(App),
}).$mount("#app");
