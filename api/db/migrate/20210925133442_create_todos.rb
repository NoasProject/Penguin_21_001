class CreateTodos < ActiveRecord::Migration[6.1]
  def change
    create_table :todos do |t|
      t.integer :user_id
      t.integer :group_id
      t.integer :state
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
