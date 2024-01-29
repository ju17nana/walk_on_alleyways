require 'rails_helper'

RSpec.describe User, type: :model do
  it 'email, crypted_password, saltがあれば有効な状態であること' do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it 'emailがなければ無効な状態であること' do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include('メールアドレスを入力してください')
  end

  it 'passwordがなければ無効な状態であること' do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include('パスワードを入力してください')
  end

  it 'emailが重複していれば無効な状態であること' do
    FactoryBot.create(:user, :fixed_email)
    user = FactoryBot.build(:user, :fixed_email)
    user.valid?
    expect(user.errors[:email]).to include('入力したメールアドレスはすでに登録されています')
  end
end
