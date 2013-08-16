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
			entry = GroupEntry.new()
			entry.newssource_id = feed.id
			entry.newsgroup_id = params[:groupid]
			entry.save!
			render json: { "id" => feed.id , "entry_id" => entry.id , "title" => feed.title }
			return
		end

		feed = Newssource.new()
		feed.url = url

		link = 'http://37.139.8.146:3000/title/?url=' + url
		title = open( link ).read()

		feed.title = title

		feed.save!

		entry = GroupEntry.new()
		entry.newssource_id = feed.id
		entry.newsgroup_id = params[:groupid]
		entry.save!

		render json: { "entry_id" => entry.id , "id" => feed.id , "title" => title }
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
