class AddNewsgroupToNewssource < ActiveRecord::Migration
  def change
    add_column :newssources, :newsgroup_id, :integer
  end
end
