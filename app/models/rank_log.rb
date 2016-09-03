class RankLog < ApplicationRecord

  belongs_to :website

  validates :new_value, presence: true
  validates :old_value, presence: true
end
