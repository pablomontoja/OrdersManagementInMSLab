class ZmianyDecimali < ActiveRecord::Migration
  def change
  	change_column :orders, :final_price, :decimal, :precision => 7, :scale => 2
  	change_column :measurements, :price, :decimal, :precision => 7, :scale => 2
  	change_column :techniques, :price_icho, :decimal, :precision => 7, :scale => 2  	
  	change_column :techniques, :price_ncc, :decimal, :precision => 7, :scale => 2
  	change_column :techniques, :price_cc, :decimal, :precision => 7, :scale => 2
  	change_column :techniques, :price_science, :decimal, :precision => 5, :scale => 2
  end
end
