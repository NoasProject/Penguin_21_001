<template>
  <div id="todo">
    <img alt="Vue logo" src="../assets/logo.png" />
    <TodoTop msg="Welcome to Your Vue.js App" />
  </div>
</template>

<script>
import TodoTop from "../components/TodoTop.vue";

export default {
  name: "Todo",
  components: {
    TodoTop,
  },
};
</script>

<style>
#todo {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
