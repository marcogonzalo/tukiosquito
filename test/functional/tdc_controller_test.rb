require 'test_helper'

class TdcControllerTest < ActionController::TestCase
  setup do
    @tdc = tdc(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tdc)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tdc" do
    assert_difference('Tdc.count') do
      post :create, tdc: @tdc.attributes
    end

    assert_redirected_to tdc_path(assigns(:tdc))
  end

  test "should show tdc" do
    get :show, id: @tdc.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tdc.to_param
    assert_response :success
  end

  test "should update tdc" do
    put :update, id: @tdc.to_param, tdc: @tdc.attributes
    assert_redirected_to tdc_path(assigns(:tdc))
  end

  test "should destroy tdc" do
    assert_difference('Tdc.count', -1) do
      delete :destroy, id: @tdc.to_param
    end

    assert_redirected_to tdc_index_path
  end
end
