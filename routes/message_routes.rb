get '/messages/:id/?' do |id|
 	if id
 	 	message = Message.find(id) #.to_json

        #the following may not work
        message.match = Match.find(message.match_id)
        message.user = Match.find(message.user_id)
        message.to_json
 	else
 	    "Error: ID not specified."
 	end
end

post '/messages/?' do
	request.body.rewind
	j = JSON.parse(request.body.read)
	o = Message.new
	j.each do |key, value|
		o[key] = value
	end
	o.save!
	o.to_json
end

# get '/messages/?' do
# 	Message.all.to_json
# end
#
# put '/messages/:id/?' do |id|
#    if id
# 		request.body.rewind
# 		j = JSON.parse(request.body.read)
# 		o = Message.find(id)
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
# delete '/messages/:id/?' do |id|
#    if id
#       o = Message.find(id)
#       o.destroy!
#       id
#  	else
#  	    "Error: ID not specified."
#  	end
# end
