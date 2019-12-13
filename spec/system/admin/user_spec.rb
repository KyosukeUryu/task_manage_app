# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:other_user)
    @user3 = FactoryBot.create(:third_user)
    visit new_session_path
    fill_in 'session_email', with: 'hoge@example.com'
    fill_in 'session_password', with: 'password'
    click_on 'ログインする'
  end

  describe '管理者のユーザー一覧画面' do
    before do
      visit admin_users_path
    end
    context '管理者がユーザー一覧画面に遷移した場合' do
      it 'ユーザー一覧が表示される' do
        expect(page).to have_content('example')
        expect(page).to have_content('new_man')
      end
    end
    context '一覧画面で削除ボタンを押した場合' do
      it '対象ユーザーが削除される' do
        user_list = all('.user_row')
        user_list[0].click_on 'ユーザーを削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content('third_user')
      end
    end
  end

  describe '管理者のユーザー詳細画面' do
    before do
      FactoryBot.create(:task, user: @user2)
    end
    context '管理者がユーザー詳細画面に遷移した場合' do
      it 'ユーザーの最新タスクが確認できる' do
        visit admin_user_path(@user2)
        expect(page).to have_content('test_name')
      end
    end
  end

  describe '管理者のユーザ新規登録画面' do
    context 'ユーザーの登録情報が正しく入力されている' do
      it '一覧画面に遷移しユーザー登録が完了する' do
        visit new_admin_user_path
        fill_in 'ユーザー名', with: 'fuga'
        fill_in 'メールアドレス', with: 'fuga@hoge.com'
        fill_in 'パスワード', with: 'fugahoge'
        fill_in '確認用パスワード', with: 'fugahoge'
        click_on '登録する'
        expect(page).to have_content '新規ユーザーを作成しました'
        expect(page).to have_content 'fuga'
      end
    end
  end

  describe '管理者のユーザー編集画面' do
    context 'ユーザー情報を正しく入力すれば' do
      it '情報が更新され一覧画面に遷移する' do
        visit edit_admin_user_path(@user2)
        fill_in 'ユーザー名', with: 'fuga'
        fill_in 'メールアドレス', with: 'fuga@hoge.com'
        fill_in 'パスワード', with: 'fugahoge'
        fill_in '確認用パスワード', with: 'fugahoge'
        click_on '更新する'
        expect(page).to have_content '対象ユーザー情報を更新しました'
        expect(page).to have_content 'fuga'
      end
    end
  end
end
