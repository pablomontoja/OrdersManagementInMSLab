class DropTechniques < ActiveRecord::Migration
  def change
  	 drop_table :techniques
  end
end
