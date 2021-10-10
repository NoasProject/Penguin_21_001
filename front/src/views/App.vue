<template>
  <div id="app">
    <h2>{{ msg }}</h2>
    <form v-on:submit.prevent>
      <input type="text" v-model="inputTitleTxt" />
      <input type="text" v-model="inputDescriptionTxt" />
      <button v-on:click="addItem">Add</button>
    </form>
    <table>
      <tr>
        <th>ID</th>
        <th>TITLE</th>
        <th>DESCRIPTION</th>
        <th>STATE</th>
        <th>作成時刻</th>
        <th>NEXT</th>
        <th>DELETE</th>
        <th>DELETE</th>
      </tr>
      <tr v-for="todo in todos" v-bind:key="todo.id">
        <td>{{ todo.id }}</td>
        <td>{{ todo.title }}</td>
        <td>{{ todo.description }}</td>
        <td>{{ toStateName(todo.state) }}</td>
        <td>{{ todo.created_at }}</td>
        <td>
          <button v-on:click="taskNextState(todo.id)">
            {{ toStateName(todo.state + 1) }}
          </button>
        </td>
        <td>
          <button v-on:click="taskDelete(todo.id)">削除</button>
        </td>
        <td>
          <button v-on:click="taskRealDelete(todo.id)">物理削除</button>
        </td>
      </tr>
    </table>
  </div>
</template>

<script>
import State from "../components/constants/States";

export default {
  name: "TodoTop",
  created() {
    this.States = State;
    this.fetchTodosApi();
  },
  data() {
    return {
      inputTitleTxt: "",
      inputDescriptionTxt: "",
      todos: [],
    };
  },
  props: {
    msg: String,
  },
  methods: {
    // <---- API
    // タスクの一覧を取得する
    fetchTodosApi: function () {
      this.axios
        .get("http://localhost:3000/todos", {
          params: {
            limit: 100,
          },
        })
        .then((response) => {
          this.todos = [];
          response.data.forEach((ele) => {
            this.todos.push(ele);
          });
          console.log(response.data);
        })
        .catch((e) => {
          alert(e);
        });
    },

    // タスクを追加する
    AddTodoApi: function (title, description) {
      this.axios
        .post("http://localhost:3000/todos", {
          operation: "create",
          title: title,
          description: description,
        })
        .then((response) => {
          console.log(response);
          // TODO: Responseで更新するのが良い
          this.fetchTodosApi();
        })
        .catch((e) => {
          alert(e);
        });
    },

    // タスクのStateを更新する
    UpdateTodoStateApi: function (id, state) {
      this.axios
        .put("http://localhost:3000/todos/" + id, {
          id: id,
          state: state,
        })
        .then((response) => {
          console.log(response.data);
          this.fetchTodosApi();
        })
        .catch((e) => {
          alert(e);
        });
    },

    // タスクのStateを更新する
    destroyTodoApi: function (id) {
      this.axios
        .delete("http://localhost:3000/todos/" + id, {
          id: id,
        })
        .then((response) => {
          console.log(response.data);
          this.fetchTodosApi();
        })
        .catch((e) => {
          alert(e);
        });
    },
    // ---->

    // <--- UI Action
    addItem: function () {
      var title = this.inputTitleTxt;
      var description = this.inputDescriptionTxt;
      if (title == "") {
        alert("タスク未入力");
        return;
      }

      this.AddTodoApi(title, description);
      return;

      /*
      var obj = {
        id: this.todos.length + 1,
        title: item,
        description: "",
        state: this.States.min,
        created_at: "",
      };

      this.todos.push(obj);
      */
    },
    // 削除する
    taskRealDelete: function (id) {
      this.destroyTodoApi(id);
    },

    // 削除する
    taskDelete: function (id) {
      var state = this.States.delete;
      this.taskStateChange(id, state);
    },

    // 次の状態に変更する
    taskNextState: function (id) {
      var findElement = this.todos.find((todo) => todo.id == id);
      if (findElement === undefined) {
        return;
      }

      var nextState = findElement.state + 1;
      if (nextState > this.States.complete) {
        return;
      }
      return this.taskStateChange(id, nextState);
    },

    // 状態を変更する
    taskStateChange: function (id, state) {
      var findElement = this.todos.find((todo) => todo.id == id);
      if (findElement === undefined) {
        return;
      }

      var elm = this.States.array.find((f) => f.id == state);
      if (elm === undefined) {
        console.log("不正な値");
        return;
      }
      findElement.state = state;
      this.UpdateTodoStateApi(id, state);
    },

    // Stateをみやすい名前に変換する
    toStateName: function (state) {
      var elm = this.States.array.find((f) => f.id == state);
      if (elm === undefined) return "- - -";

      return elm.name;
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
