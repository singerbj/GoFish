module Sinatra
    module Routes
        module Match
            get '/matches/?' do
            	Match.all.to_json
            end

            get '/matches/:id/?' do |id|
             	if id
             	 	match = Match.find(id) #.to_json

                    #the following may not work
                    match.first_user = User.find(match.first_user_id)
                    match.second_user = User.find(match.second_user_id)
                    match.to_json
             	else
             	    "Error: ID not specified."
             	end
            end

            post '/matches/?' do
            	request.body.rewind
            	j = JSON.parse(request.body.read)
            	o = Match.new
            	j.each do |key, value|
            		o[key] = value
            	end
            	o.save!
            	o.to_json
            end

            put '/matches/:id/?' do |id|
               if id
            		request.body.rewind
            		j = JSON.parse(request.body.read)
            		o = Match.find(id)
            		j.each do |key, value|
            			o[key] = value
            		end
            		o.save!
            		o.to_json
             	else
             	    "Error: ID not specified."
             	end
            end

            delete '/matches/:id/?' do |id|
               if id
                  o = Match.find(id)
                  o.destroy!
                  id
             	else
             	    "Error: ID not specified."
             	end
            end
        end
    end
end
