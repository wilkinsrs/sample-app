require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  test "layout links" do
    get root_path #tells test to make a get request for the root path
    assert_template 'static_pages/home' #validates that static_pages/home view is rendered
    assert_select "a[href=?]", root_path, count: 2 #validates presence of 2 root_path links
    assert_select "a[href=?]", help_path #validates presence of 1 help_path link
    assert_select "a[href=?]", about_path #validates presence of 1 about_path link
    assert_select "a[href=?]", contact_path #validates presence of 1 contact_path link
  end
  
  
end
