class UserController < ApplicationController
	skip_before_filter :verify_authenticity_token

	require 'openssl'

	def index
		#show all feeds
		user = User.find( params[:id] )
		@newsgroups = user.newsgroups
	end

	def createGroup
		#create a new group

		#check for the goddamn auth token
		user_id = params[:id]
		title = params[:title]

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
		case type
			when 'fb'
				user = User.find_by_fbaccount ( account )
				if ( user.nil? )
					user = User.new()
					user.fbaccount = account
					user.fbtoken = token
					new_acc = true
				end
			when 'gp'
				user = User.find_by_gpaccount ( account )
				if ( user.nil? )
					user = User.new()
					user.gpaccount = account
					user.gptoken = token
					new_acc = true
				end
			when 'tw'
				user = User.find_by_twaccount ( account )
				if ( user.nil? )
					user = User.new()
					user.twaccount = account
					user.twtoken = token
					new_acc = true
				end
			when 'ms'
				user = User.find_by_msaccount ( account )
				if ( user.nil? )
					user = User.new()
					user.msaccount = account
					user.mstoken = token
					new_acc = true
				end
			else
				render json: {"error" => "Wrong type of account"}
				return
		end

		if ( new_acc )
			rsa_key = OpenSSL::PKey::RSA.new(2048)
			cipher =  OpenSSL::Cipher::Cipher.new('des3')

			puts 
			private_key = rsa_key.to_pem(cipher,ENV['SECRET_KEY'])
			public_key = rsa_key.public_key.to_pem

			user.private_key = private_key
			user.public_key = public_key

			user.save!
		end
		render json: { "id" => user.id , "key" => user.public_key  }
	end

	def update
		#add a different account

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
