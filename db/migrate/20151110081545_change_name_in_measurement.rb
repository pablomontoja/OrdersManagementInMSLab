class ChangeNameInMeasurement < ActiveRecord::Migration
  def change
  	rename_column :measurements, :measurement_by, :measured_by
  	rename_column :measurements, :measurement_at, :measured_at
  end
end
