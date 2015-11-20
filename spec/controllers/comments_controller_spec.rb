require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do
	before(:each) do
        user = User.create(email: "some@i.ua", password: "123456", password_confirmation: "123456")
        sign_in user
        project = Project.create(name: "new project", user_id: user.id)
        @task = Task.create(name: "new task", project_id: project.id)
        
    end
    
     describe "POST #create" do
		it "creates new Comment" do
		  expect { post :create, comment: { content: 'new comment', task_id: @task.id} }.to change(Comment, :count).by(1)
		  expect do
			xhr :post, :create, comment: { content: 'new comment', task_id: @task.id }
		  end.to change(Comment, :count).by(1)
		end
    end
    
    describe "DELETE #destroy/:id" do
      it "should destroy @comment" do
		comment = Comment.create!(content: "comment", task_id: @task.id)
        expect do
          xhr :delete, :destroy, id: comment.id
        end.to change(Comment, :count).by(-1)
      end
    end
end
