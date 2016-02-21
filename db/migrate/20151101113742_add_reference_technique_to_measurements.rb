class AddReferenceTechniqueToMeasurements < ActiveRecord::Migration
  def change
  	add_reference :measurements, :technique, index: true
  end
end
