class AddRoleToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :role, :string, default: "user", null: false

    add_check_constraint :users, "role IN ('user', 'admin')", name: "role_check"
  end
end
