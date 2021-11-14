<template>
  <div>
    <form v-on:submit.prevent>
      <p>
        <label for="title">タイトル</label>
        <input type="text" v-model="task.title" />
      <br>
        <label for="description">説明文</label>
        <input type="text" v-model="task.description" />
      <br>
      
      <!-- タイトルだけは必須入力 -->
      <b-button :disabled="task.title == ''" variant="success" style="width:10%;" v-on:click="createTodo()">追加する</b-button>
      <b-button variant="danger" style="width:10%;" v-on:click="onLogout()">ログアウト</b-button>
      </p>
    </form>
    <b-table
      :fields="fields"
      :items="todos">

      <!-- タイトル -->
      <template v-slot:cell(title)="data">
        <div @click="edit_id.title = data.item.id">
          <p v-if="edit_id.title == data.item.id">
            {{ data.item.title }}
          </p>
          <p v-else>
            {{ data.item.title }}
          </p>
        </div>
      </template>

      <!-- 説明文 -->
      <template v-slot:cell(description)="data">
        <div @click="onClickDescription(data.item.id)">
          <p v-if="edit_id.description == data.item.id">
            <input type="text" v-model="task.description" />
          </p>
          <p v-else>
            {{ data.item.description }}
          </p>
        </div>
      </template>

      <!-- 状態 -->
      <template v-slot:cell(state)="data">
        <p>
          {{ state.names[data.item.state] }}
        </p>
      </template>

      <!-- 操作 -->
      <template v-slot:cell(operation)="data">
        <div v-if="data.item.state < state.complete">
          <b-button size="sm" @click="updateTodo(data.item.id, data.item.state + 1)" class="mr-1" variant="success">
            {{ state.names[data.item.state + 1] }}
          </b-button>
        </div>
        <div v-else>
          <b-button size="sm" disabled @click="updateTodo(data.item.id, data.item.state + 1)" class="mr-1" variant="success">
            ---
          </b-button>
        </div>
      </template>

      <!-- 削除 -->
      <template v-slot:cell(destroy)="data">
        <b-button size="sm" @click="destroyTodo(data.item.id)" class="mr-1" variant="danger">
          削除
        </b-button>
      </template>

    </b-table>
  </div>
</template>

<script>
export default {
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
  props: {},
  methods: {
    // <---- API
    // タスクの一覧を取得する
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
        })
        .catch((e) => {
          alert(e);
        });
    },

    // タスクを追加する
    createTodo: function () {
      var p = this.task;
      p.login_token = this.loginToken;
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
    updateTodo: function (id, state) {
      var todo = this.todos.find((f) => f.id == id);
      if (todo === undefined) {
        console.log("Not Found Id. #{id}");
        return;
      }
      todo.state = state;
      this.axios
        .patch("http://localhost:3000/todos/" + id, {
          login_token: this.loginToken,
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
      var todo = this.todos.find((f) => f.id == id);
      if (todo === undefined) {
        console.log("Not Found Id. #{id}");
        return;
      }

      this.axios
        .delete("http://localhost:3000/todos/" + id, {
          params: {
            login_token: this.loginToken,
          },
        })
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

    onClickDescription: function (id) {
      console.log("onClickDescription: " + id);
      this.edit_id.description = Number(id);
    },

    onLogout: function () {
      this.$cookies.remove("login-token");
      alert("ログアウトを行いました");

      this.$router.push("/login");
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
