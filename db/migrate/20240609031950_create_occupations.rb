class CreateOccupations < ActiveRecord::Migration[7.1]
  def change
    create_table :occupations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.date :day
      t.datetime :time_s
      t.datetime :time_e
      t.boolean :reservation
      t.boolean :confirmed

      t.timestamps
    end
  end
end
