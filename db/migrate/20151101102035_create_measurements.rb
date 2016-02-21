class CreateMeasurements < ActiveRecord::Migration
  def change
    create_table :measurements do |t|
      t.decimal :multiplier
      t.decimal :price
      t.string :measurement_by
      t.date :measurement_at
      t.string :comment

      t.timestamps null: false
    end
  end
end
