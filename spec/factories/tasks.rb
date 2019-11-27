FactoryBot.define do
  factory :task do
    name { 'test_name' }
    description { 'test_description' }
    deadline { Time.now + (60 * 60 * 24) }
    status { 1 }
    priority { 1 }
    user
    after(:create) do |task|
      create(:labelling, task: task, label: create(:label))
    end
  end

  factory :second_task, class: Task do
    name { 'hoge' }
    description { 'fuga' }
    deadline { Time.now }
    status { 0 }
    priority { 2 }
    user
  end

end
