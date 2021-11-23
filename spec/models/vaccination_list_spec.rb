require 'rails_helper'

RSpec.describe VaccinationList, type: :model do
  before do
    baby = FactoryBot.create(:baby)
    vaccine = FactoryBot.create(:vaccine)
    @vaccination_list = FactoryBot.build(:vaccination_list, baby_id: baby.id, vaccine_id: vaccine.id)
  end

  describe 'ワクチンリストの登録' do
    context 'ワクチンリストの登録ができる場合' do
      it 'date, start_date, end_dateがあれば登録できる' do
        expect(@vaccination_list).to be_valid
      end
      it 'dateは空でも登録できる' do
        @vaccination_list.date = ''
        expect(@vaccination_list).to be_valid
      end
    end

    context 'ワクチンリストの登録ができない場合' do
      it 'start_dateが空では登録できない' do
        
      end
      it 'end_dateが空では登録できない' do
        
      end
      it 'dateがstart_date〜end_dateの範囲内でないと登録できない' do
        
      end
      it 'babyが紐づいていないと登録できない' do
        
      end
      it 'vaccineが紐づいていないと登録できない' do
        
      end
    end
  end
end
