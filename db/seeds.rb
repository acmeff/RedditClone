# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# 5.times { User.create(username: Faker::Internet.user_name, password: Faker::Internet.password)}

#
# 20.times { Sub.create(user_id: [1,2,3,4,5].sample, title: Faker::StarWars.planet, description: Faker::StarWars.specie)}
# #
40.times { Post.create(user_id: [1,2,3,4,5].sample, title: Faker::StarWars.character, sub_ids: (1..20).to_a.sample(3))}

60.times {Comment.create(user_id: [1,2,3,4,5].sample, content: Faker::StarWars.wookie_sentence, post: Post.all.sample)}
