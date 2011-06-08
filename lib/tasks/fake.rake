namespace :fake do
  desc 'Users'
  task :users, [:count] => :environment do |t, args|
    count = (args[:count] || 50).to_i

    puts ">>> Building #{count} users (.=1)"

    count.times do
      user = User.new
      user.name = Forgery::Name.full_name
      user.save!
      STDERR.print '.'
    end

    STDERR.puts
  end

  desc 'Products'
  task :products, [:count] => :environment do |t, args|
    count = (args[:count] || 1000).to_i

    puts ">>> Building #{count} products (.=1)"

    users = User.all

    count.times do
      p = Product.new
      p.name = Forgery::Basic.text
      p.curator = users.random
      p.save!
      STDERR.print '.'
    end

    STDERR.puts
  end

  desc 'Worships'
  task :worships, [:count] => :environment do |t, args|
    count = (args[:count] || 1000).to_i

    puts ">>> Loading users and products"

    users = User.all
    products = Product.all

    puts ">>> Building #{count} worships (.=1)"
    count.times do
      Worship.create!(user: users.random, product: products.random)
      STDERR.print '.'
    end

    STDERR.puts
  end
end
