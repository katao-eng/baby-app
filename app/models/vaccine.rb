class Vaccine < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :kind_id
  end
end
