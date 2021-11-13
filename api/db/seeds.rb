# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do |i|
  Todo.create(title: "Todo-発行#{i + 1}", description: "TODO説明文#{i + 1}", state: 1)
end

3.times do |i|
  Todo.create(title: "Todo-進行中#{i + 1}", description: "TODO説明文#{i + 1}", state: 2)
end

4.times do |i|
  Todo.create(title: "Todo-完了#{i + 1}", description: "TODO説明文#{i + 1}", state: 3)
end

4.times do |i|
  Todo.create(title: "Todo-アーカイブ#{i + 1}", description: "TODO説明文#{i + 1}", state: 9)
end

# User Created
User.create(name: "Tanaka", login_id: "test001", login_password: "test001", login_token:"token")
