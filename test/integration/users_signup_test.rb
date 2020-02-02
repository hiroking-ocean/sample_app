require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: {user: {name: "",
                                      email: "user@invalid",
                                      password:           "foo",
                                      password_confirmation: "bar"}}
    end
    assert_template 'users/new'

    assert_select 'div#error_explation' do
      assert_select 'div.alert', "The form contains ."
    end
    assert_select 'div.field_with_errors'
    assert_select 'form[action="/signup"]'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count' ,1  do
      post users_path, params: {user: {name: "example user",
                                      email: "uesr@example.com",
                                      password: "password",
                                      password_confirmation: "password"}}
    end
    follow_redirect!
    assert_template 'users/show'
    assert_select 'div.alert-success', true , "No success message"
  end
end
