class Newsgroup < ActiveRecord::Base

	has_many :newssources
	belongs_to :user
end
