class VaccinationListsController < ApplicationController
  # before_action :set_baby, only: [:index]
  # before_action :move_to_baby_new, only: [:index]

  def index
    @baby = Baby.find(params[:baby_id])
  end

  private

  # def baby_params
  #   params.require(:baby).permit(:nickname, :birthday).merge(baby_id: params[:baby_id])
  # end

  # def set_baby
  #   @baby = Baby.find(params[:baby_id])
  # end

  # def move_to_baby_new
  #   if @baby.id == nil
  #     redirect_to new_baby_path
  #   end
  # end
end
