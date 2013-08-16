class NewsgroupController < ApplicationController

	require 'ruby-mpns'
	require 'open-uri'


	skip_before_filter :verify_authenticity_token

	def index

		@newsgroup = Newsgroup.find(params[:groupid])

		current_device = params[:device]

	end

	def create

		url = params[:url]

		if ( url.nil? )
			render json: {"error" => "Wrong params"}
			return
		end

		feed = Newssource.find_by_url( url )

		if ( ! feed.nil? )
			render json: { "id" => feed.id }
			return
		end

		feed = Newssource.new()
		feed.url = url

		link = 'http://localhost:3000/title/?url=' + url
		content = open( link ).read()

		parsed = JSON.parse( content )
		title = parsed["feedTitle"]
		feed.title = title

		feed.save!

		render json: { "sucess" => true , "id" => feed.id}
	end

	def rename

		new_title = params[:title]
		current_device = params[:device]

		newsgroup = Newsgroup.find( params[:groupid] )
		newsgroup.title = new_title
		newsgroup.save!

		options = {
			title: "Redenumire grup",
		}

		render json: { "success" => true }

	end

	def delete

		groupid = params[:groupid]
		current_device = params[:device]


		newsgroup = Newsgroup.find( params[:groupid] )
		newsgroup.newssources.each do |feed|
			feed.destroy
		end

		newsgroup.destroy

		options = {
			title: "Stergere grup",
		}

		render json: {"success" => true }
	end

end
