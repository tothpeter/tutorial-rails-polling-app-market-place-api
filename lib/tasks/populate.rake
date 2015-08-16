namespace :db do
  desc "Populate DB with fake data"
  task :populate => :environment do
    require 'populator'
    require 'faker'

    tables = [:placements, :orders, :products, :users]
    ActiveRecord::Base.connection.execute("TRUNCATE #{tables.join(',')} RESTART IDENTITY")

    User.populate 1 do |user|
      user.email = "tothpeter10@gmail.com"
      user.encrypted_password = User.new.send(:password_digest, '1')
      user.sign_in_count = 0
      user.auth_token = "a"

      puts 'User done'

      # user.about = Faker::Lorem.sentence(word_count = 20, supplemental = false, random_words_to_add = 10)

      Product.populate 4 do |product|
        product.title = Faker::Commerce.product_name
        product.price = Faker::Commerce.price
        product.published = true
        product.user_id = user.id
      end

      puts 'Products done'

      Order.populate 2 do |product|
        product.total = Faker::Commerce.price
        product.user_id = user.id
      end

      puts 'Orders done'
    end
    
    puts 'All done'
  end
end