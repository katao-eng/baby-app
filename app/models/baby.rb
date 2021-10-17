class Baby < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :nickname
    validates :birthday
    validates :user_id
  end
end
