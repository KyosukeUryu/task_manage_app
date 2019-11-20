FactoryBot.define do
  factory :task do
    name { 'test_name' }
    description { 'test_description' }
    deadline { Time.now + (60 * 60 * 24) }
  end

  factory :second_task, class: Task do
    name { 'hoge' }
    description { 'fuga' }
    deadline { Time.now }
  end
end
