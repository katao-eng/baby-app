require 'rails_helper'

RSpec.describe Vaccine, type: :model do
  before do
    @vaccine = FactoryBot.create(:vaccine)
  end

  describe 'ワクチンの登録' do
    context 'ワクチンの登録ができる場合' do
      it 'name、kind_idが存在すれば登録できる' do
        expect(@vaccine).to be_valid
      end
    end
    context 'ワクチンの登録ができない場合' do
      it 'nameがないと登録できない' do
        @vaccine.name = ''
        @vaccine.valid?
        expect(@vaccine.errors.full_messages).to include("Name can't be blank")
      end
      it 'kind_idがないと登録できない' do
        @vaccine.kind_id = ''
        @vaccine.valid?
        expect(@vaccine.errors.full_messages).to include("Kind can't be blank")
      end
    end
  end
end
