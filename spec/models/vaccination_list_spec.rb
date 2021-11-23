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
    end
  end
end
