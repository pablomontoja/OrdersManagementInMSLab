class AddColumnToClients < ActiveRecord::Migration
  def change
  	add_column :clients, :email, :string
  	add_column :clients, :phone, :string
  end
end
