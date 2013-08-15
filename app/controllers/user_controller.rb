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

		gplusaccount = params[:gplusaccount]
		gplustoken = params[:gplustoken]

		fbaccount = params[:fbaccount]
		fbtoken = params[:fbtoken]

		msaccount = params[:msaccount]
		mstoken = params[:mstoken]

		##BETTER GENERATE DYNAMIC VARIABLE NAMES... 

		##FUCK MY LIFE

		if ( fbaccount.nil? )
			if ( gplusaccount.nil? )
				account = msaccount
				token = mstoken
				type="fb"
			else
				account = gplusaccount
				token = gplustoken
				type="g+"
			end
		else
			account = fbaccount
			token = fbtoken
			type="ms"
		end

		@user = User.find_by_msaccount ( account )
		if ( @user.nil? )
			@user = User.new()
			if ( type == "ms" )
				@user.msaccount = account
				@user.mstoken = token
			else
				if ( type="fb")
					@user.fbaccount = fbaccount
					@user.fbtoken = token
				else
					@user.fbaccount = gplusaccount
					@user.fbtoken = gplustoken
				end
			end
			@user.save!
		end
	end

	def update
		#add a different account
	end

end
