class CreateUnreadArticles < ActiveRecord::Migration
  def change
    create_table :unread_articles do |t|
      t.integer :newsgroup_id
      t.integer :article_id
      t.integer :user_id
    end
  end
end
