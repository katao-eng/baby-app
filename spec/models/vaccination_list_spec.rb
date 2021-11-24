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
        @vaccination_list.date = ''
        @vaccination_list.start_date = ''
        @vaccination_list.valid?
        expect(@vaccination_list.errors.full_messages).to include("Start date can't be blank")
      end
      it 'end_dateが空では登録できない' do
        @vaccination_list.date = ''
        @vaccination_list.end_date = ''
        @vaccination_list.valid?
        expect(@vaccination_list.errors.full_messages).to include("End date can't be blank")
      end
      it 'dateがstart_date〜end_dateの範囲内でないと登録できない' do
        @vaccination_list.date = Date.today
        @vaccination_list.start_date = 2.days.ago
        @vaccination_list.end_date = 1.days.ago
        @vaccination_list.valid?
        expect(@vaccination_list.errors.full_messages).to include("Date は接種可能期間内で指定してください。")

      end
      it 'babyが紐づいていないと登録できない' do
        @vaccination_list.baby_id = nil
        @vaccination_list.valid?
        expect(@vaccination_list.errors.full_messages).to include("Baby can't be blank")
      end
      it 'vaccineが紐づいていないと登録できない' do
        @vaccination_list.vaccine_id = nil
        @vaccination_list.valid?
        expect(@vaccination_list.errors.full_messages).to include("Vaccine can't be blank")
      end
    end
  end
end
