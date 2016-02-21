require 'test_helper'

class TechniquesControllerTest < ActionController::TestCase
  setup do
    @technique = techniques(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:techniques)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create technique" do
    assert_difference('Technique.count') do
      post :create, technique: { name: @technique.name, price_cc: @technique.price_cc, price_icho: @technique.price_icho, price_ncc: @technique.price_ncc, price_science: @technique.price_science, short_name: @technique.short_name }
    end

    assert_redirected_to technique_path(assigns(:technique))
  end

  test "should show technique" do
    get :show, id: @technique
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @technique
    assert_response :success
  end

  test "should update technique" do
    patch :update, id: @technique, technique: { name: @technique.name, price_cc: @technique.price_cc, price_icho: @technique.price_icho, price_ncc: @technique.price_ncc, price_science: @technique.price_science, short_name: @technique.short_name }
    assert_redirected_to technique_path(assigns(:technique))
  end

  test "should destroy technique" do
    assert_difference('Technique.count', -1) do
      delete :destroy, id: @technique
    end

    assert_redirected_to techniques_path
  end
end
