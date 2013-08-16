class RemoveTitleAndDescriptionFromNewssource < ActiveRecord::Migration
	def change
		remove_column :newssources, :description
		remove_column :newssources, :title
	end
end
