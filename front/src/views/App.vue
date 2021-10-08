<template>
  <div id="app">
    <h2>{{ msg }}</h2>
    <form v-on:submit.prevent>
      <input type="text" v-model="newItem" />
      <button v-on:click="addItem">Add</button>
    </form>
    <table>
      <tr>
        <th>ID</th>
        <th>NAME</th>
        <th>STATE</th>
        <th>NEXT</th>
        <th>DELETE</th>
      </tr>
      <tr v-for="todo in todos" v-bind:key="todo.id">
        <td>{{ todo.id }}</td>
        <td>{{ todo.name }}</td>
        <td>{{ toStateName(todo.state) }}</td>
        <td>
          <button v-on:click="taskNextState(todo.id)">
            {{ toStateName(todo.state + 1) }}
          </button>
        </td>
        <td>
          <button v-on:click="taskDelete(todo.id)">削除</button>
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
  },
  data() {
    return {
      newItem: "",
      todos: [],
    };
  },
  props: {
    msg: String,
  },
  methods: {
    addItem: function () {
      var item = this.newItem;
      if (item == "") {
        alert("タスク未入力");
        return;
      }

      var obj = {
        id: this.todos.length + 1,
        name: item,
        state: this.States.min,
      };

      this.todos.push(obj);

      /*
      this.axios
        .get("http://localhost:3000/todos")
        .then((response) => {
          alert(response.data.origin);
        })
        .catch((e) => {
          alert(e);
        });
        */
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
    },

    // Stateをみやすい名前に変換する
    toStateName: function (state) {
      var elm = this.States.array.find((f) => f.id == state);
      if (elm === undefined) return "unknow";

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
