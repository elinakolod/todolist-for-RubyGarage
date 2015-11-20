require 'rails_helper'

RSpec.describe Comment, :type => :model do
    describe '#valid?' do  
		let!(:comment) { @comment1 = Comment.new(content: "Some content") }
		let!(:comment) { @comment2 = Comment.new(content: "") }
		it "should raise validation error" do
			expect { @comment2.save! }.to raise_error(/can't be blank/)
		end
	end
end
