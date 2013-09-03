require 'neography'

module ApplicationHelper

	def get_connection
		Neography.configure do |config|
		  config.protocol       = "http://"
		  config.server         = "37.139.8.146"
		  config.port           = 7474
		  config.directory      = ""  # prefix this path with '/'
		  config.cypher_path    = "/cypher"
		  config.gremlin_path   = "/ext/GremlinPlugin/graphdb/execute_script"
		  config.log_file       = "@neography.log"
		  config.log_enabled    = false
		  config.max_threads    = 20
		  config.authentication = nil  # 'basic' or 'digest'
		  config.username       = nil
		  config.password       = nil
		  config.parser         = MultiJsonParser
		end

		neo = Neography::Rest.new()
		return neo
	end

	def get_feed ( id , conn )

		feed = Neography::Node.find( "feed" , "id" , id )

		if ( feed.nil? )
			puts "Feed does not exist"

			feed = Neography::Node.create( "feed_id" => id )
			conn.add_node_to_index( "feed" , "id" , id , feed )
			conn.add_label( feed , "feed" )

			puts "Created feed with id " + feed.neo_id

			return feed
		else
			puts "Feed exists with id " + feed.neo_id
			return feed
		end

	end

	def get_user ( id , conn )
		user = Neography::Node.find( "user" , "id" , id )

		if ( user.nil? )
			puts "User does not exist"

			user = Neography::Node.create( "user_id" => id )
			conn.add_node_to_index( "user" , "id" , id , user )
			conn.add_label( user , "user")

			puts "Created user with id " + user.neo_id

			return user
		else
			puts "User exists with id " + user.neo_id
			return user
		end
	end

	def create_relationship ( feed , user , conn )
		if ( conn.get_node_relationships_to( feed, user ).nil? )
			feed.outgoing(:subscribed) << user
			puts "Created relationship"
		else
			puts "Relationship exists"
		end
	end

	def delete_relationship ( feed , user , conn )
		rel = conn.get_node_relationships_to( feed, user )
		if ( ! rel.nil? )
			conn.delete_relationship( rel )
			puts "Deleted relationship"
		else
			puts "Relationship does not exist"
		end
	end
end
