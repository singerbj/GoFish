post '/feelings/:id/:feeling/?' do |id, feeling_str|
	current_user = User.where(fb_id: session[:current_user_id])[0]
	f = Feeling.where(user_id: current_user['id'], felt_user_id: id)
	puts "**********************#{f.inspect}, #{f.length}"
	if f.length == 0
		feeling = Feeling.new
		feeling.user_id = current_user.id
		feeling.felt_user_id = id
		feeling.feeling = feeling_str
		feeling.save!
	else
		feeling = f
	end

	if feeling_str == "like" && Feeling.where(user_id: id, felt_user_id: current_user['id'], feeling: "like").length > 0
		if !(Match.where(first_user_id: current_user['id'], second_user_id: id).length > 0) && !(Match.where(first_user_id: id, second_user_id: current_user['id']).length > 0)
			m = Match.new
			m.first_user_id = current_user['id']
			m.second_user_id = id
			m.time = DateTime.new
			m.save!
		end
	elsif feeling_str == "dislike"
		m1 = Match.where(first_user_id: current_user['id'], second_user_id: id)
		m2 = Match.where(first_user_id: id, second_user_id: current_user['id'])
		match = m1.length > 0 ? m1[0] : (m2.length > 0 ? m2[0] : nil)
		if match
			match.destroy!
		end
	end


	puts "**********************#{Feeling.all.length}"
	puts "**********************#{Match.all.length}"
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
