class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :name
      t.date :date_from
      t.date :date_to
      t.string :institution
      t.string :team
      t.string :client
      t.string :grant

      t.timestamps null: false
    end
  end
end
