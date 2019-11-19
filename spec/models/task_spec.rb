require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do

  it 'nameが空ならバリデーションが通らない' do
    task = Task.new(name: '', description: '失敗テスト')
    expect(task).not_to be_valid
  end

  it 'descriptionが空ならバリデーションが通らない' do
    task = Task.new(name: '失敗テスト', description: '' )
    expect(task).to be_invalid
  end
  it 'nameが３０文字を超えたらバリデーションが通らない' do
    long_name = 'a' * 31
    task = Task.new(name: long_name, description: '失敗テスト')
    expect(task).not_to be_valid
  end

  it 'nameとdescriptionに内容が記載され、nameが３０文字以内であればバリデーションが通る' do
    task = Task.new(name: '成功', description: 'テスト')
    expect(task).to be_valid
  end
end
