# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
20.times do |n|
  #ユーザーシード
  name = Faker::Name.name
  email = Faker::Internet.email
  password = "password"
  uid = SecureRandom.uuid
  user = User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               uid: uid
               )
  #イベントシード
  title = Faker::Job.title
  I18n.locale = 'ja'
  started_at = DateTime.now + n
  closed_at = started_at + 1
  venue_name = Faker::Address.community
  venue_address = Faker::Address.full_address
  venue_url = Faker::Internet.url
  note = Faker::FunnyName.name
  release = Faker::Boolean.boolean(true_ratio: 0.5)
  event = Event.create!(
                        title: title,
                        user: user,
                        started_at: started_at,
                        closed_at: closed_at,
                        venue_name: venue_name,
                        venue_address: venue_address,
                        venue_url: venue_url,
                        note: note,
                        release: release
                        )
end
