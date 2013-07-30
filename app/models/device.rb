class Device < ActiveRecord::Base
	attr_accessible :device_id, :user_id
	belongs_to :user
end
