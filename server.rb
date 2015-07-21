require 'sinatra'
require 'json'
require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'dbfile.sqlite3')

class User < ActiveRecord::Base
end
class Match < ActiveRecord::Base
end
class Feeling < ActiveRecord::Base
end
class Message < ActiveRecord::Base
end
if !ActiveRecord::Base.connection.table_exists? 'users'
    ActiveRecord::Migration.class_eval do
        create_table :users do |t|
        t.string :name
        t.string :gender
        t.integer :age
        t.string :description
        end
    end
end
if !ActiveRecord::Base.connection.table_exists? 'matches'
    ActiveRecord::Migration.class_eval do
        create_table :matches do |t|
        t.integer :first_user_id
        t.integer :second_user_id
        end
    end
end
if !ActiveRecord::Base.connection.table_exists? 'feelings'
    ActiveRecord::Migration.class_eval do
        create_table :feelings do |t|
        t.integer :user_id
        t.integer :felt_user_id
        t.string :feeling
        end
    end
end
if !ActiveRecord::Base.connection.table_exists? 'messages'
    ActiveRecord::Migration.class_eval do
        create_table :messages do |t|
        t.integer :match_id
        t.integer :user_id
        t.string :contents
        end
    end
end
configure do
  set :bind, '0.0.0.0'
  set :public_folder, '.'
end

after { ActiveRecord::Base.connection.close }

not_found do
  request.path
end

error do
  "Error is: " + params['captures'].first.inspect
end

get "/" do
	"Hello World!"
end

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

get '/matches/?' do
	Match.all.to_json
end

get '/matches/:id/?' do |id|
 	if id
 	 	Match.find(id).to_json
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

get '/feelings/?' do
	Feeling.all.to_json
end

get '/feelings/:id/?' do |id|
 	if id
 	 	Feeling.find(id).to_json
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

get '/messages/?' do
	Message.all.to_json
end

get '/messages/:id/?' do |id|
 	if id
 	 	Message.find(id).to_json
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

put '/messages/:id/?' do |id|
   if id
		request.body.rewind
		j = JSON.parse(request.body.read)
		o = Message.find(id)
		j.each do |key, value|
			o[key] = value
		end
		o.save!
		o.to_json
 	else
 	    "Error: ID not specified."
 	end
end

delete '/messages/:id/?' do |id|
   if id
      o = Message.find(id)
      o.destroy!
      id
 	else
 	    "Error: ID not specified."
 	end
end
