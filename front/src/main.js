import Vue from "vue";
import App from "./lib/App.vue";
import Todo from "./lib/Todo.vue";

Vue.config.productionTip = false;

new Vue({
  render: (h) => h(Todo),
  data: {
    newItem: "",
    todos: []
  },
  methods: {
    addItem: function () {
      console.log("Add Item.");
      if (this.newItem == '') return; //タスク未入力の場合は追加しない
      var todo = {
        item: this.newItem
      };
      this.todos.push(todo);
      this.newItem = '' //タスク追加後に入力欄を空にする
    }
  }
}).$mount("#todo");

new Vue({
  render: (h) => h(App),
}).$mount("#app");

