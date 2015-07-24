if !ActiveRecord::Base.connection.table_exists? 'users'
    ActiveRecord::Migration.class_eval do
        create_table :users do |t|
            t.string :name, :null => false
            t.string :gender, :null => false
            t.integer :age, :null => false
            t.string :description, :default => ""
            t.string :picture_url, :null => false
            t.string :fb_id, :null => false, :unique => true
            t.string :city, :null => false
            t.string :region, :null => false
            t.string :lat, :null => false
            t.string :long, :null => false
        end
    end
end
if !ActiveRecord::Base.connection.table_exists? 'matches'
    ActiveRecord::Migration.class_eval do
        create_table :matches do |t|
            t.integer :first_user_id, :null => false
            t.integer :second_user_id, :null => false
            t.datetime :time, :null => false
            t.string :matched_user
        end
    end
end
if !ActiveRecord::Base.connection.table_exists? 'feelings'
    ActiveRecord::Migration.class_eval do
        create_table :feelings do |t|
            t.integer :user_id, :null => false
            t.integer :felt_user_id, :null => false
            t.string :feeling, :null => false
        end
    end
end
if !ActiveRecord::Base.connection.table_exists? 'messages'
    ActiveRecord::Migration.class_eval do
        create_table :messages do |t|
            t.integer :match_id, :null => false
            t.integer :user_id, :null => false
            t.string :contents, :null => false
            t.datetime :time, :null => false
        end
    end
end
