class CreateRegulations < ActiveRecord::Migration[7.1]
  def change
    create_table :regulations do |t|
      t.string :begin_time
      t.string :close_time
      t.string :interval_s
      t.string :interval_e
      t.integer :unit_minute
      t.string :version

      t.timestamps
    end
  end
end
