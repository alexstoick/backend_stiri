class AddImageToNewssource < ActiveRecord::Migration
  def change
    add_column :newssources, :image, :string
  end
end
