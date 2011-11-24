require 'test_helper'

class CuponesControllerTest < ActionController::TestCase
  setup do
    @cupon = cupones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cupones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cupon" do
    assert_difference('Cupon.count') do
      post :create, cupon: @cupon.attributes
    end

    assert_redirected_to cupon_path(assigns(:cupon))
  end

  test "should show cupon" do
    get :show, id: @cupon.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cupon.to_param
    assert_response :success
  end

  test "should update cupon" do
    put :update, id: @cupon.to_param, cupon: @cupon.attributes
    assert_redirected_to cupon_path(assigns(:cupon))
  end

  test "should destroy cupon" do
    assert_difference('Cupon.count', -1) do
      delete :destroy, id: @cupon.to_param
    end

    assert_redirected_to cupones_path
  end
end
