class ChangeMultiplierColumn < ActiveRecord::Migration
  def change
  	change_column :measurements, :multiplier, :decimal, :precision => 4, :scale => 2, :default => 1.0
  end
end
