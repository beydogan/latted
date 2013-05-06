# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first

require 'faker'
Rake::Task['db:reset'].invoke

def rand_in_range(from, to)
  rand * (to - from) + from
end

def rand_price(from, to)
  rand_in_range(from, to).round(2)
end

def rand_time(from, to=Time.now)
  Time.at(rand_in_range(from.to_f, to.to_f))
end



puts "#------------SEEDING------------#"

admin = User.create!(
    :username => "admin",
    :email => "admin@codexity.com",
    :password => "m.123456"
)


puts "#Super Admin Created"

#### PROJECT CATEGORIES
pcats = []
pcats << ItemCategory.create!(
    :title => "Computers"
)

pcats << ItemCategory.create!(
    :title => "Clothes"
)

### USERS
users = []
10.times do |n|
  u = User.create!(
      :username => "user" + n.to_s + "",
      :email => "u" + n.to_s + "@codexity.com",
      :password => "m.123456"
  )

  users << u
end



10.times do |n|
  title  = "Item " + n.to_s
  user = users[rand(10)]
  i = Item.create!(
      :title => title
  )
  i.user = user
  i.save
end


UserActionType.create(:name => "like")
UserActionType.create(:name => "want")
UserActionType.create(:name => "own")

