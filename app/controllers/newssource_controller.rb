class NewssourceController < ApplicationController

	skip_before_filter :verify_authenticity_token

	before_filter :check_auth_token , :except => [ :index, :select ]
	before_filter :check_group_holder , :except => [ :index, :select ]

	def index
		@feeds = Newssource.select('url, id, category, title, image, subscribers').order('subscribers DESC').all
		@categories = Newssource.uniq.pluck(:category)
	end

	def select
		@feeds = Newssource.select('url, id').find_all_by_category(params[:category])
	end

	def create

		url = params[:url]
		if ( url.nil? )
			render json: {"error" => "Wrong params"}, :status => :bad_request
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
				render json: { "error" => parsed["error"] }, :status => :bad_request
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


	def delete


		feed_id = params[:feedid]
		current_device = params[:device]
		group_id = params[:groupid]

		conn = view_context.get_connection()
		neo4j_user = view_context.get_user( params[:id] , conn )

		neo4j_feed = view_context.get_feed( feed_id , conn )
		view_context.delete_relationship( neo4j_feed , neo4j_user , conn )

		feed = GroupEntry.find_by_newssource_id_and_newsgroup_id( feed_id , group_id )
		feed.destroy

		options = {
			title: "Stergere feed"
		}

		render json: { "success" => true }

	end

end
