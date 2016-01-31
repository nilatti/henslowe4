require 'test_helper'

class RehearsalsControllerTest < ActionController::TestCase
  setup do
    @rehearsal = rehearsals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rehearsals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rehearsal" do
    assert_difference('Rehearsal.count') do
      post :create, rehearsal: { act_id: @rehearsal.act_id, end_time: @rehearsal.end_time, french_scene_id: @rehearsal.french_scene_id, production_id: @rehearsal.production_id, scene_id: @rehearsal.scene_id, space_id: @rehearsal.space_id, start_time: @rehearsal.start_time }
    end

    assert_redirected_to rehearsal_path(assigns(:rehearsal))
  end

  test "should show rehearsal" do
    get :show, id: @rehearsal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rehearsal
    assert_response :success
  end

  test "should update rehearsal" do
    patch :update, id: @rehearsal, rehearsal: { act_id: @rehearsal.act_id, end_time: @rehearsal.end_time, french_scene_id: @rehearsal.french_scene_id, production_id: @rehearsal.production_id, scene_id: @rehearsal.scene_id, space_id: @rehearsal.space_id, start_time: @rehearsal.start_time }
    assert_redirected_to rehearsal_path(assigns(:rehearsal))
  end

  test "should destroy rehearsal" do
    assert_difference('Rehearsal.count', -1) do
      delete :destroy, id: @rehearsal
    end

    assert_redirected_to rehearsals_path
  end
end
