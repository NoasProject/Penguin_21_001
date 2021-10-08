class CreateTodos < ActiveRecord::Migration[6.1]
  def change
    create_table :todos do |t|
      t.integer :group_id
      t.integer :state
      t.string :title

      t.timestamps
    end
  end
end
