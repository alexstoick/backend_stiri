BackendStiri::Application.routes.draw do

  get "unread_article/index"

  get "unread_article/delete"

	root :to => "user#index"

	match "user/login" => "user#create", :via => :post
	match "user/merge" => "user#update", :via => :put
	match "user/:id" , :to => "user#index" , :via => :get
	match "user/:id" , :to => "user#createGroup" , :via => :post
	match "user/:id/:groupid" , :to => "newsgroup#index" , :via => :get
	match "user/:id/:groupid" , :to => "newsgroup#create" , :via => :post
	match "user/:id/:groupid" , :to => "newsgroup#rename" , :via => :put
	match "user/:id/:groupid" , :to => "newsgroup#delete" , :via => :delete
	match "user/:id/:groupid/:feedid" , :to => "newssource#delete" , :via => :delete
	match 'newssource/', :to => "newssource#index", :via => :get
	match "register/", :to => "device#index"
	match "user/:id/unread", :to => "unread#index", :via => :get
	match "user/:id/unread", :to => "unread#delete", :via => :delete
end
