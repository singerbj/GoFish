require 'sinatra'
require 'json'
require 'active_record'
require 'sqlite3'
require 'date'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'dbfile.sqlite3')

#Include Models
require_relative 'models/Match'
require_relative 'models/Feeling'
require_relative 'models/Message'
require_relative 'models/User'

#Include DB Stuff
require_relative 'db/init'

#Generic Sinatra stuff
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

#Include other routes
require_relative 'routes/match_routes'
require_relative 'routes/feeling_routes'
require_relative 'routes/message_routes'
require_relative 'routes/user_routes'
