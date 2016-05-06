require 'test_helper'

#build out validation logic checks here, but actually create the validation code in the model
#for each test, adjust the instance variable for the test

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup #set up an instance variable for all tests
    @user = User.new(:name => "Example User", :email => "user@example.com",
                      password: "foobar", password_confirmation: "foobar")
  end
  
  test "should be valid" do #test that the instance variable is valid
    assert @user.valid? #assert 'passes' if the .valid method returns true, and fails if it returns false
  end
  
  test "name should be present" do #test presence of a name
    @user.name = "" #the below method says 'don't assert that this is true'
    assert_not @user.valid? #assert 'passes' if .valid? method fails and it fails if it returns true
  end
  
  test "email should be present" do #test presence of email
    @user.email = ""
    assert_not @user.valid?
  end
  
  test "name is less than 51 characters" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  
  test "email is less than 51 characters" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  test "email is proper format" do
    valid_addresses = %w[foobar@example.com USER@example.com foo.b-ar@example.com alicebob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email is not invalid format" do
    invalid_addresses = %w[foobar_at_example.com foobar@example,com user@baz_baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} is not valid"
    end
  end
  
  test "email is not a duplicate" do
    duplicate_user = @user.dup #creaets a duplicate user of @user
    duplicate_user.email = @user.email.upcase #makes email all upcase
    @user.save #saves @user to the db
    assert_not duplicate_user.valid? #asserts that duplicate_user isn't valid because @user.email already exists in db
  end #notice that .valid? checks the db automatically
  
  test "password should be present (not blank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end
  
  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
    
  
end
