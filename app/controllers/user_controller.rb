class UserController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def index
		#show all feeds
		@user = User.find( params[:id] )
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

		#fb		#gp		#tw		#ms
		type = params[:type]

		case type
			when 'fb'
				@user = User.find_by_fbaccount ( account )
				if ( @user.nil? )
					@user = User.new()
					@user.fbaccount = account
					@user.fbtoken = token
				end
			when 'gp'
				@user = User.find_by_gpaccount ( account )
				if ( @user.nil? )
					@user = User.new()
					@user.gpaccount = account
					@user.gptoken = token
				end
			when 'tw'
				@user = User.find_by_twaccount ( account )
				if ( @user.nil? )
					@user = User.new()
					@user.twaccount = account
					@user.twtoken = token
				end
			when 'ms'
				@user = User.find_by_msaccount ( account )
				if ( @user.nil? )
					@user = User.new()
					@user.msaccount = account
					@user.mstoken = token
				end
		end
		@user.save!
	end

	def update
		#add a different account
	end

end
