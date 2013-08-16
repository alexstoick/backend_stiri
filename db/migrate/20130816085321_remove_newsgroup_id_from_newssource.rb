class RemoveNewsgroupIdFromNewssource < ActiveRecord::Migration
  def up
    remove_column :newssources, :newsgroup_id
  end

  def down
    add_column :newssources, :newsgroup_id, :string
  end
end
