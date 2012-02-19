require 'test_helper'

class ReportesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get clientes" do
    get :clientes
    assert_response :success
  end

  test "should get categorias" do
    get :categorias
    assert_response :success
  end

  test "should get top_ten" do
    get :top_ten
    assert_response :success
  end

  test "should get bottom_ten" do
    get :bottom_ten
    assert_response :success
  end

end
