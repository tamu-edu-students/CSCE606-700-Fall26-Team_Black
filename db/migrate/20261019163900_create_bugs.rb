class CreateBugs < ActiveRecord::Migration[8.1]
  def change
    create_table :bugs do |t|
      t.string :title
      t.string :description
      t.string :replication
      t.string :priority
      t.string :status

      t.timestamps
    end
  end
end
