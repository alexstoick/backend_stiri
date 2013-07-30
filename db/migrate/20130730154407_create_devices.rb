class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :user_id
      t.string :device_id

      t.timestamps
    end
  end
end
