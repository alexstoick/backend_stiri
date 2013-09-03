class NewssourceController < ApplicationController

	skip_before_filter :verify_authenticity_token

	before_filter :check_auth_token
	before_filter :check_group_holder

	def index
		@feeds = Newssource.all
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
