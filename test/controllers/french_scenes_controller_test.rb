require 'test_helper'

class FrenchScenesControllerTest < ActionController::TestCase
  setup do
    @french_scene = french_scenes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:french_scenes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create french_scene" do
    assert_difference('FrenchScene.count') do
      post :create, french_scene: { french_scene_number: @french_scene.french_scene_number, scene_id: @french_scene.scene_id }
    end

    assert_redirected_to french_scene_path(assigns(:french_scene))
  end

  test "should show french_scene" do
    get :show, id: @french_scene
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @french_scene
    assert_response :success
  end

  test "should update french_scene" do
    patch :update, id: @french_scene, french_scene: { french_scene_number: @french_scene.french_scene_number, scene_id: @french_scene.scene_id }
    assert_redirected_to french_scene_path(assigns(:french_scene))
  end

  test "should destroy french_scene" do
    assert_difference('FrenchScene.count', -1) do
      delete :destroy, id: @french_scene
    end

    assert_redirected_to french_scenes_path
  end
end
