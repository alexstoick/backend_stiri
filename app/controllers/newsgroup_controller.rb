class NewsgroupController < ApplicationController

	require 'open-uri'
	require 'base64'
	require 'openssl'

	skip_before_filter :verify_authenticity_token

	def index
		newsgroup = Newsgroup.find(params[:groupid])
		@newssources = newsgroup.newssources
	end

	def create

		url = params[:url]

		if ( url.nil? )
			render json: {"error" => "Wrong params"}
			return
		end

		conn = view_context.get_connection()
		neo4j_user = view_context.get_user( params[:id] , conn )

		feed = Newssource.find_by_url( url )

		if ( feed.nil? )

			feed = Newssource.new()
			feed.url = url

			link = 'http://37.139.8.146:3000/title/?url=' + url
			content = open( link ).read()
			parsed = JSON.parse(content)

			if ( parsed["error"].nil? )
				feed.title = parsed["title"]
				feed.image = parsed["image"]
				feed.save!
			else
				render json: { "error" => parsed["error"] }
				return
			end

		end

		neo4j_feed = view_context.get_feed( feed.id , conn )
		view_context.create_relationship( neo4j_feed , neo4j_user , conn )

		entry = GroupEntry.find_by_newssource_id_and_newsgroup_id( feed.id , params[:groupid] )

		if ( entry.nil? )
			entry = GroupEntry.new()
			entry.newssource_id = feed.id
			entry.newsgroup_id = params[:groupid]
			entry.save!
		end

		render json: { "id" => feed.id , "title" => feed.title , "image" => feed.image }
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

		current_device = params[:device]

		conn = view_context.get_connection()
		neo4j_user = view_context.get_user( params[:id] , conn )


		entries = GroupEntry.find_all_by_newsgroup_id( params[:groupid] )

		entries.each do |entry|

			neo4j_feed = view_context.get_feed( entry.newssource_id , conn )
			view_context.delete_relationship( neo4j_feed , neo4j_user , conn )

			entry.destroy
		end

		newsgroup = Newsgroup.find( params[:groupid] )
		newsgroup.destroy

		options = {
			title: "Stergere grup",
		}

		render json: {"success" => true }
	end

end
