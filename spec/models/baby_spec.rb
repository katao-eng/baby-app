require 'rails_helper'

RSpec.describe Baby, type: :model do
  before do
    @baby = FactoryBot.create(:baby)
  end

  describe 'babyの登録' do
    context 'babyの登録ができる場合' do
      it 'nickname、birthdayが存在し、userが紐づいていれば登録できる' do
        expect(@baby).to be_valid
      end
    end
    context 'babyの登録ができない場合' do
      it 'nicknameがないと登録できない' do
        @baby.nickname = ''
        @baby.valid?
        expect(@baby.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'birthdayがないと登録できない' do
        @baby.birthday = ''
        @baby.valid?
        expect(@baby.errors.full_messages).to include("Birthday can't be blank")
      end
      it 'userが紐づいていないと登録できない' do
        @baby.user = nil
        @baby.valid?
        expect(@baby.errors.full_messages).to include("User must exist")
      end
    end
  end
end
