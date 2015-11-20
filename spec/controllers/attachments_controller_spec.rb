require 'rails_helper'

RSpec.describe AttachmentsController, :type => :controller do
	before(:each) do
        user = User.create(email: "some@i.ua", password: "123456", password_confirmation: "123456")
        sign_in user       
    end
    
     describe "POST #create" do
		it "creates new Attachment" do
		  expect { post :create, attachment: { file: fixture_file_upload('/1.png', 'image/png') }, format: :json}.to change(Attachment, :count).by(1)
		  expect do
			xhr :post, :create, attachment: { file: fixture_file_upload('/1.png', 'image/png') }
		  end.to change(Attachment, :count).by(1)
		end
    end
    
    describe "DELETE #destroy/:id" do
      it "should destroy @attachment" do
		attachment = Attachment.create!(file: fixture_file_upload('/1.png', 'image/png'))
        expect do
          xhr :delete, :destroy, id: attachment.id
        end.to change(Attachment, :count).by(-1)
      end
    end
end
