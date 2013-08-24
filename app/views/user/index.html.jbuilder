
json.array! @newsgroups do |group|

	json.group_title group.title
	json.group_id group.id
	json.group_feeds group.newssources, :url, :title , :id

end