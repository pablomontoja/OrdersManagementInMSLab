require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: { comment: @order.comment, created_by: @order.created_by, edited_by: @order.edited_by, final_price: @order.final_price, number: @order.number, order_date: @order.order_date, order_end_date: @order.order_end_date, order_type: @order.order_type, status: @order.status }
    end

    assert_redirected_to order_path(assigns(:order))
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order
    assert_response :success
  end

  test "should update order" do
    patch :update, id: @order, order: { comment: @order.comment, created_by: @order.created_by, edited_by: @order.edited_by, final_price: @order.final_price, number: @order.number, order_date: @order.order_date, order_end_date: @order.order_end_date, order_type: @order.order_type, status: @order.status }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
end
