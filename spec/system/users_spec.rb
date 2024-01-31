require 'rails_helper'

RSpec.describe "Users", type: :system do
  # FactoryBotのテストデータを利用
  let(:user) { FactoryBot.attributes_for(:user) }

  describe 'ログイン前' do
    context 'フォームの入力値が正常' do
      scenario 'ユーザーが新規登録できる' do
        visit new_user_path
        fill_in 'メールアドレス', with: user[:email]
        fill_in 'パスワード', with: user[:password]
        fill_in 'パスワード(確認)', with: user[:password]
        click_button 'アカウントを作成'
        expect(page).to have_content 'アカウントを作成しました'
        expect(current_path).to eq login_path  # 完成系ではアカウント作成するとログイン状態になるようにする
      end
    end

    context 'メールアドレスが未入力' do
      scenario 'ユーザーが新規登録に失敗する' do
        visit new_user_path
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: user[:password]
        fill_in 'パスワード(確認)', with: user[:password]
        click_button 'アカウントを作成'
        expect(page).to have_content 'メールアドレスを入力してください'
        expect(page).to have_content 'アカウントの作成に失敗しました'
        expect(current_path).to eq new_user_path
      end
    end

    context 'パスワードが未入力' do
      scenario 'ユーザーが新規登録に失敗する' do
        visit new_user_path
        fill_in 'メールアドレス', with: user[:email]
        fill_in 'パスワード', with: ''
        fill_in 'パスワード(確認)', with: ''
        click_button 'アカウントを作成'
        expect(page).to have_content 'パスワードは8文字以上で入力してください'
        expect(page).to have_content 'アカウントの作成に失敗しました'
        expect(current_path).to eq new_user_path
      end
    end

    context 'パスワードとパスワード(確認)が一致しない' do
      scenario 'ユーザーが新規登録に失敗する' do
        visit new_user_path
        fill_in 'メールアドレス', with: user[:email]
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード(確認)', with: '12345678'
        click_button 'アカウントを作成'
        expect(page).to have_content 'パスワード(確認)とパスワードの入力が一致しません'
        expect(page).to have_content 'アカウントの作成に失敗しました'
        expect(current_path).to eq new_user_path
      end
    end

    context 'パスワードが7文字以下' do
      scenario 'ユーザーが新規登録に失敗する' do
        visit new_user_path
        fill_in 'メールアドレス', with: user[:email]
        fill_in 'パスワード', with: '1234567'
        fill_in 'パスワード(確認)', with: '1234567'
        click_button 'アカウントを作成'
        expect(page).to have_content 'パスワードは8文字以上で入力してください'
        expect(page).to have_content 'アカウントの作成に失敗しました'
        expect(current_path).to eq new_user_path
      end
    end

    context 'パスワードが33文字以上' do
      scenario 'ユーザーが新規登録に失敗する' do
        visit new_user_path
        fill_in 'メールアドレス', with: user[:email]
        fill_in 'パスワード', with: '123456789012345678901234567890123'
        fill_in 'パスワード(確認)', with: '123456789012345678901234567890123'
        click_button 'アカウントを作成'
        expect(page).to have_content 'パスワードは32文字以内で入力してください'
        expect(page).to have_content 'アカウントの作成に失敗しました'
        expect(current_path).to eq new_user_path
      end
    end

    context 'メールアドレスが既に登録されている' do
      scenario 'ユーザーが新規登録に失敗する' do
        FactoryBot.create(:user, email: 'test@example.com')
        visit new_user_path
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: user[:password]
        fill_in 'パスワード(確認)', with: user[:password]
        click_button 'アカウントを作成'
        expect(page).to have_content 'メールアドレスはすでに存在します'
        expect(page).to have_content 'アカウントの作成に失敗しました'
        expect(current_path).to eq new_user_path
      end
    end
  end
end