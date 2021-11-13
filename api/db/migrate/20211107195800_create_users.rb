class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :login_id
      t.string :login_password
      t.string :login_token

      t.timestamps
    end
  end
end
