# frozen_string_literal: true

User.create!(
  name: 'admin',
  email: 'admin@hoge.com',
  password: 'password',
  password_confirmation: 'password',
  admin: true
)

10.times do |i|
  User.create!(
    name: "hoge#{i}",
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
    admin: false
  )

  Task.create!(
    name: "hoge#{i}",
    description: "fuga#{i}",
    deadline: Time.now,
    status: rand(0..2),
    priority: rand(0..2),
    user_id: User.find(i + 1).id
  )
end

Label.create!(
  name: 'テスト中'
)

3.times do |i|
  Group.create!(
    name: "test#{i}",
    owner_id: User.find(i + 1).id
  )

  Join.create!(
    group_id: i + 1,
    user_id: i + 1
  )

end
