<template>
  <div>
    <LoginTop></LoginTop>
  </div>
</template>

<script>
import LoginTop from "../components/LoginTop.vue";
export default {
  components: {
    LoginTop,
  },
  methods: {},
  beforeRouteUpdate(to, from, next) {
    //再描画前のアクション
    next();
    //再描画後のアクション
  },
};
</script>