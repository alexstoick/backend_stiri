class UserController < ApplicationController
	skip_before_filter :verify_authenticity_token

	require 'openssl'

	before_filter :check_auth_token , :except => :create


	def index

		user = User.find( params[:id] )
		@newsgroups = user.newsgroups
	end

	def createGroup
		user_id = params[:id]
		title = params[:title]

		if ( title.nil? )
			render json: { "error" => "Title cannot be null" }
			return
		end

		newsgroup = Newsgroup.new()
		newsgroup.title = title
		newsgroup.user_id = user_id
		newsgroup.save!

		render json: { "success" => true , "group_id" => newsgroup.id }
	end

	def create

		account = params[:account]
		token = params[:token]

		if ( account.nil? || token.nil? )
			render json: { "error" => "Wrong params"}
			return
		end
		#fb		#gp		#tw		#ms
		type = params[:type]
		new_acc = false
		wrong_token = false
		case type
			when 'fb'
				user = User.find_by_fbaccount( account )
				if ( user.nil? )
					user = User.new()
					user.fbaccount = account
					user.fbtoken = token
					new_acc = true
				else
					if ( user.fbtoken != token )
						wrong_token = true
					end
				end
			when 'gp'
				user = User.find_by_gpaccount( account )
				if ( user.nil? )
					user = User.new()
					user.gpaccount = account
					user.gptoken = token
					new_acc = true
				else
					if ( user.gptoken != token )
						wrong_token = true
					end
				end
			when 'tw'
				user = User.find_by_twaccount( account )
				if ( user.nil? )
					user = User.new()
					user.twaccount = account
					user.twtoken = token
					new_acc = true
				else
					if ( user.twtoken != token )
						wrong_token = true
					end
				end
			when 'ms'
				user = User.find_by_msaccount( account )
				if ( user.nil? )
					user = User.new()
					user.msaccount = account
					user.mstoken = token
					new_acc = true
				else
					if ( user.mstoken != token )
						wrong_token = true
					end
				end
			else
				render json: {"error" => "Wrong type of account"}
				return
		end

		if ( wrong_token )
			render json: { "error" => "Wrong token" }
			return
		end

		if ( new_acc )
				begin
					unique_key = SecureRandom.urlsafe_base64(10, true)
					exists = true
					temp = User.find_by_key( unique_key )
					if ( temp.nil? )
						exists = false
						user.key = unique_key
					end
				end while exists
			user.save!
		end
		render json: { "id" => user.id , "key" => user.key  }
	end

	def update
		id = params[:id]
		account=params[:account]
		token=params[:token]

		if ( id.nil? || account.nil? || token.nil? )
			render json: { "error" => "Wrong params" }
			return
		end

		type = params[:type]


		user = User.find(id)
		case type
			when 'fb'
				user.fbaccount = account
				user.fbtoken = token
			when 'gp'
				user.gpaccount = account
				user.gptoken = token
			when 'tw'
				user.twaccount = account
				user.twtoken = token
			when 'ms'
				user.msaccount = account
				user.mstoken = token
			else
				render json: {"error" => "Wrong type of account"}
				return
		end
		user.save!

		render json: { "id" => user.id }
	end

end
