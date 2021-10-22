class VaccinationList < ApplicationRecord
  belongs_to :baby
  belongs_to :vaccine

  with_options presence: true do
    validates :start_date
    validates :end_date
    validates :status
    validates :baby_id
    validates :vaccine_id
  end
end
