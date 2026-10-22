class AddBugsToProject < ActiveRecord::Migration[8.1]
  def change
    add_reference :projects, :bugs, foreign_key: true
  end
end
