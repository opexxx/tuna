require 'test_helper'

class FingerprintMatchesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fingerprint_matches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fingerprint_match" do
    assert_difference('FingerprintMatch.count') do
      post :create, :fingerprint_match => { }
    end

    assert_redirected_to fingerprint_match_path(assigns(:fingerprint_match))
  end

  test "should show fingerprint_match" do
    get :show, :id => fingerprint_matches(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => fingerprint_matches(:one).to_param
    assert_response :success
  end

  test "should update fingerprint_match" do
    put :update, :id => fingerprint_matches(:one).to_param, :fingerprint_match => { }
    assert_redirected_to fingerprint_match_path(assigns(:fingerprint_match))
  end

  test "should destroy fingerprint_match" do
    assert_difference('FingerprintMatch.count', -1) do
      delete :destroy, :id => fingerprint_matches(:one).to_param
    end

    assert_redirected_to fingerprint_matches_path
  end
end
