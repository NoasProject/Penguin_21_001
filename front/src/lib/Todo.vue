<template>
  <div id="todo">
    <TodoTop msg="TODO一覧" />
  </div>
</template>

<script>
import TodoTop from "../components/TodoTop.vue";

export default {
  name: "todo",
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
