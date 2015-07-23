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

put '/users/:id/?' do |id|
	begin
	    if id
			o = User.find(id)
			if o.fb_id == session[:current_user_id]
				request.body.rewind
				j = JSON.parse(request.body.read)
				o = User.find(id)
				j.each do |key, value|
					o[key] = value
				end
				o.save!
				session[:current_user] = User.where(fb_id: session[:current_user_id].to_s).to_json
				o.to_json
			else
				"You cannot edit other people's information."
			end
	 	else
	 	    "Error: ID not specified."
	 	end
	rescue Exception => e
		"{ \"error\": \"#{ e.message }\" }"
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

# get '/users/?' do
# 	User.all.to_json
# end
#
# post '/users/?' do
# 	request.body.rewind
# 	j = JSON.parse(request.body.read)
# 	o = User.new
# 	j.each do |key, value|
# 		o[key] = value
# 	end
# 	o.save!
# 	o.to_json
# end
