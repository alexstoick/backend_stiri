class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :url
      t.string :title
      t.string :description
      t.string :text

      t.timestamps
    end
  end
end
