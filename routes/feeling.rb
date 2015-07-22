module Sinatra
    module Routes
        module Feeling
            get '/feelings/?' do
            	Feeling.all.to_json
            end

            get '/feelings/:id/?' do |id|
             	if id
             	 	feeling = Feeling.find(id) #.to_json

                    #the following may not work
                    feeling.felt_user = User.find(feeling.felt_user_id)
                    feeling.to_json
             	else
             	    "Error: ID not specified."
             	end
            end

            post '/feelings/?' do
            	request.body.rewind
            	j = JSON.parse(request.body.read)
            	o = Feeling.new
            	j.each do |key, value|
            		o[key] = value
            	end
            	o.save!
            	o.to_json
            end

            put '/feelings/:id/?' do |id|
               if id
            		request.body.rewind
            		j = JSON.parse(request.body.read)
            		o = Feeling.find(id)
            		j.each do |key, value|
            			o[key] = value
            		end
            		o.save!
            		o.to_json
             	else
             	    "Error: ID not specified."
             	end
            end

            delete '/feelings/:id/?' do |id|
               if id
                  o = Feeling.find(id)
                  o.destroy!
                  id
             	else
             	    "Error: ID not specified."
             	end
            end
        end
    end
end
