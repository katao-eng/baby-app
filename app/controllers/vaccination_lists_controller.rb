class VaccinationListsController < ApplicationController
  # before_action :set_baby, only: [:index]
  # before_action :move_to_baby_new, only: [:index]
  before_action :set_vaccination_list, only: [:set, :generate, :show, :edit, :update, :reset]

  def index
    @baby = Baby.find(params[:baby_id])
    cookies[:baby_id] = @baby.id
    @type_b_1st = VaccinationList.find_by(baby_id: @baby.id, vaccine_id: 1)
    @type_b_2nd = VaccinationList.find_by(baby_id: @baby.id, vaccine_id: 2)
    @type_b_3rd = VaccinationList.find_by(baby_id: @baby.id, vaccine_id: 3)
  end

  def set
  end

  def generate
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
    @vaccination_lists.update_all(date: "")
    redirect_to baby_vaccination_lists_path
  end

  private

  def vaccination_list_params
    params.require(:vaccination_list).permit(:date).merge(baby_id: params[:baby_id], vaccine_id: @vaccination_list.vaccine_id)
  end

  def set_vaccination_list
    @vaccination_list = VaccinationList.find(params[:id])
  end

  # def baby_params
  #   params.require(:baby).permit(:nickname, :birthday).merge(baby_id: params[:baby_id])
  # end

  # def set_baby
  #   @baby = Baby.find(params[:baby_id])
  # end

  # def move_to_baby_new
  #   if @baby.id.empty?
  #     redirect_to new_baby_path
  #   end
  # end
end
