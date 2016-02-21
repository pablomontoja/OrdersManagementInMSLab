class AddSampleNameToOrder < ActiveRecord::Migration
  def change
  	add_column :orders, :sample_name, :string
  	change_column :orders, :order_date, :date
  end
end
