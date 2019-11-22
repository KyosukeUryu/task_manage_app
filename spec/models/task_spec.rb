require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do

  it 'nameが空ならバリデーションが通らない' do
    task = Task.new(name: '', description: '失敗テスト', deadline: Time.now)
    expect(task).not_to be_valid
  end

  it 'descriptionが空ならバリデーションが通らない' do
    task = Task.new(name: '失敗テスト', description: '', deadline: Time.now )
    expect(task).to be_invalid
  end

  it 'nameが３０文字を超えたらバリデーションが通らない' do
    long_name = 'a' * 31
    task = Task.new(name: long_name, description: '失敗テスト', deadline: Time.now)
    expect(task).not_to be_valid
  end

  it 'nameとdescriptionに内容が記載され、nameが３０文字以内であればバリデーションが通る' do
    task = Task.new(name: '成功', description: 'テスト', deadline: Time.now)
    expect(task).to be_valid
  end

  it 'deadlineが空ならバリデーションが通らない' do
    task = Task.new(name: '失敗', description: 'テスト', deadline: '')
    expect(task).not_to be_valid
  end

  it 'statusが空ならバリデーションが通らない' do
    task = Task.new(name: '失敗', description: 'テスト', deadline: Time.now, status: '')
    expect(task).not_to be_valid
  end

  it 'priorityが空ならバリデーションが通らない' do
    task = Task.new(name: '失敗', description: 'テスト', deadline: Time.now, priority: '')
    expect(task).not_to be_valid
  end

  it '各要素が入力され、nameが３０文字以内ならバリデーションが通る' do
    valid_name = 'a' * 30
    task = Task.new(name: valid_name, description: '成功テスト', deadline: Time.now, status: 1, priority: 1)
    expect(task).to be_valid
  end

end
