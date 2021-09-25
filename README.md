要件
1. localhost:8000にアクセスをすると、タスク作成用の入力フォームが１つと、現在の「todo」のタスク一覧が表示される。「選択したタスクを完了」のボタンを設置
2. それぞれのタスクは編集・更新ができる。編集ボタンを押すと、タスクの文字列部分がフォームに変わり、編集できる。編集完了後エンターを押すと編集が完了する。
3. それぞれのタスクは、削除も行える。タスクの文字列の右側に、削除ボタンを設け、削除ボタンを押すとタスクが削除される。
4. タスク作成用のフォームにタスクを入力後エンターを押すと、新たにタスクが追加され、タスクリストに追加される。
5. タスクにチェックをいれ、「選択したタスクを完了」を押すと、タスクのステータスが完了となり、表示されなくなる。

システム要件
* Dockerを使用し、コンテナをVuejsコンテナ、Rails6のAPIサーバーコンテナ、Mysqlコンテナの３つを作成する。
* Dockerコンテナやdokcer-composeファイルから管理を行う。
* APIサーバーのポートは3000番を使用する。
* Mysqlのポートは、3306を使用し、Mysqlのユーザーは適当で良い。
* データベース名は、todoなど適当で良い。
* Vuejsのポートは8000番を使用する。
* 余力があれば、bootstrapを入れ、UIもある程度使いやすいようにする。
* Vueアプリはvue-cliを使用し、バージョン2で実装すること

DB要件
* テーブルはtaskテーブルを１つ作成し、カラムは、id, title(string)とstate(tiny int or string)、created_at(作成時間), updated_at(更新時間)の5つのカラムとする。
* stateではタスクの完了状態を管理し、状態は、「todo」「done」の２値とする。

```
環境構築時に参考にした記事
-- 
https://qiita.com/Kyou13/items/be9cdc10c54d39cded15

詰まったところ
-- バージョンが新しいため発生した問題
　- ruby:2.7.1 -> ruby:2.6.6 にダウングレード

-- rails new でエラーになる
　- この前に docker-compose builde を行えばok
```

```
mysql が繋がらなくなった時の改善時に参考にしたドキュメントたち

-- DBがない場合に作成する
https://kitsune.blog/docker-network
↑で解決


-- 
https://teratail.com/questions/296899
```

```
// これで作成する
rails g scaffold

型一覧については下記参考
rails g scaffold Todo group_id:integer state:integer title:string
https://qiita.com/s_tatsuki/items/900d662a905c7e36b3d4
```

