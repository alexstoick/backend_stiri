class User < ActiveRecord::Base

	has_many :newsgroups
	has_many :devices

end
