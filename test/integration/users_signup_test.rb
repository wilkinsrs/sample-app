require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  test "invalid signup information" do
    get signup_path #fetches signup page, which is users#new
    assert_no_difference 'User.count' do
      post users_path, user: {  name: "",
                                email: "user@invalid",
                                password: "foo",
                                password_confirmation: "bar"}
    end
    assert_template 'users/new' #tests that the failed resubmission re-renders the users#new action
  end
  
  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect user_path, user: { name: "foo bar",
                              email: "foobar@gmail.com",
                              password: "bob1234!",
                              password_confirmation: "bob1234!" }
    end
    assert_template 'users/show'
  end
end
