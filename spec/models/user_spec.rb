require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'email、password、relationship_idが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが英数含む6文字以上であれば登録できる' do
        @user.password = 'aaa111'
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'relationshipが選択されていないと登録できない' do
        @user.relationship_id = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Relationship can't be blank")
      end
      it 'passwordが数字だけでは登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password 半角英数を両方含む必要があります")
      end
      it 'passwordが英字だけでは登録できない' do
        @user.password = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password 半角英数を両方含む必要があります")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordに全角文字が含まれていると登録できない' do
        @user.password = 'a１２３４５'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password 半角英数を両方含む必要があります")
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailに@が含まれていないと登録できない' do
        @user.email = 'example'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
    end
  end
end
