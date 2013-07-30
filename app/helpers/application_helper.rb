module ApplicationHelper

	def updateDevices (user_id , current_device , options )

		devices = User.find( user_id ).devices
		devices.each do |device|
			if ( device.id != current_device )

				uri = device.device_id
				response = MicrosoftPushNotificationService.send_notification uri, :toast, options
				Rails.logger.debug( response )
			end
		end

	end

end
