class ApplicationController < ActionController::Base
	protect_from_forgery

	private
		def check_auth_token
			user_id = params[:id]
			token = params[:token]
			if ( token.nil? )
				render json: { "error" => "Missing token parameter" }
				return
			else
				user = User.find(user_id)
				if ( user.key != token )
					render json: { "error" => "Wrong token" }
					return
				end
			end
		end


end
