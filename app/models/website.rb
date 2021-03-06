class Website < ApplicationRecord

  belongs_to :user
  has_many :rank_logs, dependent: :delete_all

  validates :address, presence: true
  validates :rank, presence: true
  validates :user, presence: true, uniqueness: { scope: :address }

  after_save :create_rank_log

  def create_rank_log
    # if self.rank_changed?
      o_val, n_val = self.rank_change
      o_val = 0 if o_val.nil?
      (o_val = self.rank && n_val = self.rank) if n_val.nil?
      self.rank_logs.create(old_value: o_val, new_value: n_val)
      self.destroy if failure_count > 5
    # end
  end
end
