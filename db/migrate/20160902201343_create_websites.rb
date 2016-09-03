class CreateWebsites < ActiveRecord::Migration[5.0]
  def change
    create_table :websites do |t|
      t.text :address,     null: false
      t.integer :rank,     null: false
      t.integer :user_id,  null: false
      t.timestamps
      t.index([:address, :user_id], unique: true)
    end
  end
end
