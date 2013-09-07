BackendStiri::Application.routes.draw do

	match "user/login" => "user#create", :via => :post
	match "user/merge" => "user#update", :via => :put
	match "user/:id" , :to => "user#index" , :via => :get
	match "user/:id" , :to => "newsgroup#create" , :via => :post
	match "user/:id/unread", :to => "unread_article#index", :via => :get
	match "user/:id/unread", :to => "unread_article#delete", :via => :delete
	match "user/:id/:groupid" , :to => "newsgroup#index" , :via => :get
	match "user/:id/:groupid" , :to => "newsgroup#rename" , :via => :put
	match "user/:id/:groupid" , :to => "newsgroup#delete" , :via => :delete
	match "user/:id/:groupid" , :to => "newssource#create" , :via => :post
	match "user/:id/:groupid/:feedid" , :to => "newssource#delete" , :via => :delete
	match 'newssource/', :to => "newssource#index", :via => :get
	match 'newssource/:category/', :to => "newssource#select", :via => :get
	match "register/", :to => "device#index"

end
