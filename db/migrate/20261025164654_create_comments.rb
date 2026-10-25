class CreateComments < ActiveRecord::Migration[8.1]
  def change
    create_table :comments do |t|
      t.string :comment

      t.timestamps
    end

    add_belongs_to :comments, :bug, foreign_key: true
    add_belongs_to :comments, :user, foreign_key: true
  end
end
