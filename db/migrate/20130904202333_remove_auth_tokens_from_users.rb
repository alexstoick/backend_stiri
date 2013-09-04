class RemoveAuthTokensFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :gptoken
    remove_column :users, :fbtoken
    remove_column :users, :twtoken
    remove_column :users, :mstoken
  end

  def down
    add_column :users, :mstoken, :text
    add_column :users, :twtoken, :text
    add_column :users, :fbtoken, :text
    add_column :users, :gptoken, :text
  end
end
