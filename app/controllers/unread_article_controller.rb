class UnreadArticleController < ApplicationController

	#before_filter :check_auth_token

	def index
		#trebuie returnat article_id
		user = User.find(params[:id])
		newssources = user.newssources.pluck(:id)
		articles = user.unread_articles.where(newsgroup_id: newssources).pluck(:article_id)
		render json: { "articles" => articles }
	end

	def delete
	end
end
