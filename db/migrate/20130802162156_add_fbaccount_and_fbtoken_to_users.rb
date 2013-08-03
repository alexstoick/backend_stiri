class AddFbaccountAndFbtokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fbaccount, :string
    add_column :users, :fbtoken, :string
  end
end
