class VaccinationListsController < ApplicationController
  # before_action :set_baby, only: [:index]
  # before_action :move_to_baby_new, only: [:index]

  def index
    @baby = Baby.find(params[:baby_id])
    cookies[:baby_id] = @baby.id
    @type_b_1st = VaccinationList.where(baby_id: @baby.id, vaccine_id: 1)
    @type_b_2nd = VaccinationList.where(baby_id: @baby.id, vaccine_id: 2)
    @type_b_3rd = VaccinationList.where(baby_id: @baby.id, vaccine_id: 3)
  end

  private

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
