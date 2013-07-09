class CreateNewsgroups < ActiveRecord::Migration
  def change
    create_table :newsgroups do |t|
      t.string :title

      t.timestamps
    end
  end
end
