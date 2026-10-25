class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :name

      t.timestamps
    end

    add_reference :projects, :owner, index: true
    add_foreign_key :projects, :users, column: :owner_id
  end
end
