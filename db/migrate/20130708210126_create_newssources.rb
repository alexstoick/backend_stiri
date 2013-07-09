class CreateNewssources < ActiveRecord::Migration
  def change
    create_table :newssources do |t|
      t.string :url
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
