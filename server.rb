require 'sinatra'
require 'json'
require 'active_record'
require 'sqlite3'

Dir[File.dirname(__FILE__) + '/routes/*.rb'].each {|file| require file }

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

register Sinatra::SampleApp::Routes::User
register Sinatra::SampleApp::Routes::Match
register Sinatra::SampleApp::Routes::Feeling
register Sinatra::SampleApp::Routes::Message
