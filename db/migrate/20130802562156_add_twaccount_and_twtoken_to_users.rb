class AddTwaccountAndTwtokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :twaccount, :string
    add_column :users, :twtoken, :text
  end
end
