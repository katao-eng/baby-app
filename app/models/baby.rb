class Baby < ApplicationRecord
  belongs_to :user
  has_many :vaccination_lists

  with_options presence: true do
    validates :nickname
    validates :birthday
    validates :user_id
  end
end
