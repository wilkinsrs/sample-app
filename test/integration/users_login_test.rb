require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @user = users(:michael)
  end
  
  test "displays login error correctly" do
    get login_path #visit the login path
    assert_template 'sessions/new' #verify that the new sessions form renders properly
    post login_path, session: { email: "", password: "" } #post an incorrect form submission
    assert_template 'sessions/new' #verify that it rerenders the sessions#new page
    assert_not flash.empty? #make sure the flash is present
    get root_path #redirect to another page
    assert flash.empty? #make sure flash isn't there anymore
  end
  
  test "login with valid information" do
    get login_path
    post login_path, session: { email: @user.email, password: 'password' }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end
  
end
