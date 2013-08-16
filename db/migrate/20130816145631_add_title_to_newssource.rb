class AddTitleToNewssource < ActiveRecord::Migration
  def change
    add_column :newssources, :title, :string
  end
end
