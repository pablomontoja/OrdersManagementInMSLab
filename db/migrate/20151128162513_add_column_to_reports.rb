class AddColumnToReports < ActiveRecord::Migration
  def change
  	add_column :reports, :i_type, :integer
  end
end
