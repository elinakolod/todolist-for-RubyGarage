require 'rails_helper'

RSpec.describe Task, :type => :model do
    describe '#valid?' do  
		let!(:task) { @task1 = Task.new(name: "first") }
		let!(:task) { @task2 = Task.new(name: "") }
		it "should raise validation error" do
			expect { @task2.save! }.to raise_error(/can't be blank/)
		end
	end
end
