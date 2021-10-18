class BabiesController < ApplicationController
  def index
    @babies = Baby.all
  end

  def new
    @baby = Baby.new
  end

  def create
    @baby = Baby.new(baby_params)
    if @baby.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def baby_params
    params.require(:baby).permit(:nickname, :birthday).merge(user_id: current_user.id)
  end
end
