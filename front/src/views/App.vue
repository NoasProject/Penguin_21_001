<template>
  <div id="app">
    <h2>{{ msg }}</h2>
    <form v-on:submit.prevent>
      <input type="text" v-model="task.title" />
      <input type="text" v-model="task.description" />
      <button v-on:click="createTodo()">Add</button>
    </form>
    <table>
      <tr>
        <th>ID</th>
        <th>TITLE</th>
        <th>DESCRIPTION</th>
        <th>STATE</th>
        <th>NEXT</th>
        <th>DELETE</th>
        <th>作成時刻</th>
      </tr>
      <tr v-for="todo in todos" v-bind:key="todo.id">
        <td>{{ todo.id }}</td>
        <td>{{ todo.title }}</td>
        <td>{{ todo.description }}</td>
        <td>{{ toStateName(todo.state) }}</td>
        <td>
          <!-- 更新処理のボタン -->
          <button :disabled="todo.state >= state.complete" v-on:click="updateTodo(todo, todo.state + 1)">
            {{ toStateName(todo.state + 1) }}
          </button>
        </td>
        <td>
          <!-- 削除のボタン -->
          <button :disabled="todo.state == state.delete" v-on:click="destroyTodo(todo.id)">アーカイブ</button>
        </td>
        <td>{{ todo.created_at }}</td>
      </tr>
    </table>
  </div>
</template>

<script>
export default {
  created() {
    this.fetchTodo();
  },
  data() {
    return {
      task: {
        title: "",
        description: "",
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
    };
  },
  props: {
    msg: String,
  },
  methods: {
    // <---- API
    // タスクの一覧を取得する
    fetchTodo: function () {
      this.axios
        .get("http://localhost:3000/todos", {
          params: {
            limit: 100,
          },
        })
        .then((response) => {
          this.todos = response.data;
          console.log(response.data);
        })
        .catch((e) => {
          alert(e);
        });
    },

    // タスクを追加する
    createTodo: function () {
      var p = this.task;
      this.axios
        .post("http://localhost:3000/todos", p)
        .then((response) => {
          console.log(response);
          this.todos.push(response.data);
          this.task = {};
        })
        .catch((e) => {
          alert(e);
        });
    },

    // タスクのStateを更新する
    updateTodo: function (todo, state) {
      var id = todo.id;
      todo.state = state;
      this.axios
        .patch("http://localhost:3000/todos/" + id, {
          state: state,
        })
        .then((response) => {
          console.log(response.data);
          var targetIndex = this.todos.findIndex((i) => i.id == id);
          if (targetIndex >= 0) {
            this.todos[targetIndex] = todo;
          }
        })
        .catch((e) => {
          alert(e);
        });
    },

    // タスクのStateを更新する
    destroyTodo: function (id) {
      this.axios
        .delete("http://localhost:3000/todos/" + id)
        .then((response) => {
          console.log(response.data);
          var destroyIndex = this.todos.findIndex((i) => i.id == id);
          if (destroyIndex >= 0) {
            this.todos.splice(destroyIndex, 1);
          } else {
            console.log("削除対象のIndexが存在しませんでした: " + destroyIndex);
          }
        })
        .catch((e) => {
          alert(e);
        });
    },

    // Stateをみやすい名前に変換する
    toStateName: function (state) {
      if (state in this.state.names) {
        return this.state.names[state];
      }
      return "- - -";
    },
  },
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
