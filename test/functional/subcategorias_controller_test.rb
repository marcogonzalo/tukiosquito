require 'test_helper'

class SubcategoriasControllerTest < ActionController::TestCase
  setup do
    @subcategoria = subcategorias(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subcategorias)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subcategoria" do
    assert_difference('Subcategoria.count') do
      post :create, subcategoria: @subcategoria.attributes
    end

    assert_redirected_to subcategoria_path(assigns(:subcategoria))
  end

  test "should show subcategoria" do
    get :show, id: @subcategoria.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subcategoria.to_param
    assert_response :success
  end

  test "should update subcategoria" do
    put :update, id: @subcategoria.to_param, subcategoria: @subcategoria.attributes
    assert_redirected_to subcategoria_path(assigns(:subcategoria))
  end

  test "should destroy subcategoria" do
    assert_difference('Subcategoria.count', -1) do
      delete :destroy, id: @subcategoria.to_param
    end

    assert_redirected_to subcategorias_path
  end
end
