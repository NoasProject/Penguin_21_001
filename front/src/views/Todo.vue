<template>
  <div>
    <TodoInputForm 
      ref="TodoInputForm"
      :propTodos="todos"
      :loginToken="loginToken"
      @todos:push="todos.push($event); updateTree()"
    >
    </TodoInputForm>
    
    <TodoTree 
      ref="TodoTree"
      :propTodos="todos"
      :state="state"
      :loginToken="loginToken"
      @todos:delete="todos.splice(todos.findIndex((i) => i.id == $event), 1); updateTree()"
      @todos:update="updateTodo($event)"
    >
    </TodoTree>
  </div>
</template>

<script>
import TodoInputForm from "../components/Todo/TodoInputForm.vue";
import TodoTree from "../components/Todo/TodoTree.vue";
export default {
  components: {
    TodoInputForm,
    TodoTree,
  },
  created() {
    this.loginToken = this.$cookies.get("login-token");
    this.fetchTodo();
  },
  data() {
    return {
      loginToken: undefined,
      task: {
        title: "",
        description: "",
      },
      edit_id: {
        title: 0,
        description: 0,
      },
      todos: [],
      state: {
        names: {
          1: "オープン",
          2: "進行中",
          3: "完了",
          9: "削除",
        },
        min: 1,
        delete: 9,
        complete: 3,
      },
      fields: [
        "id",
        "title",
        "description",
        { key: "state", label: "ステータス" },
        { key: "operation", label: "操作" },
        { key: "destroy", label: "削除" },
        "created_at",
      ],
    };
  },
  methods: {
    fetchTodo: function () {
      this.axios
        .get("http://localhost:3000/todos", {
          params: {
            login_token: this.loginToken,
            limit: 100,
          },
        })
        .then((response) => {
          this.todos = response.data;
          console.log(response.data);
          this.updateTree();
        })
        .catch((e) => {
          alert(e);
        });
    },
    updateTodo: function (todo) {
      var targetIndex = this.todos.findIndex((i) => i.id == todo.id);
      if (targetIndex >= 0) {
        this.todos[targetIndex] = todo;
      }
    },

    updateTree: function () {
      this.$refs.TodoTree.updateTodosData(this.todos);
    },
  },
};
</script>