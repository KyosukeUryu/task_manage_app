require 'rails_helper'

RSpec.describe User, type: :system do
  describe 'ユーザー登録画面' do
    context '必要項目を入力して「登録する」ボタンを押した場合' do
      it 'ユーザ登録が完了し、ログインされタスク機能が表示される' do
        visit new_user_path
        fill_in 'ユーザー名', with: 'fuga'
        fill_in 'メールアドレス', with: 'fuga@hoge.com'
        fill_in 'パスワード', with: 'fugahoge'
        fill_in '確認用パスワード', with: 'fugahoge'
        click_on '登録する'
        expect(page).to have_content '登録が完了しました'
        expect(page).to have_content 'タスク新規登録'
      end
    end
  end

  describe 'ユーザ詳細画面' do
    before do
      @user = FactoryBot.create(:user)
      @user2 = FactoryBot.create(:other_user)
      visit new_session_path
      fill_in "session_email", with: 'hoge@example.com'
      fill_in "session_password", with: 'password'
      click_on 'ログインする'
    end
    context '「ユーザ詳細」をクリックした場合' do
      it '自身の詳細ページに移行する' do
        click_on 'ユーザ詳細'
        expect(page).to have_content 'exampleさんのページ'
      end
    end
    context '他人のユーザページを見ようとした場合' do
      it 'トップページに移行する' do
        visit user_path(@user2.id)
        expect(page).to have_content 'トップページ'
      end
    end
  end

  describe 'ログイン画面' do
    before do
      @user = FactoryBot.create(:user)
      visit new_session_path
    end
    context '正しく入力された場合' do
      it 'ログインが完了しタスク一覧画面が表示される' do
        fill_in "session_email", with: 'hoge@example.com'
        fill_in "session_password", with: 'password'
        click_on 'ログインする'
        expect(page).to have_content 'ログインしました'
        expect(page).to have_content 'タスク一覧'
      end
    end

    context '入力に誤りがあった場合' do
      it 'ログインに失敗しログイン画面に戻る' do
        fill_in "session_email", with: 'exe@example.com'
        fill_in "session_password", with: 'passwordpass'
        click_on 'ログインする'
        expect(page).to have_content 'ログインに失敗しました'
        expect(page).to have_content 'ログイン画面'
      end
    end
  end
end
