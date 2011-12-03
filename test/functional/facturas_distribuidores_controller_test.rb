require 'test_helper'

class FacturasDistribuidoresControllerTest < ActionController::TestCase
  setup do
    @factura_distribuidor = facturas_distribuidores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:facturas_distribuidores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create factura_distribuidor" do
    assert_difference('FacturaDistribuidor.count') do
      post :create, factura_distribuidor: @factura_distribuidor.attributes
    end

    assert_redirected_to factura_distribuidor_path(assigns(:factura_distribuidor))
  end

  test "should show factura_distribuidor" do
    get :show, id: @factura_distribuidor.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @factura_distribuidor.to_param
    assert_response :success
  end

  test "should update factura_distribuidor" do
    put :update, id: @factura_distribuidor.to_param, factura_distribuidor: @factura_distribuidor.attributes
    assert_redirected_to factura_distribuidor_path(assigns(:factura_distribuidor))
  end

  test "should destroy factura_distribuidor" do
    assert_difference('FacturaDistribuidor.count', -1) do
      delete :destroy, id: @factura_distribuidor.to_param
    end

    assert_redirected_to facturas_distribuidores_path
  end
end
