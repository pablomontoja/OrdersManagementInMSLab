class CreateNewTechniques < ActiveRecord::Migration
  def change
    create_table :techniques do |t|
      t.string :name
      t.string :short_name
      t.decimal :price_icho
      t.decimal :price_ncc
      t.decimal :price_cc
      t.decimal :price_science

      t.timestamps null: false
    end
  end
end
