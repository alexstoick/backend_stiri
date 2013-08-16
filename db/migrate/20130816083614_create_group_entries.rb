class CreateGroupEntries < ActiveRecord::Migration
  def change
    create_table :group_entries do |t|
      t.integer :newssource_id
      t.integer :newsgroup_id

      t.timestamps
    end
  end
end
