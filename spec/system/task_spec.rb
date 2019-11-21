require 'rails_helper'

RSpec.describe Task, type: :system do
  describe 'タスク一覧画面' do
    before do
      FactoryBot.create(:task)
      FactoryBot.create(:second_task)
      visit tasks_path
    end

    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること' do
        expect(page).to have_content 'test_name'
      end
    end

    context '複数のタスクを作成した場合' do
      it 'タスクが作成日付の降順に並んでいること' do
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'hoge'
        expect(task_list[1]).to have_content 'test_name'
      end
    end

    context '「終了期限でソートする」ボタンを押した場合' do
      it 'タスクが終了期限の降順に並び替えられる' do
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'hoge'
        click_on '終了期限でソートする'
        sleep 1
        new_task_list = all('.task_row')
        expect(new_task_list[0]).to have_content 'test_name'
      end
    end

    context 'ソートに条件を入力した場合' do
      it 'ソートに合わせて表示を変更する' do
        fill_in 'name_search', with: 'test_name'
        click_on '検索する'
        expect(page).to have_content 'test_name'
        expect(page).not_to have_content 'hoge'
        fill_in 'name_search', with: 'hoge'
        select '未着手', from: '状態検索'
        click_on '検索する'
        expect(page).to have_content 'hoge'
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
        select '着手中', from: "task_status"
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
