require 'rubygems'
require 'sinatra'
require 'json'
require 'active_record'
require 'sqlite3'
require 'date'
require 'omniauth'
require 'omniauth-facebook'
require "net/http"
require "uri"

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'dbfile.sqlite3')

#Include Models
require_relative 'models/Match'
require_relative 'models/Feeling'
require_relative 'models/Message'
require_relative 'models/User'

#Include DB Stuff
require_relative 'db/init'
require_relative 'seed'

#Generic Sinatra stuff
configure do
    set :bind, '0.0.0.0'
    set :public_folder, '.'
    set :sessions, true
end

use OmniAuth::Builder do
    provider :facebook, '102655633419347','d7a77528a89fd17063eb62001c939f00', :info_fields => "first_name,birthday,gender,education", :image_size => 'large'
end

after { ActiveRecord::Base.connection.close }

not_found do
    "The path: #{request.path} does not exist."
end

error do
    "Error is: " + params['captures'].first.inspect
end


get '/' do
    if session['authenticated']
        send_file File.join(settings.public_folder, 'index.html')
    else
        send_file File.join(settings.public_folder, 'partials/login.html')
    end
end

get '/currentUser' do
    User.where(fb_id: session[:current_user_id]).to_json
end

get '/auth/:provider/callback' do
    r = request.env['omniauth.auth']
    if r['uid']
        user_in_question = User.where(fb_id: r['extra']['raw_info']['id'].to_s)
        if user_in_question.length == 0
            u = User.new
        else
            u = user_in_question[0]
        end

        u.name = r['extra']['raw_info']['first_name'].to_s
        u.picture_url = r['info']['image'].to_s
        u.age = ((DateTime.now - DateTime.strptime(r['extra']['raw_info']['birthday'], "%m/%d/%Y")) / 364.25).floor
        u.gender = r['extra']['raw_info']['gender'].to_s
        u.fb_id = r['extra']['raw_info']['id'].to_s
        ipToUse = ""
        if !request.ip.start_with?("192.168")
            ipToUse = request.ip
        end
        uri = URI.parse("http://freegeoip.net/json/#{ipToUse}")
        http = Net::HTTP.new(uri.host, uri.port)
        loc_request = Net::HTTP::Get.new(uri.request_uri)
        loc_response = http.request(loc_request)
        u.city = JSON.parse(loc_response.body.to_s)['city']
        u.region = JSON.parse(loc_response.body.to_s)['region_name']
        u.lat = JSON.parse(loc_response.body.to_s)['latitude']
        u.long = JSON.parse(loc_response.body.to_s)['longitude']
        u.save!

        session[:authenticated] = true
        session[:current_user_id] = r['extra']['raw_info']['id']
        redirect '/'
    else
        session[:authenticated] = false
        puts "Error Logging in :("
        redirect '/'
    end
 end

 get '/auth/failure' do
   puts "<h1>Authentication Failed:</h1><h3>message:<h3> <pre>#{params}</pre>"
   redirect '/'
 end

 get '/auth/:provider/deauthorized' do
   puts "#{params[:provider]} has deauthorized this app."
   redirect '/'
 end

 get '/protected' do
   throw(:halt, [401, "Not authorized\n"]) unless session[:authenticated]
   erb "<pre>#{request.env['omniauth.auth'].to_json}</pre><hr>
        <a href='/logout'>Logout</a>"
 end

 get '/logout' do
   session[:authenticated] = false
   session[:current_user_id] = 0
   redirect '/'
 end

#Include other routes
require_relative 'routes/match_routes'
require_relative 'routes/feeling_routes'
require_relative 'routes/message_routes'
require_relative 'routes/user_routes'
