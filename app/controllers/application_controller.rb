class ApplicationController < ActionController::Base
	protect_from_forgery

	private
		def check_auth_token
			user_id = params[:id]
			token = params[:key]
			if ( token.nil? )
				render json: { "error" => "Missing KEY parameter" }, :status => :unauthorized
				return
			else
				user = User.find(user_id)
				if ( user.key != token )
					render json: { "error" => "Wrong KEY" }, :status => :unauthorized
					return
				end
			end
		end
		def check_group_holder
			user_id = params[:id]
			group_id = params[:groupid]

			group = Newsgroup.find_by_user_id_and_id( user_id , group_id )
			if ( group.nil? )
				render json: { "error" => "Group does not belond to user" }, :status => :unauthorized
			end
		end


end
