BackendStiri::Application.routes.draw do

	root :to => "user#index"

	match "user/login" => "user#create", :via => :post
	match "user/login" => "user#update", :via => :put
	match "user/:id" , :to => "user#index" , :via => :get
	match "user/:id" , :to => "user#createGroup" , :via => :post
	match "user/:id/:groupid" , :to => "newsgroup#index" , :via => :get
	match "user/:id/:groupid" , :to => "newsgroup#create" , :via => :post
	match "user/:id/:groupid" , :to => "newsgroup#rename" , :via => :put
	match "user/:id/:groupid" , :to => "newsgroup#delete" , :via => :delete
	match "user/:id/:groupid/:feedid" , :to => "newssource#rename" , :via => :put
	match "user/:id/:groupid/:feedid" , :to => "newssource#change" , :via => :patch
	match "user/:id/:groupid/:feedid" , :to => "newssource#delete" , :via => :delete
	match "register/", :to => "device#index"
end
