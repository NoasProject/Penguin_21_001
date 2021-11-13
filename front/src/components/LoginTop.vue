<template>
  <div>
    <form v-on:submit.prevent>
      <p>
        <label for="login_id">ログインID</label>
        <input type="text" v-model="login.id" />
      <br>
        <label for="password">ログインパスワード</label>
        <input type="text" v-model="login.password" />
      <br>
      <!-- タイトルだけは必須入力 -->
      <b-button :disabled="login.id == ''" variant="success" style="width:30%;" v-on:click="onLogin()">ログイン</b-button>
      </p>
    </form>
  </div>
</template>

<script>
export default {
  created() {
    console.log(this.$cookies.keys());

    // if (this.$cookies.isKey("login-token")) {
    //   this.toTodos();
    //   return;
    // }

    // // 5日間保存をする
    // console.log(this.$cookies.get("login-token"));
    // this.$cookies.set("login-token", "xxxxx", 5);
  },
  data() {
    return {
      login: {
        id: "",
        password: "",
        token: "",
      },
    };
  },
  props: {},
  methods: {
    // ログイン処理
    onLogin: function () {
      this.toTodos();
    },

    // TODOページへ遷移を行う
    toTodos: function () {
      this.$router.push("/todos");
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
