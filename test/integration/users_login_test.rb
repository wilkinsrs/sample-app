require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  test "displays login error correctly" do
    get login_path #visit the login path
    assert_template 'sessions/new' #verify that the new sessions form renders properly
    post login_path, session: { email: "", password: "" } #post an incorrect form submission
    assert_template 'sessions/new' #verify that it rerenders the sessions#new page
    assert_not flash.empty? #make sure the flash is present
    get root_path #redirect to another page
    assert flash.empty? #make sure flash isn't there anymore
  end
    
  
  
end
