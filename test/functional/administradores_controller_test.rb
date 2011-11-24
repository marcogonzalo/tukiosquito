require 'test_helper'

class AdministradoresControllerTest < ActionController::TestCase
  setup do
    @administrador = administradores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administradores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administrador" do
    assert_difference('Administrador.count') do
      post :create, administrador: @administrador.attributes
    end

    assert_redirected_to administrador_path(assigns(:administrador))
  end

  test "should show administrador" do
    get :show, id: @administrador.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @administrador.to_param
    assert_response :success
  end

  test "should update administrador" do
    put :update, id: @administrador.to_param, administrador: @administrador.attributes
    assert_redirected_to administrador_path(assigns(:administrador))
  end

  test "should destroy administrador" do
    assert_difference('Administrador.count', -1) do
      delete :destroy, id: @administrador.to_param
    end

    assert_redirected_to administradores_path
  end
end
