class CreateRankLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :rank_logs do |t|
      t.integer :old_value,   null:false
      t.integer :new_value,   null:false
      t.belongs_to :website,  null:false, foreign_key: true
      t.timestamps
    end
  end
end
