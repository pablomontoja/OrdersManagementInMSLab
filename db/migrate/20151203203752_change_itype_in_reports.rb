class ChangeItypeInReports < ActiveRecord::Migration
  def change
  	change_column :reports, :i_type, :string
  end
end
