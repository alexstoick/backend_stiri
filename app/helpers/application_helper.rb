module ApplicationHelper

	def updateDevices (user_id , current_device , options )

		devices = User.find( user_id ).devices
		current_device = current_device.to_i

		devices.each do |device|
			if ( device.id != current_device )

				#Rails.logger.debug( device.id.to_s() + "###"  + current_device.to_s())
				uri = device.device_id
				response = MicrosoftPushNotificationService.send_notification uri, :toast, options
				Rails.logger.debug( response )

			end
		end

	end

end
