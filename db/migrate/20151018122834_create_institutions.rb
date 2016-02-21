class CreateInstitutions < ActiveRecord::Migration
  def change
    create_table :institutions do |t|
      t.string :name
      t.string :short_name
      t.string :address_line1
      t.string :address_line2

      t.timestamps null: false
    end
  end
end
