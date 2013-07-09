
json.array! @user.newsgroups do |group|

	json.group_title group.title
	json.group_feeds group.newssources, :url, :title , :description

end