require 'rails_helper'

RSpec.describe Attachment, :type => :model do
    describe '#valid?' do  
		let!(:attachment) do 
			@attachment = Attachment.new
			@attachment.file = File.open("#{Rails.root}/public/1.png")
		end
		let!(:attachment) do 
			@attachment2 = Attachment.new
			@attachment2.file = File.open("#{Rails.root}/public/1.xls")
		end
		it "should raise file type error" do
			expect { @attachment2.save! }.to raise_error(/not allowed/)
		end
	end
end
