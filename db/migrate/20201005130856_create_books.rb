class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :series
      t.integer :lb_id
      t.string :isbn
      t.string :poster

      t.timestamps
    end
  end
end
