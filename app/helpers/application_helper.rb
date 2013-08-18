module ApplicationHelper

	def get_feed ( url )

		feed = Neography::Node.find( "default" , "url" , url )

		if ( feed.nil? )
			puts "Feed does not exist"

			feed = Neography::Node.create( "url" => url )
			@neo.add_node_to_index( "default" , "url" , url , feed )
			@neo.add_label( feed , "feed" )

			puts "Created feed with id " + feed.neo_id

			return feed
		else
			puts "Feed exists with id " + feed.neo_id
			return feed
		end

	end

	def get_user ( id )
		user = Neography::Node.find( "users" , "id" , id )

		if ( user.nil? )
			puts "User does not exist"

			user = Neography::Node.create( "id" => id )
			@neo.add_node_to_index( "users" , "id" , id , user )
			@neo.add_label( user , "user")

			puts "Created user with id " + user.neo_id

			return user
		else
			puts "User exists with id " + user.neo_id
			return user
		end
	end

	def create_relationship ( feed , user )
		if ( @neo.get_node_relationships_to( feed, user ).nil? )
			feed.outgoing(:subscribed) << user
			puts "Created relationship"
		else
			puts "Relationship exists"
		end
	end

end
