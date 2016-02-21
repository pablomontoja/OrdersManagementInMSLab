class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :number
      t.datetime :order_date
      t.datetime :order_end_date
      t.string :status
      t.decimal :final_price
      t.string :created_by
      t.string :edited_by
      t.string :order_type
      t.string :comment

      t.timestamps null: false
    end
  end
end
