get '/users/:id/?' do |id|
 	if id
 	 	User.find(id).to_json
 	else
 	    "Error: ID not specified."
 	end
end

get '/my_matches/?' do
    current_user = User.where(fb_id: session[:current_user_id])[0]
    matches = Match.where(first_user_id: current_user['id']).concat(Match.where(second_user_id: current_user['id']))
    matches.each do |match|
        # if !match.matched_user
            if match.first_user_id != current_user.id
                match.matched_user = User.where(id: match.first_user_id)[0].to_json
            else
                match.matched_user = User.where(id: match.second_user_id)[0].to_json
            end
            # match.save!
        # end
    end
    matches.to_json
end

get '/random_user/?' do
	# request.body.rewind
	# j = JSON.parse(request.body.read)
	current_user = User.where(fb_id: session[:current_user_id])[0]
	gender_to_use = current_user['gender'] == "male" ? "female" : "male"
	u = User.where(gender: gender_to_use).shuffle[0]
	u.to_json
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
