class AddActiveToGrants < ActiveRecord::Migration
  def change
  	add_column :grants, :active, :boolean, default: true
  end
end
