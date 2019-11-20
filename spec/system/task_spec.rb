require 'rails_helper'

RSpec.describe Task, type: :system do
  describe 'タスク一覧画面' do
    before do
      FactoryBot.create(:task)
      FactoryBot.create(:second_task)
    end

    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること' do
        visit tasks_path
        expect(page).to have_content 'test_name'
      end
    end

    context '複数のタスクを作成した場合' do
      it 'タスクが作成日付の降順に並んでいること' do
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'hoge'
        expect(task_list[1]).to have_content 'test_name'
      end
    end

    context '「終了期限でソートする」ボタンを押した場合' do
      it 'タスクが終了期限の降順に並び替えられる' do
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'hoge'
        click_on '終了期限でソートする'
        sleep 1
        new_task_list = all('.task_row')
        expect(new_task_list[0]).to have_content 'test_name'
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること' do
        visit new_task_path
        fill_in 'タスク名', with: 'hoge'
        fill_in 'タスク詳細', with: 'fuga'
        select '2021', from: "task_deadline_1i"
        select '7月', from: "task_deadline_2i"
        select '13', from: "task_deadline_3i"
        click_on '登録する'
        expect(page).to have_content 'hoge'
        expect(page).to have_content 'fuga'
        expect(page).to have_content '2021-07-13'
      end
    end
  end

  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示されたページに遷移すること' do
         task1 = FactoryBot.create(:task)
         task2 = FactoryBot.create(:second_task)
         visit tasks_path
         click_on 'test_name'
         expect(page).to have_content 'test_name'
         expect(page).not_to have_content 'hoge'
       end
     end
  end
end
