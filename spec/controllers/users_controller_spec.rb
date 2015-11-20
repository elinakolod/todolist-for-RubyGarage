require 'rails_helper'
include Warden::Test::Helpers

RSpec.describe UsersController, :type => :controller do
	include Devise::TestHelpers
	describe "GET #index" do
		it "returns current_user" do
			@user = User.create!(email: "some@i.ua", password: "123456", password_confirmation: "123456")
			@request.env["devise.mapping"] = Devise.mappings[:admin]
			sign_in @user
			get :index
			expect(assigns(:user)).to eq(@user)
		end
  end
end
