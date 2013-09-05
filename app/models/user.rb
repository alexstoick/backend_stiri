class User < ActiveRecord::Base
	has_many :newsgroups
	has_many :devices
	has_many :unread_articles
	has_many :newssources , :through => :newsgroups
end
