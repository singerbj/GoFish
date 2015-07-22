if !ActiveRecord::Base.connection.table_exists? 'users'
    ActiveRecord::Migration.class_eval do
        create_table :users do |t|
            t.string :name
            t.string :gender
            t.integer :age
            t.string :description
            t.string :picture_url
        end
    end
end
if !ActiveRecord::Base.connection.table_exists? 'matches'
    ActiveRecord::Migration.class_eval do
        create_table :matches do |t|
            t.integer :first_user_id
            t.integer :second_user_id
            t.datetime :time
        end
    end
end
if !ActiveRecord::Base.connection.table_exists? 'feelings'
    ActiveRecord::Migration.class_eval do
        create_table :feelings do |t|
            t.integer :owner_id
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
            t.datetime :time
        end
    end
end
