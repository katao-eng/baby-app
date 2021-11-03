class VaccinationList < ApplicationRecord
  belongs_to :baby
  belongs_to :vaccine

  validates :date, presence: true, on: :update
  with_options presence: true do
    validates :start_date
    validates :end_date
    validates :baby_id
    validates :vaccine_id
  end
end
