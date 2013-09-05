class UnreadArticle < ActiveRecord::Base
  attr_accessible :article_id, :newsgroup_id, :user_id
  belongs_to :user
end
