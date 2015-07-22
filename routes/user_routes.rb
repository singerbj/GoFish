get '/users/?' do
	User.all.to_json
end

get '/users/:id/?' do |id|
 	if id
 	 	User.find(id).to_json
 	else
 	    "Error: ID not specified."
 	end
end

get '/users/:id/matches/?' do |id|
 	if id
 	 	Match.where(first_user_id: id).concat(Match.where(second_user_id: id))
 	else
 	    "Error: ID not specified."
 	end
end

post '/users/?' do
	request.body.rewind
	j = JSON.parse(request.body.read)
	o = User.new
	j.each do |key, value|
		o[key] = value
	end
	o.save!
	o.to_json
end

put '/users/:id/?' do |id|
    if id
		request.body.rewind
		j = JSON.parse(request.body.read)
		o = User.find(id)
		j.each do |key, value|
			o[key] = value
		end
		o.save!
		o.to_json
 	else
 	    "Error: ID not specified."
 	end
end

delete '/users/:id/?' do |id|
    if id
      o = User.find(id)
      o.destroy!
      id
 	else
 	    "Error: ID not specified."
 	end
end
