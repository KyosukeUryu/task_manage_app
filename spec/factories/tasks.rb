FactoryBot.define do
  factory :task do
    name { 'test_name' }
    description { 'test_description' }
  end

  factory :second_task, class: Task do
    name { 'hoge' }
    description { 'fuga' }
  end
end
