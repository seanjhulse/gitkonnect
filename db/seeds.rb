# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
100.times do |index|
  User.create(email: Faker::Internet.email, password: '123456', password_confirmation: '123456')
end

1000.times do |index|
  Post.create(title: Faker::HarryPotter.quote, description: '<p>' + Faker::Lorem.paragraphs(1)[0] + '</p>', repo: "https://google.com", user_id: Faker::Number.between(1, 100))
end

1000.times do |index|
  if Faker::Number.between(0, 1)
    Comment.create(comment: '<p>' + Faker::HarryPotter.quote + '</p>', post_id: Faker::Number.between(1, 1000), user_id: Faker::Number.between(1, User.count))
  else
    parent = Comment.find(Faker::Number.between(1, Comment.all.count))
    Comment.create(comment: '<p>' + Faker::HarryPotter.quote + '</p>', post_id: parent.post_id, comment_id: parent.id, user_id: Faker::Number.between(1, User.count))
  end
end

10000.times do |index|
  if Faker::Number.between(0, 1)
    Vote.create(vote: Faker::Number.between(-1, 1), voters_id: Faker::Number.between(1, Post.all.count), voters_type: 'Post', user_id: Faker::Number.between(1, User.count) )
  else
    Vote.create(vote: Faker::Number.between(-1, 1), voters_id: Faker::Number.between(1, Comment.all.count), voters_type: 'Comment', user_id: Faker::Number.between(1, User.count))
  end
end