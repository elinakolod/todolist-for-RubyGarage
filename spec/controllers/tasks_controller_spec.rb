require 'rails_helper'

RSpec.describe TasksController, :type => :controller do
	before(:each) do
        user = User.create!(email: "sometask@i.ua", password: "123456", password_confirmation: "123456")
        sign_in user
        @project = Project.create!(name: "new project", user_id: user.id)
    end
    
     describe "POST #create" do
		it "creates new Task" do
		  expect { post :create, task: { name: 'new task', project_id: @project.id} }.to change(Task, :count).by(1)
		  expect do
			xhr :post, :create, task: { name: 'new task', project_id: @project.id }
		  end.to change(Task, :count).by(1)
		end
    end
    
    describe "PUT #update/:id" do
		it "updates @task" do
			@task = Task.create!(name: "task", project_id: @project.id)
			attr = { name: 'new name' }
			put :update, id: @task.id, task: attr
			@task.name = attr[:name]
			expect(assigns(:task)).to eq(@task)
		end
    end
    
    describe "DELETE #destroy/:id" do
      it "should destroy @task" do
		task = Task.create!(name: "task", project_id: @project.id)
        expect do
          xhr :delete, :destroy, id: task.id
        end.to change(Task, :count).by(-1)
      end
    end
end
