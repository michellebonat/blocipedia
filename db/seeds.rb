# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

# Create Wikis
5.times do
  Wiki.create!(
      title:  Faker::Lorem.sentence,
      body:   Faker::Lorem.paragraph
  )
end
#posts = Post.all

# Create Comments
#100.times do
#  Comment.create!(
#      post: posts.sample,
#      body: Faker::Lorem.paragraph
#  )
#end

puts "Seed finished"
puts "#{Wiki.count} wikis created"
#puts "#{Comment.count} comments created"