class ChangeOrderEndDate < ActiveRecord::Migration
  def change
  	change_column :orders, :order_end_date, :date
  end
end
