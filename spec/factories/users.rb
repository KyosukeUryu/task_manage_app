FactoryBot.define do
  factory :user do
    name { 'example' }
    email { 'hoge@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    # after(:build) do |user|
    #   user.task = FactoryBot.create(:task)
    #   user.second_task = FactoryBot.create(:second_task)
    # end
  end
end
