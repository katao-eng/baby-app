class Vaccine < ApplicationRecord
  has_many :vaccination_lists

  with_options presence: true do
    validates :name
    validates :kind_id
  end

  enum kind_id: ["不活化ワクチン", "生ワクチン", "生ワクチン（飲むワクチン）"]
end
