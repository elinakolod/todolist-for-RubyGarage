require 'rails_helper'
require "cancan/matchers"
RSpec.describe User, :type => :model do
	describe '#valid?' do  
		context "valid email" do   
		    @user1 = User.create!(email: "elina1@ua.ua", password: "123456", password_confirmation: "123456")
		    let!(:user) { @user2 = User.new(email: "elina1@ua.ua", password: "123456", password_confirmation: "123456")} 
		    it "should raise db error when validation is skipped" do
			    expect { @user2.save!(validate: false) }.to raise_error
		    end
		end     
	end
	describe "abilities" do
		user = User.create!(email: "elina2@ua.ua", password: "123456", password_confirmation: "123456")
		user.projects << Project.new(name: "home")
        subject(:ability){ Ability.new(user) }
		context "when is registered" do
			let(:user){ Factory(:registered) }

			it{ should be_able_to(:manage, user.projects[0]) }
			it{ should_not be_able_to(:manage, Project.new(name: "home", user_id: 1)) }
		end
	end
end
