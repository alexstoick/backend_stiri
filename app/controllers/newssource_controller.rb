class NewssourceController < ApplicationController

	skip_before_filter :verify_authenticity_token

	#MULTE PROBLEME AICI
	#trebuie sa fii sigur sa deletesti un feed din grupul asta
	#deleste un feed al userului -- will be solved cand impunem auth_token

	def change

		new_group = params[:new_groupid]
		current_device = params[:device]
		feedid = params[:feedid]

		feed = Newssource.find( feedid )
		feed.newsgroup_id = new_groupid
		feed.save!

		options = {
			title: "Schimbare grup feed"
		}

		#view_context.updateDevices(params[:id] , current_device , options )

		render json: { "success" => true }

	end

	def delete


		feedid = params[:feedid]
		current_device = params[:device]

		feed = Newssource.find( feedid )
		feed.destroy

		options = {
			title: "Stergere feed"
		}

		#view_context.updateDevices(params[:id] , current_device , options )

		render json: { "success" => true }

	end

end
