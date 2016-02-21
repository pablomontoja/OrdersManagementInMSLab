class CreateManyToMantTable < ActiveRecord::Migration
  def change
    create_table :clients_grants, id: false do |t|
      t.belongs_to :client, index: true
      t.belongs_to :grant, index: true
    end

    add_reference :grants, :team, index: true
    add_reference :orders, :grant, index: true
  end
end
