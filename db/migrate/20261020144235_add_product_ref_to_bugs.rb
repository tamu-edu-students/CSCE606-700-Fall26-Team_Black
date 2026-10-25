class AddProductRefToBugs < ActiveRecord::Migration[8.1]
  def change
    add_belongs_to :bugs, :project, null: false, foreign_key: true
  end
end
