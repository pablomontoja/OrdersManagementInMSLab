class StaticPagesController < ApplicationController
  def home
  	@orders = Order.last(20).reverse
  	@ready_orders = Order.where(status: "READY")
  	@oldest_not_ready = Order.where(status: ["IN PROGRESS","CHEANGED TECHNIQUE"]).order(:order_date).first(20)
  end

  def help
  end
end


