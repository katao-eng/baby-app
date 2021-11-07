class VaccinationListsController < ApplicationController
  before_action :set_vaccination_list, only: [:set, :generate, :show, :edit, :update, :reset]

  def index
    @baby = Baby.find(params[:baby_id])
    cookies[:baby_id] = @baby.id
    @type_b_1st = select_vaccine(1)
    @type_b_2nd = select_vaccine(2)
    @type_b_3rd = select_vaccine(3)
    @rota_1sr = select_vaccine(4)
    @rota_2nd = select_vaccine(5)
    @rota_3rd = select_vaccine(6)
    @hib_1st = select_vaccine(7)
    @hib_2nd = select_vaccine(8)
    @hib_3rd = select_vaccine(9)
    @hib_4th = select_vaccine(10)
    @haien_1st = select_vaccine(11)
    @haien_2nd = select_vaccine(12)
    @haien_3rd = select_vaccine(13)
    @haien_4th = select_vaccine(14)
    @four_kinds_1st = select_vaccine(15)
    @four_kinds_2nd = select_vaccine(16)
    @four_kinds_3rd = select_vaccine(17)
    @four_kinds_4th = select_vaccine(18)
    @bcg_1st = select_vaccine(19)
    @mr_1st = select_vaccine(20)
    @mr_2nd = select_vaccine(21)
    @suitou_1st = select_vaccine(22)
    @suitou_2nd = select_vaccine(23)
    @japanese_encephalitis_1st = select_vaccine(24)
    @japanese_encephalitis_2nd = select_vaccine(25)
    @japanese_encephalitis_3rd = select_vaccine(26)
    @japanese_encephalitis_4th = select_vaccine(27)
  end

  def set
    @vaccination_lists = VaccinationList.where("baby_id = ? AND start_date <= ? AND end_date >= ?", params[:baby_id], @vaccination_list.end_date, @vaccination_list.start_date)
  end

  def generate
    @vaccination_lists = VaccinationList.where("baby_id = ? AND start_date <= ? AND end_date >= ?", params[:baby_id], @vaccination_list.end_date, @vaccination_list.start_date)
    if @vaccination_list.update(vaccination_list_params)
      redirect_to baby_vaccination_lists_path
    else
      render :set
    end
  end

  def show
    @vaccination_lists = VaccinationList.where(baby_id: params[:baby_id], date: @vaccination_list.date).where.not(id: params[:id])
  end

  def edit
  end

  def update
    if @vaccination_list.update(vaccination_list_params)
      redirect_to baby_vaccination_list_path
    else
      render :edit
    end
  end

  def reset
    @vaccination_lists = VaccinationList.where(baby_id: params[:baby_id], date: @vaccination_list.date)
    @vaccination_lists.update_all(date: nil)
    redirect_to baby_vaccination_lists_path
  end

  private

  def vaccination_list_params
    params.require(:vaccination_list).permit(:date).merge(baby_id: params[:baby_id], vaccine_id: @vaccination_list.vaccine_id)
  end

  def set_vaccination_list
    @vaccination_list = VaccinationList.find(params[:id])
  end

  def select_vaccine(vaccine_id)
    VaccinationList.find_by(baby_id: @baby.id, vaccine_id: vaccine_id)
  end
end
