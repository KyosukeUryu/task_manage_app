20.times do
  Task.create!(
              name: 'hoge',
              description: 'fuga',
              deadline: Time.now,
              status: 0,
              priority: 0,
              user_id: 1
  )
end
