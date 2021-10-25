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
      @vaccination_lists = VaccinationList.create(
        [
            # B型肝炎（１回目）
            vaccination_create(1, 8.week, 27.week),
            # ロタウイルス（１回目）
            vaccination_create(4, 6.week, 15.week - 1.days),
            # ヒブ（１回目）
            vaccination_create(7, 2.month, 6.month),
            # 小児用肺炎球菌（１回目）
            vaccination_create(11, 2.month, 6.month),
            # 四種混合（１回目）
            vaccination_create(15, 3.month, 6.year),
            # BCG（１回目）
            vaccination_create(19, 5.month, 8.month),
            # 麻しん・風しん（１回目）
            vaccination_create(20, 1.year, 2.year - 1.days),
            # 水ぼうそう（１回目）
            vaccination_create(22, 12.month, 33.month - 1.days),
            # 日本脳炎（１回目）
            vaccination_create(24, 3.year, 4.year),
            # HPV（１回目）
            vaccination_create(28, 12.year, 15.year)
        ]
      )
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

  def vaccination_create(vaccine_id, birthday_plus_start_date, birthday_plus_end_date)
    {
      start_date: @baby.birthday + birthday_plus_start_date,
      end_date: @baby.birthday + birthday_plus_end_date,
      status: 0,
      baby_id: @baby.id,
      vaccine_id: vaccine_id
    }
  end
end
