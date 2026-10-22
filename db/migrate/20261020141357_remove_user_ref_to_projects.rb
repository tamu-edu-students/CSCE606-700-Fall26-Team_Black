class RemoveUserRefToProjects < ActiveRecord::Migration[8.1]
  def change
    remove_reference :projects, :bugs, foreign_key: true
  end
end
