class NewsgroupController < ApplicationController

	require 'ruby-mpns'

	skip_before_filter :verify_authenticity_token

	def index

		@newsgroup = Newsgroup.find(params[:groupid])

		current_device = params[:device]

	end

	def create

		title = params[:title]
		url = params[:url]
		description = params[:description]
		current_device = params[:device]

		feed = Newssource.new()
		feed.title = title
		feed.url = url
		feed.description = description
		feed.newsgroup_id = params[:groupid]
		feed.save!

		options = {
			title: "Creare feed",
		}

		view_context.updateDevices(params[:id] , current_device , options )

		render json: { "sucess" => true , "feed_id" => feed.id}
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

		view_context.updateDevices(params[:id] , current_device , options )

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

		view_context.updateDevices(params[:id] , current_device , options )

		render json: {"success" => true }
	end

end
