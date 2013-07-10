class NewssourceController < ApplicationController

	skip_before_filter :verify_authenticity_token

	#MULTE PROBLEME AICI
	#trebuie sa fii sigur sa deletesti un feed din grupul asta
	#deleste un feed al userului -- will be solved cand impunem auth_token


	def rename

		new_title = params[:title]

		feedid = params[:feedid]

		feed = Newssource.find( feedid )
		feed.title = new_title
		feed.save!

		render json: { "success" => true  }

	end

	def change

		new_group = params[:new_groupid]

		feedid = params[:feedid]

		feed = Newssource.find( feedid )
		feed.newsgroup_id = new_groupid
		feed.save!

		render json: { "success" => true }

	end

	def delete


		feedid = params[:feedid]

		feed = Newssource.find( feedid )

		feed.destroy!

		render json: { "success" => true }

	end


end
