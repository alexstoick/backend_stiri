class NewsgroupController < ApplicationController

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

		conn = view_context.get_connection()
		neo4j_user = view_context.get_user( params[:id] , conn )

		feed = Newssource.find_by_url( url )

		if ( feed.nil? )

			feed = Newssource.new()
			feed.url = url

			link = 'http://37.139.8.146:3500/title/?url=' + url
			title = open( link ).read()

			feed.title = title

			feed.save!

		end

		neo4j_feed = view_context.get_feed( feed.id , conn )
		view_context.create_relationship( neo4j_feed , neo4j_user , conn )


		entry = GroupEntry.new()
		entry.newssource_id = feed.id
		entry.newsgroup_id = params[:groupid]
		entry.save!


		render json: { "id" => feed.id , "entry_id" => entry.id , "title" => feed.title }
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
