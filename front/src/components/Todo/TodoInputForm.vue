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
  </div>
</template>

<script>
export default {
  created() {},
  props: {
    loginToken: String,
    propTodos: Array,
  },
  data() {
    return {
      task: {
        title: "",
        description: "",
      },
      todos: this.propTodos,
    };
  },
  methods: {
    // タスクを追加する
    createTodo: function () {
      var p = this.task;
      p.login_token = this.loginToken;
      this.axios
        .post("http://localhost:3000/todos", p)
        .then((response) => {
          console.log(response);
          this.$emit("todos:push", response.data);
          this.task = {};
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
