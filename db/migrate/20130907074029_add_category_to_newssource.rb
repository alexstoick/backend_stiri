class AddCategoryToNewssource < ActiveRecord::Migration
  def change
  	add_column :newssources, :category, :string
  end
end
