require 'test_helper'

class HistoricProjectsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:historic_projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create historic_project" do
    assert_difference('HistoricProject.count') do
      post :create, :historic_project => { }
    end

    assert_redirected_to historic_project_path(assigns(:historic_project))
  end

  test "should show historic_project" do
    get :show, :id => historic_projects(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => historic_projects(:one).to_param
    assert_response :success
  end

  test "should update historic_project" do
    put :update, :id => historic_projects(:one).to_param, :historic_project => { }
    assert_redirected_to historic_project_path(assigns(:historic_project))
  end

  test "should destroy historic_project" do
    assert_difference('HistoricProject.count', -1) do
      delete :destroy, :id => historic_projects(:one).to_param
    end

    assert_redirected_to historic_projects_path
  end
end
