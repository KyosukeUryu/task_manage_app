require 'rails_helper'

RSpec.describe User, type: :system do
  describe 'ユーザー登録画面' do
    context '必要項目を入力して「登録する」ボタンを押した場合' do
      it 'ユーザ登録が完了すること' do
        visit new_user_path
        fill_in 'ユーザー名', with: 'fuga'
        fill_in 'メールアドレス', with: 'fuga@hoge.com'
        fill_in 'パスワード', with: 'fugahoge'
        fill_in '確認用パスワード', with: 'fugahoge'
        click_on '登録する'
        expect(page).to have_content '登録が完了しました'
      end
    end
  end

  describe 'ユーザ詳細画面' do
    context ''
  end
end
