class StaticPagesController < ApplicationController
  def home
  	@orders = Order.last(20).reverse
  	@ready_orders = Order.where(status: "GOTOWY DO ODBIORU")
  	@oldest_not_ready = Order.where(status: ["W TRAKCIE POMIARU","ZMIANA METODY"]).order(:order_date).first(20)
  end

  def help
  end
end


