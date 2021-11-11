class VaccinationListsController < ApplicationController
  before_action :set_vaccination_list, only: [:set, :generate, :show, :edit, :update, :reset]
  before_action :set_vaccines, only: [:set, :generate]
  before_action :set_baby, only: [:index, :generate]

  def index
    cookies[:baby_id] = @baby.id
    @vaccination_lists = VaccinationList.where(baby_id: params[:baby_id])
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

        when "B型肝炎（２回目）"

        when "ロタウイルス（１回目）"

        when "ロタウイルス（２回目）"
          
        when "ヒブ（１回目）"
          
        when "ヒブ（２回目）"
          
        when "ヒブ（３回目）"
          
        when "小児用肺炎球菌（１回目）"
          
        when "小児用肺炎球菌（２回目）"
          
        when "小児用肺炎球菌（３回目）"
          
        when "四種混合（１回目）"
          
        when "四種混合（２回目）"
          
        when "四種混合（３回目）"
          
        when "麻しん・風しん（１回目）"
          
        when "水ぼうそう（１回目）"
          
        when "日本脳炎（１回目）"
          
        when "日本脳炎（２回目）"
          
        when "日本脳炎（３回目）"
          
        when "HPV（１回目）"
          
        when "HPV（２回目）"
          
        end
      end
    end
    redirect_to baby_vaccination_lists_path
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
end
