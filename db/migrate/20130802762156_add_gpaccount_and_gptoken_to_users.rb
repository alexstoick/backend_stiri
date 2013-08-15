class AddGpaccountAndGptokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gpaccount, :string
    add_column :users, :gptoken, :text
  end
end
