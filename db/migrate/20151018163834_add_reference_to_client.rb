class AddReferenceToClient < ActiveRecord::Migration
  def change
  	add_reference :clients, :team, index: true
  end
end
