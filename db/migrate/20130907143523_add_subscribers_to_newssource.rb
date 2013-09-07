class AddSubscribersToNewssource < ActiveRecord::Migration
  def change
    add_column :newssources, :subscribers, :integer
  end
end
