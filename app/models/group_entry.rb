class GroupEntry < ActiveRecord::Base
	attr_accessible :newsgroup_id, :newssource_id

	belongs_to :newsgroup
	belongs_to :newssource

end
