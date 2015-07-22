post '/feelings/?' do
	request.body.rewind
	j = JSON.parse(request.body.read)
	o = Feeling.new
	j.each do |key, value|
		o[key] = value
	end
	o.save!
	o.to_json

	if o.
		f = Feeling.where(user_id: o.owner_id, owner_id: o.user_id)

		if f
			m = Match.new
			m.first_user_id = o.owner_id
			m.second_user_id = o.user_id
			m.time = DateTime.new
		end
	end
end



# get '/feelings/?' do
# 	Feeling.all.to_json
# end
#
# put '/feelings/:id/?' do |id|
#    if id
# 		request.body.rewind
# 		j = JSON.parse(request.body.read)
# 		o = Feeling.find(id)
# 		j.each do |key, value|
# 			o[key] = value
# 		end
# 		o.save!
# 		o.to_json
#  	else
#  	    "Error: ID not specified."
#  	end
# end
#
# get '/feelings/:id/?' do |id|
#  	if id
#  	 	feeling = Feeling.find(id) #.to_json
#
#         #the following may not work
#         feeling.felt_user = User.find(feeling.felt_user_id)
#         feeling.to_json
#  	else
#  	    "Error: ID not specified."
#  	end
# end
#
# delete '/feelings/:id/?' do |id|
#    if id
#       o = Feeling.find(id)
#       o.destroy!
#       id
#  	else
#  	    "Error: ID not specified."
#  	end
# end
