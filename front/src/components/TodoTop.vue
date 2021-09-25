<template>
    <div id="todo_top">
      <h2>{{ msg }}</h2>
      <form v-on:submit.prevent>
          <input type="text" v-model="newItem">
          <button v-on:click="addItem">Add</button>
      </form>
      <ul>
        <li v-for="todo in todos" :key="index">{{todo}}</li>
      </ul>
      <pre>{{ $data }}</pre>
    </div>
</template>

<script>
export default {
  name: "TodoTop",
  props: {
    msg: String,
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
