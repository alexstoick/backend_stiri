class AddMsaccountAndMstokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :msaccount, :string
    add_column :users, :mstoken, :string
  end
end
