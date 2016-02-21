class CreateGrants < ActiveRecord::Migration
  def change
    create_table :grants do |t|
      t.string :name
      t.string :short_name

      t.timestamps null: false
    end
  end
end
