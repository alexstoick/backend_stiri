class Newsgroup < ActiveRecord::Base

	has_many :group_entries
	has_many :newssources, :through => :group_entries
	belongs_to :user
end
