require 'rails_helper'

RSpec.describe Task, type: :system do
  describe 'ログイン前のタスク機能制限' do
    context 'ログイン前にタスク機能のページに飛ぼうとする' do
      it 'ログイン画面へ飛ばされる' do
        visit tasks_path
        expect(page).to have_content 'ログイン画面'
        visit new_task_path
        expect(page).to have_content 'ログイン画面'
      end
    end
  end

  describe 'タスク一覧画面' do
    before do
      @user = FactoryBot.create(:user)
      @task1 = FactoryBot.create(:task, user: @user)
      @task2 = FactoryBot.create(:second_task, user: @user)
      visit new_session_path
      fill_in "session_email", with: 'hoge@example.com'
      fill_in "session_password", with: 'password'
      click_on 'ログインする'
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
        expect(page).to have_selector '.task_row', text: 'test_name'
        fill_in 'name_search', with: 'hoge'
        select '未着手', from: '状態検索'
        click_on '検索する'
        expect(page).to have_selector '.task_row', text: 'hoge'
        select '中', from: '優先度検索'
        click_on '検索する'
        expect(page).to have_selector '.task_row', text: 'test_name'
        select 'testing', from: 'ラベル検索'
        click_on '検索する'
        expect(page).to have_selector '.task_row', text: 'test_name'
      end
    end

    context '「優先順位でソートする」を押した場合' do
      it 'タスクが優先順位の昇順に並び替えられる' do
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'hoge'
        click_on '優先順位でソートする'
        sleep 1
        new_task_list = all('.task_row')
        expect(new_task_list[0]).to have_content 'test_name'
      end
    end
  end

  describe 'タスク登録画面' do
    before do
      @user = FactoryBot.create(:user)
      @task1 = FactoryBot.create(:task, user: @user)
      @task2 = FactoryBot.create(:second_task, user: @user)
      visit new_session_path
      fill_in "session_email", with: 'hoge@example.com'
      fill_in "session_password", with: 'password'
      click_on 'ログインする'
    end
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること' do
        visit new_task_path
        fill_in 'タスク名', with: 'hoge'
        fill_in 'タスク詳細', with: 'fuga'
        select '2021', from: "task_deadline_1i"
        select '7月', from: "task_deadline_2i"
        select '13', from: "task_deadline_3i"
        select '着手中', from: "task_status"
        select '中', from: "優先順位"
        check 'testing'
        click_on '登録する'
        expect(page).to have_content 'hoge'
        expect(page).to have_content 'fuga'
        expect(page).to have_content '2021-07-13'
      end
    end
  end

  describe 'タスク詳細画面' do
    before do
      @user = FactoryBot.create(:user)
      @task1 = FactoryBot.create(:task, user: @user)
      @task2 = FactoryBot.create(:second_task, user: @user)
      visit new_session_path
      fill_in "session_email", with: 'hoge@example.com'
      fill_in "session_password", with: 'password'
      click_on 'ログインする'
    end
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移すること' do
        within '.task_table' do
          click_on 'test_name'
        end
        expect(page).to have_selector '.task_show_table', text: 'test_name'
        expect(page).not_to have_selector '.task_show_table', text: 'hoge'
      end
    end
  end
end
