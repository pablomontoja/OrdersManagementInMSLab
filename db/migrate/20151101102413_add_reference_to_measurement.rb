class AddReferenceToMeasurement < ActiveRecord::Migration
  def change
  	add_reference :measurements, :order, index: true
  end
end
