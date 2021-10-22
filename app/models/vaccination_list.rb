class VaccinationList < ApplicationRecord
  belongs_to :baby
  belongs_to :vaccine
end
