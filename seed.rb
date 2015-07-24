require 'rubygems'
require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'dbfile.sqlite3')

#Include Models
require_relative 'models/Match'
require_relative 'models/Feeling'
require_relative 'models/Message'
require_relative 'models/User'

#Include DB Stuff
u = User.new
u.name = "Billy"
u.picture_url = "https://pbs.twimg.com/profile_images/449663478098194434/4SR4nIDu.jpeg"
u.age = 24
u.gender = "male"
u.fb_id = "0000000000000000000"
u.city = "Minneapolis"
u.region = "Minnesota"
u.lat = "44.974"
u.long = "-93.257"
u.description = "this is my bio"
u.save!

u = User.new
u.name = "Sally"
u.picture_url = "http://georgetownheckler.com/blog/wp-content/uploads/2015/02/smiling-woman.jpg"
u.age = 22
u.gender = "female"
u.fb_id = "0000000000000000000"
u.city = "Minneapolis"
u.region = "Minnesota"
u.lat = "44.974"
u.long = "-93.257"
u.description = "this is my bio"
u.save!

susie = User.new
susie.name = "Susie"
susie.picture_url = "http://www.reality-health.org/wp-content/uploads/2012/06/Smiling-woman-3.jpg"
susie.age = 26
susie.gender = "female"
susie.fb_id = "0000000000000000000"
susie.city = "Minneapolis"
susie.region = "Minnesota"
susie.lat = "44.974"
susie.long = "-93.257"
susie.description = "this is my bio"
susie.save!

f = Feeling.new
f.user_id = susie.id
f.felt_user_id = 4
f.feeling = "like"
f.save!
