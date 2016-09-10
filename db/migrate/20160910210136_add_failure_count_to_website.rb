class AddFailureCountToWebsite < ActiveRecord::Migration[5.0]
  def change
    add_column :websites, :failure_count, :integer, default: 0
  end
end
