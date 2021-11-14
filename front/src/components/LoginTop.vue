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
      <b-button :disabled="login.id == '' || login.password == ''" variant="success" style="width:30%;" v-on:click="onLogin()">
        ログイン
      </b-button>
      </p>
    </form>
  </div>
</template>

<script>
export default {
  created() {
    console.log(this.$cookies.get("login-token"));

    if (this.$cookies.isKey("login-token")) {
      this.toTodos();
      console.log("Tokenが存在するため、Tokenログインを行います");
    }
    // トークンが存在しない
    else {
      console.log("tokenが存在しません");
    }
  },
  data() {
    return {
      login: {
        id: "",
        password: "",
        name: undefined,
        token: undefined,
      },
    };
  },
  props: {},
  methods: {
    // ログイン処理
    onLogin: function () {
      var p = {
        name: this.login.name,
        login_id: this.login.id,
        login_password: this.login.password,
      };

      this.axios
        .post("http://localhost:3000/users/login", p)
        .then((response) => {
          var payload = response.data;
          console.log(payload);
          this.login.token = payload.login_token;
          if (this.login.token == "" || this.login.token == undefined) {
            return;
          }
          this.$cookies.set("login-token", this.login.token, { expires: 5 });
          this.toTodos();
        })
        .catch((e) => {
          alert(e);
        });
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
