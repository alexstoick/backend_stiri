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
		if ( params[:article_id].nil? )
			render json: { "error" => "No article_id parameter" }, :status => :bad_request
			return
		end
		user = User.find(params[:id])
		entry = UnreadArticle.find_by_user_id_and_article_id( params[:id] , params[:article_id] )
		entry.destroy
		render json: { "success" => true }
	end
end
