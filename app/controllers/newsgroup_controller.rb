class NewsgroupController < ApplicationController

	require 'open-uri'
	require 'base64'
	require 'openssl'

	skip_before_filter :verify_authenticity_token

	before_filter :check_auth_token
	before_filter :check_group_holder , :except => :create

	def index
		newsgroup = Newsgroup.find(params[:groupid])
		@newssources = newsgroup.newssources
	end

	def create
		user_id = params[:id]
		title = params[:title]

		if ( title.nil? )
			render json: { "error" => "Title cannot be null" }, :status => :bad_request
			return
		end

		newsgroup = Newsgroup.new()
		newsgroup.title = title
		newsgroup.user_id = user_id
		newsgroup.save!

		render json: { "success" => true , "group_id" => newsgroup.id }
	end

	def rename

		new_title = params[:title]

		newsgroup = Newsgroup.find( params[:groupid] )
		newsgroup.title = new_title
		newsgroup.save!

		options = {
			title: "Redenumire grup",
		}

		render json: { "success" => true }

	end

	def delete

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
