require 'test_helper'

class HistoricCostsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:historic_costs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create historic_cost" do
    assert_difference('HistoricCost.count') do
      post :create, :historic_cost => { }
    end

    assert_redirected_to historic_cost_path(assigns(:historic_cost))
  end

  test "should show historic_cost" do
    get :show, :id => historic_costs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => historic_costs(:one).to_param
    assert_response :success
  end

  test "should update historic_cost" do
    put :update, :id => historic_costs(:one).to_param, :historic_cost => { }
    assert_redirected_to historic_cost_path(assigns(:historic_cost))
  end

  test "should destroy historic_cost" do
    assert_difference('HistoricCost.count', -1) do
      delete :destroy, :id => historic_costs(:one).to_param
    end

    assert_redirected_to historic_costs_path
  end
end
