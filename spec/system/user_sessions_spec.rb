require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  let(:user) { create(:user) }

  describe 'ログイン前' do
    context 'フォームの入力値が正常' do
      it 'ユーザーがログインに成功する' do
        visit login_path
        fill_in 'email', with: user.email
        fill_in 'password', with: user.password
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました'
        expect(current_path).to eq root_path
      end
    end

    context 'フォームが未入力' do
      it 'ユーザーがログインに失敗する' do
        visit login_path
        fill_in 'email', with: ''
        fill_in 'password', with: ''
        click_button 'ログイン'
        expect(page).to have_content 'ログインに失敗しました'
#        expect(page).to have_content 'メールアドレスまたはパスワードが間違っています'
        expect(current_path).to eq login_path
      end
    end
  end

end
