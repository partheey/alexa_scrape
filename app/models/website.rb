class Website < ApplicationRecord

  belongs_to :user
  has_many :rank_logs

  validates :address, presence: true
  validates :rank, presence: true
  validates :user, presence: true, uniqueness: { scope: :address }

  after_update :create_rank_log
  after_create :create_rank_log

  def create_rank_log
    if self.rank_changed?
      o_val, n_val = self.rank_change
      o_val = 0 if o_val.nil?
      self.rank_logs.create(old_value: o_val, new_value: n_val)
    end
  end
end
