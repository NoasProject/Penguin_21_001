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
          <button v-on:click="nextState(todo.id)">
            {{ toStateName(todo.state + 1) }}
          </button>
        </td>
        <td>
          <button v-on:click="changeState(todo.id, 9)">削除</button>
        </td>
      </tr>
    </table>
  </div>
</template>

<script>
export default {
  name: "TodoTop",
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
        state: 0,
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

    // 次の状態に変更する
    nextState: function (id) {
      var findElement = this.todos.find((todo) => todo.id == id);
      var nextState = findElement.state + 1;
      if (nextState > 2) {
        console.log("overflow range error.");
        return;
      }
      return this.changeState(id, findElement.state + 1);
    },

    // 状態を変更する
    changeState: function (id, state) {
      var findElement = this.todos.find((todo) => todo.id == id);
      findElement.state = state;
    },

    // Stateをみやすい名前に変換する
    toStateName: function (state) {
      switch (state) {
        case 0:
          return "タスク";
        case 1:
          return "進行中";
        case 2:
          return "完了";
        case 9:
          return "対応しない";
        default:
          return "unkwon";
      }
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
