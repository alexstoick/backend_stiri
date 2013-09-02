class NewssourceController < ApplicationController

	skip_before_filter :verify_authenticity_token

	#MULTE PROBLEME AICI
	#trebuie sa fii sigur sa deletesti un feed din grupul asta
	#deleste un feed al userului -- will be solved cand impunem auth_token

	def index

		key = params[:key]
		encrypted = params[:token]
		decripted_key = Base64.decode64( key )

		encrypted="Vvaz86qhQm1T2t9SXwvwlMRu+cAKPywUBQYvBxhAgYOZzoWGEJ0heeNY37V5V1J2zTRjsqoDNUjsRkQ0RDHDL03Kh51EefDNpWlzlxb0UsycXkQt2P+6FChzjlpvzVlFSY0Pz4MC3rxq33IU8IvboswiXlKjUkK0FdLADBmk+S99b4yZXrt1HNWlvMeQso9d4JfRC5krvvWTU0FhYDHS3PQlrrLmRulGgxqm1F/nn/n
FX6z+7GNWxab/uJYdilv1Pjyr6HVm+uT2/d6gkFaZwkJusArypuH1TWI449+pZXCfrEpqEI3LQIjPzedmjfFrcweOV/2BMR8W+Bwc+f2/Qw=="

		user = User.find_by_public_key ( decripted_key )

		puts user.id
		puts encrypted

		private_key = OpenSSL::PKey::RSA.new( user.private_key , ENV['SECRET_KEY'] )
		decripted_string = private_key.private_decrypt(Base64.decode64(encrypted))

		render json: { "result" => decripted_string }
		return

		@feeds = Newssource.all
	end

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
