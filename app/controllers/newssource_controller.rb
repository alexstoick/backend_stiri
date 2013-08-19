class NewssourceController < ApplicationController

	skip_before_filter :verify_authenticity_token

	#MULTE PROBLEME AICI
	#trebuie sa fii sigur sa deletesti un feed din grupul asta
	#deleste un feed al userului -- will be solved cand impunem auth_token

	def change

		new_group = params[:new_groupid]
		current_device = params[:device]
		feedid = params[:feedid]

		feed = Newssource.find( feedid )
		feed.newsgroup_id = new_groupid
		feed.save!

		options = {
			title: "Schimbare grup feed"
		}

		#view_context.updateDevices(params[:id] , current_device , options )

		render json: { "success" => true }

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

		#view_context.updateDevices(params[:id] , current_device , options )

		render json: { "success" => true }

	end

end
