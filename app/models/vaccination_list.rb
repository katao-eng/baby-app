class VaccinationList < ApplicationRecord
  belongs_to :baby
  belongs_to :vaccine

  validates :date, presence: true, on: :update
  validate :date_check
  with_options presence: true do
    validates :start_date
    validates :end_date
    validates :baby_id
    validates :vaccine_id
  end

  private

  def date_check
    unless date == nil
      errors.add(:date, "は接種可能期間内で指定してください。") unless 
      self.start_date <= self.date && self.end_date >= self.date
      end
  end
end
