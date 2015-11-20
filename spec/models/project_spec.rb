require 'rails_helper'

RSpec.describe Project, :type => :model do
  	describe '#valid?' do  
		let!(:project) { @project1 = Project.new(name: "Home") }
		let!(:project) { @project2 = Project.new(name: "") }
		it "should raise validation error" do
			expect { @project2.save! }.to raise_error(/can't be blank/)
		end
	end
end
