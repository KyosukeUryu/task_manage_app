FactoryBot.define do
  factory :user do
    name { 'example' }
    email { 'hoge@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :other_user, class: User do
    name { 'new_man' }
    email { 'new@man.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
