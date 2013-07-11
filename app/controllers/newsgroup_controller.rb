class NewsgroupController < ApplicationController

	skip_before_filter :verify_authenticity_token

	def index

		@newsgroup = Newsgroup.find(params[:groupid])

	end

	def create

		title = params[:title]
		url = params[:url]
		description = params[:description]

		feed = Newssource.new()
		feed.title = title
		feed.url = url
		feed.description = description
		feed.newsgroup_id = params[:groupid]
		feed.save!

		render json: { "sucess" => true , "feed_id" => feed.id}
	end

	def rename

		new_title = params[:title]

		newsgroup = Newsgroup.find( params[:groupid] )
		newsgroup.title = new_title
		newsgroup.save!

		render json: { "success" => true }

	end

	def delete

		groupid = params[:groupid]

		newsgroup = Newsgroup.find( params[:groupid] )
		newsgroup.newssources.each do |feed|
			feed.destroy
		end

		newsgroup.destroy
		render json: {"success" => true }
	end

end
