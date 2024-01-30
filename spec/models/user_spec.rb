require 'rails_helper'

RSpec.describe User, type: :model do
  it 'email, passwordがあれば有効な状態であること' do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it 'passwordが32文字であれば有効な状態であること' do
    user = FactoryBot.build(:user, :long_password)
    expect(user).to be_valid
  end

  it 'emailがなければ無効な状態であること' do
    user = FactoryBot.build(:user, email: nil)
#    user.valid?
#    expect(user.errors[:email]).to include('メールアドレスを入力してください')
    expect(user).to_not be_valid
  end

  it 'passwordがなければ無効な状態であること' do
    user = FactoryBot.build(:user, password: nil)
#    user.valid?
#    expect(user.errors[:password]).to include('パスワードを入力してください')
    expect(user).to_not be_valid
  end

  it 'passwordが8文字未満であれば無効な状態であること' do
    user = FactoryBot.build(:user, :too_short_password)
#    user.valid?
#    expect(user.errors[:password]).to include('パスワードは8文字以上で入力してください')
    expect(user).to_not be_valid
  end

  it 'passwordが33文字以上であれば無効な状態であること' do
    user = FactoryBot.build(:user, :too_long_password)
#    user.valid?
#    expect(user.errors[:password]).to include('パスワードは32文字以内で入力してください')
    expect(user).to_not be_valid
  end

  it 'emailが重複していれば無効な状態であること' do
    FactoryBot.create(:user, :fixed_email)
    user = FactoryBot.build(:user, :fixed_email)
#    user.valid?
#    expect(user.errors[:email]).to include('入力したメールアドレスはすでに登録されています')
    expect(user).to_not be_valid
  end
end
