class AddUserToNewsgroups < ActiveRecord::Migration
  def change
    add_column :newsgroups, :user_id, :integer
  end
end
