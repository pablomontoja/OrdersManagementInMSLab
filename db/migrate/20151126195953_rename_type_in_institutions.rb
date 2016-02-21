class RenameTypeInInstitutions < ActiveRecord::Migration
  def change
  	rename_column :institutions, :type, :i_type
  end
end
