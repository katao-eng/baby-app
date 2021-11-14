class VaccinationListsController < ApplicationController
  before_action :set_vaccination_list, only: [:set, :generate, :show, :edit, :update, :reset]
  before_action :set_vaccines, only: [:set, :generate]
  before_action :set_baby, only: [:index, :generate]
  before_action :set_show_vaccination_lists, only: [:show, :reset]

  def index
    cookies[:baby_id] = @baby.id
    @vaccination_lists = VaccinationList.includes(:baby).references(:baby).where(baby_id: params[:baby_id])
  end

  def set
  end

  def generate
    vaccine_ids = params[:vaccination_ids] << @vaccination_list.vaccine_id.to_s
    @vaccination_lists = VaccinationList.where(baby_id: params[:baby_id], vaccine_id: vaccine_ids)
    generate_vaccination_lists = []
    vaccine_ids.each do |vaccine_id|
      unless vaccine_id == ""
        generate_vaccination_list = VaccinationList.find_by(baby_id: params[:baby_id], vaccine_id: vaccine_id)
        generate_vaccination_list.assign_attributes(vaccination_ids_params)
        generate_vaccination_lists << generate_vaccination_list
      end
    end
    generate_vaccination_lists.each do |generate_vaccination_list|
      unless generate_vaccination_list.valid?
        flash.now[:alert] = "接種可能期間外のワクチンが含まれているか、接種（予定）日が未入力です！"
        render :set
        return
      end
    end
    generate_vaccination_lists.each do |generate_vaccination_list|
      if generate_vaccination_list.save
        case generate_vaccination_list.vaccine.name
        when "B型肝炎（１回目）"
          vaccination_create(generate_vaccination_list.date + 4.week, @baby.birthday + 28.week, 2)
        when "B型肝炎（２回目）"
          vaccination_create(generate_vaccination_list.date + 16.week, @baby.birthday + 12.month, 3)
        when "ロタウイルス（１回目）"
          vaccination_create(generate_vaccination_list.date + 4.week, @baby.birthday + 24.week, 5)
        when "ロタウイルス（２回目）"
          vaccination_create(generate_vaccination_list.date + 4.week, @baby.birthday + 32.week, 6)
        when "ヒブ（１回目）"
          vaccination_create(generate_vaccination_list.date + 4.week, generate_vaccination_list.date + 8.week, 8)
        when "ヒブ（２回目）"
          vaccination_create(generate_vaccination_list.date + 4.week, generate_vaccination_list.date + 8.week, 9)
        when "ヒブ（３回目）"
          set_last_vaccination_list(7)
          vaccination_create(last_vaccination_list.date + 7.month, @baby.birthday + 5.year, 10)
        when "小児用肺炎球菌（１回目）"
          vaccination_create(generate_vaccination_list.date + 4.week, @baby.birthday + 11.month, 12)
        when "小児用肺炎球菌（２回目）"
          vaccination_create(generate_vaccination_list.date + 4.week, @baby.birthday + 12.month, 13)
        when "小児用肺炎球菌（３回目）"
          vaccination_create(haien_4th_compare_start_date(generate_vaccination_list), @baby.birthday + 15.month, 14)
        when "四種混合（１回目）"
          vaccination_create(generate_vaccination_list.date + 3.week, generate_vaccination_list.date + 8.week, 16)
        when "四種混合（２回目）"
          vaccination_create(generate_vaccination_list.date + 3.week, generate_vaccination_list.date + 8.week, 17)
        when "四種混合（３回目）"
          vaccination_create(generate_vaccination_list.date + 6.month, generate_vaccination_list.date + 18.month, 18)
        when "麻しん・風しん（１回目）"
          vaccination_create(academic_year_start + 6.year, academic_year_end + 6.year, 21)
        when "水ぼうそう（１回目）"
          vaccination_create(generate_vaccination_list.date + 3.month, generate_vaccination_list.date + 12.month, 23)
        when "日本脳炎（１回目）"
          vaccination_create(generate_vaccination_list.date + 6.days, generate_vaccination_list.date + 28.days, 25)
        when "日本脳炎（２回目）"
          set_last_vaccination_list(24)
          vaccination_create(last_vaccination_list.date + 6.month, @baby.birthday + 90.month, 26)
        when "日本脳炎（３回目）"
          vaccination_create(@baby.birthday + 9.year, @baby.birthday + 13.year, 27)
        when "HPV（１回目）"
          vaccination_create(generate_vaccination_list.days + 1.month, @baby.birthday + 15.year, 29)
        when "HPV（２回目）"
          set_last_vaccination_list(28)
          vaccination_create(hpv_3rd_compare_start_date(generate_vaccination_list, last_vaccination_list), @baby.birthday + 16.year, 30)
        end
      end
    end
    redirect_to baby_vaccination_lists_path
  end

  def show
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
    @reset_vaccination_lists = VaccinationList.where(baby_id: params[:baby_id], date: @vaccination_list.date)
    reset_vaccination_lists = []
    @reset_vaccination_lists.each do |reset_vaccination_list|
      case reset_vaccination_list.vaccine.name
      when "B型肝炎（１回目）"
        next_vaccination_list = VaccinationList.find_by(baby_id: params[:baby_id], vaccine_id: 2)
        if next_vaccination_list.date != nil
          flash.now[:alert] = "先に次回の接種（予定）日を削除してください！"
          render :show
          return
        end
      when "B型肝炎（２回目）"
        next_vaccination_list = VaccinationList.find_by(baby_id: params[:baby_id], vaccine_id: 3)
        if next_vaccination_list.date != nil
          flash.now[:alert] = "先に次回の接種（予定）日を削除してください！"
          render :show
          return
        end
      end
      reset_vaccination_list.assign_attributes(date: nil)
      reset_vaccination_lists << reset_vaccination_list
    end
    reset_vaccination_lists.each do |reset_vaccination_list|
      reset_vaccination_list.save(validate: false)
    end

    # @vaccination_lists.update_all(date: nil)
    redirect_to baby_vaccination_lists_path
  end

  private

  def vaccination_list_params
    params.require(:vaccination_list).permit(:date).merge(baby_id: params[:baby_id], vaccine_id: @vaccination_list.vaccine_id)
  end

  def set_vaccination_list
    @vaccination_list = VaccinationList.find(params[:id])
  end

  def set_show_vaccination_lists
    @vaccination_lists = VaccinationList.where(baby_id: params[:baby_id], date: @vaccination_list.date).where.not(id: params[:id])
  end

  def vaccination_ids_params
    params.permit(:date).merge(baby_id: params[:baby_id])
  end

  def set_vaccines
    vaccination_ids = VaccinationList.where("baby_id = ? AND start_date <= ? AND end_date >= ?", params[:baby_id], @vaccination_list.end_date, @vaccination_list.start_date).where(date: nil).where.not(id: params[:id]).pluck(:vaccine_id)
    @vaccines = Vaccine.where(id: vaccination_ids)
  end

  def set_baby
    @baby = Baby.find(params[:baby_id])
  end

  def vaccination_create(start_date, end_date, vaccine_id)
    @generate_vaccination_list = VaccinationList.create(
      start_date: start_date,
      end_date: end_date,
      baby_id: @baby.id,
      vaccine_id: vaccine_id
    )
  end

  def haien_4th_compare_start_date(generate_vaccination_list)
    if generate_vaccination_list.date + 60.days > @baby.birthday + 12.month
      generate_vaccination_list.date + 60.days
    else
      @baby.birthday + 12.month
    end
  end

  def hpv_3rd_compare_start_date(generate_vaccination_list, last_vaccination_list)
    if generate_vaccination_list.date + 2.month + 15.days > last_vaccination_list.date + 6.month
      generate_vaccination_list.date + 2.month
    else
      last_vaccination_list.date + 6.month
    end  
  end

  def academic_year_start
    if @baby.birthday.month >= 4
      Date.new(@baby.birthday.year, 4, 1)
    else
      Date.new(@baby.birthday.year - 1, 4, 1)
    end
  end

  def academic_year_end
    if @baby.birthday.month >= 4
      Date.new(@baby.birthday.year + 1, 3, 31)
    else
      Date.new(@baby.birthday.year, 3, 31)
    end
  end

  def set_last_vaccination_list(vaccine_id)
    last_vaccination_list = VaccinationList.find(baby_id: params[:baby_id], vaccine_id: vaccine_id)
  end
end
