# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do
  before do
    @user = FactoryBot.create(:user)
  end

  it 'nameが空ならバリデーションが通らない' do
    task = Task.new(name: '', description: '失敗テスト', deadline: Time.now, user: @user)
    expect(task).not_to be_valid
  end

  it 'descriptionが空ならバリデーションが通らない' do
    task = Task.new(name: '失敗テスト', description: '', deadline: Time.now, user: @user)
    expect(task).to be_invalid
  end

  it 'nameが３０文字を超えたらバリデーションが通らない' do
    long_name = 'a' * 31
    task = Task.new(name: long_name, description: '失敗テスト', deadline: Time.now, user: @user)
    expect(task).not_to be_valid
  end

  it 'nameとdescriptionに内容が記載され、nameが３０文字以内であればバリデーションが通る' do
    task = Task.new(name: '成功', description: 'テスト', deadline: Time.now, user: @user)
    expect(task).to be_valid
  end

  it 'deadlineが空ならバリデーションが通らない' do
    task = Task.new(name: '失敗', description: 'テスト', deadline: '', user: @user)
    expect(task).not_to be_valid
  end

  it 'statusが空ならバリデーションが通らない' do
    task = Task.new(name: '失敗', description: 'テスト', deadline: Time.now, status: '', user: @user)
    expect(task).not_to be_valid
  end

  it 'priorityが空ならバリデーションが通らない' do
    task = Task.new(name: '失敗', description: 'テスト', deadline: Time.now, priority: '', user: @user)
    expect(task).not_to be_valid
  end

  it '各要素が入力され、nameが３０文字以内ならバリデーションが通る' do
    valid_name = 'a' * 30
    task = Task.new(name: valid_name, description: '成功テスト', deadline: Time.now, status: 1, priority: 1, user: @user)
    expect(task).to be_valid
  end

  before do
    FactoryBot.create(:task, user: @user)
    FactoryBot.create(:second_task, user: @user)
  end

  it 'name_searchで検索したnameのタスクが検索される' do
    tasks = Task.name_search('hoge')
    expect(tasks.last.name).to eq 'hoge'
  end

  it 'status_searchで検索したstatusのタスクが検索される' do
    tasks = Task.status_search(1)
    expect(tasks.last.status).to eq '着手中'
  end

  it 'priority_searchで検索したpriorityのタスクが検索される' do
    tasks = Task.priority_search(1)
    expect(tasks.last.priority).to eq '中'
  end
end
