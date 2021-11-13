<template>
  <div>
    <TodoTop></TodoTop>
  </div>
</template>

<script>
import TodoTop from "../components/TodoTop.vue";
export default {
  components: {
    TodoTop,
  },
  methods: {},
  beforeRouteUpdate(to, from, next) {
    //再描画前のアクション
    next();
    //再描画後のアクション
  },
};
</script>