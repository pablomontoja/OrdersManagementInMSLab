class ChangeColumnsInReports < ActiveRecord::Migration
  def change
  	change_column :reports, :institution, :integer
  	change_column :reports, :team, :integer
  	change_column :reports, :client, :integer
  	change_column :reports, :grant, :integer
  end
end
