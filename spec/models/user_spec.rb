require 'rails_helper'

RSpec.describe User, type: :model do
  it 'email, passwordがあれば有効な状態であること' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'passwordが32文字であれば有効な状態であること' do
    user = build(:user, password: ('a' * 32), password_confirmation: ('a' * 32))
    expect(user).to be_valid
  end

  it 'emailがなければ無効な状態であること' do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include('を入力してください')
  end

  it 'passwordがなければ無効な状態であること' do
    user = build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include('は8文字以上で入力してください')
  end

  it 'password(確認)がなければ無効な状態であること' do
    user = build(:user, password_confirmation: nil)
    user.valid?
    expect(user.errors[:password_confirmation]).to include('を入力してください')
  end

  it 'passwordが8文字未満であれば無効な状態であること' do
    user = build(:user, password: ('a' * 7), password_confirmation: ('a' * 7))
    user.valid?
    expect(user.errors[:password]).to include('は8文字以上で入力してください')
  end

  it 'passwordが33文字以上であれば無効な状態であること' do
    user = build(:user, password: ('a' * 33), password_confirmation: ('a' * 33))
    user.valid?
    expect(user.errors[:password]).to include('は32文字以内で入力してください')
  end

  it 'emailが重複していれば無効な状態であること' do
    create(:user, :fixed_email)
    user = build(:user, :fixed_email)
    user.valid?
    expect(user.errors[:email]).to include('はすでに存在します')
  end
end
