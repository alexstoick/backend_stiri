class AddPublicKeyAndPrivateKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :public_key, :text
    add_column :users, :private_key, :text
  end
end
