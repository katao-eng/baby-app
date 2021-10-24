class BabiesController < ApplicationController
  before_action :baby_list, only: [:myfamily]

  def index
    if cookies[:baby_id] != nil
      redirect_to baby_vaccination_lists_path(baby_id: cookies[:baby_id])
    else
      baby_list
    end
  end

  def myfamily
  end

  def new
    @baby = Baby.new
  end

  def create
    @baby = Baby.new(baby_params)
    if @baby.save
      cookies[:baby_id] = @baby.id
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def baby_params
    params.require(:baby).permit(:nickname, :birthday).merge(user_id: current_user.id)
  end

  def baby_list
    @babies = Baby.where(user_id: current_user.id)
    if @babies.empty?
      redirect_to new_baby_path
    end
  end
end
