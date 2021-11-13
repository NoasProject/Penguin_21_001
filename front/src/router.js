import Vue from "vue";
import VueRouter from "vue-router";
import Login from "./views/Login.vue";
import Todo from "./views/Todo.vue";
//
// 他のコンポーネントは省略
//

Vue.use(VueRouter);

const routes = [
    // ログインページ
    {
        path: "/login",
        name: "login",
        component: Login,
    },
    // TODO一覧ページ
    {
        path: "/todos",
        name: "todos",
        component: Todo,
    }
];


console.log(process.env.BASE_URL);

const router = new VueRouter(
    {
        // デフォルトの挙動では URL に `#` が含まれる.
        // URL から hash を取り除くには `mode:history` を指定する
        mode: "history",
        // base: process.env.BASE_URL,
        routes: routes,
    }
);

export default router;