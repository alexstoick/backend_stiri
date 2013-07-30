class DeviceController < ApplicationController

	skip_before_filter :verify_authenticity_token

	def index

		#get device_id and user_id

		device_id = params[:device_id]
		user_id = params[:user_id]

		device = Device.new
		device.device_id = device_id
		device.user_id = user_id

		device.save!

		render json: { "success" => true , "id" => device.id }

	end

end
