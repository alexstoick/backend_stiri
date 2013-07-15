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

		#daca e null cautam twacc,
		msaccount = params[:msaccount]
		mstoken = params[:mstoken]

		@user = User.find_by_msaccount ( msaccount )
		if ( @user.nil? )
			@user = User.new()
			@user.msaccount = msaccount
			@user.mstoken = mstoken
			@user.save!
		end
	end

	def update
		#add a different account
	end

end
