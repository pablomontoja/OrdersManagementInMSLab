class AddNewColumnsToOrders < ActiveRecord::Migration
  def change
   	add_column :orders, :sendtojob, :boolean
   	add_column :orders, :sendtojobdatetime, :datetime
  	add_column :orders, :sendmail, :boolean
  end
end
