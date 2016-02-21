class AddReferenceToTeam < ActiveRecord::Migration
  def change
  	add_reference :teams, :institution, index: true
  end
end
