<template>
  <div>
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  created() {
    this.$router.push("/login");
  },
  data() {
    return {
      cookiesKey: {
        loginToken: "login-token",
      },
    };
  },
  watch: {
    $route: function (to, from) {
      // 処理しない
      if (to.name == "login" || to.name == "") {
        return;
      }
      console.log(to);
      console.log(from);

      // 移動した場合に処理する
      if (to.path !== from.path) {
        // トークンがない場合はトップページに戻す
        if (this.$cookies.isKey(this.cookieKey.loginToken) == false) {
          console.log("Tokenが存在するため、Tokenログインを行います");
          this.toLogin();
        }
        // トークンが存在する
        else {
          console.log("tokenが存在しません.");
        }
      }
    },
  },
  methods: {
    toLogin() {
      this.$router.push("/login");
    },
  },
};
</script>