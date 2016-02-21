class AddInstitutionIdToClient < ActiveRecord::Migration
  def change
  	add_reference :clients, :institution, index: true
  end
end
