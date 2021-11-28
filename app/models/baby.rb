class Baby < ApplicationRecord
  belongs_to :user
  has_many :vaccination_lists, dependent: :destroy

  with_options presence: true do
    validates :nickname
    validates :birthday
    validates :user_id
  end
end
