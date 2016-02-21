json.array!(@orders) do |order|
  json.extract! order, :id, :number, :order_date, :order_end_date, :status, :final_price, :created_by, :edited_by, :order_type, :comment
  json.url order_url(order, format: :json)
end
