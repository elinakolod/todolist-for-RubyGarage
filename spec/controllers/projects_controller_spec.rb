require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
	before(:each) do
        @user = User.create(email: "some@i.ua", password: "123456", password_confirmation: "123456")
        sign_in @user
    end
    describe "GET #index" do
		it "responds successfully with an HTTP 200 status code" do
		  get :index
		  expect(response).to be_success
		  expect(response).to have_http_status(200)
		end

		it "renders the index template" do
		  get :index
		  expect(response).to render_template("index")
		end

		it "loads all of the projects into @projects" do
		  @user.projects << Project.create!(name: "project1")
		  @user.projects << Project.create!(name: "project2")
		  get :index
		  expect(assigns(:projects)).to match_array(@user.projects)
		end
    end
    
     describe "POST #create" do
		it "creates new Project" do
		  expect { post :create, project: { name: 'new name', user_id: @user.id} }.to change(Project, :count).by(1)
		  expect do
			xhr :post, :create, project: { name: 'new name', user_id: @user.id }
		  end.to change(Project, :count).by(1)
		end
    end
    
    describe "PUT #update/:id" do
		it "updates @project" do
			@project = Project.create!(name: "project", user_id: @user.id)
			attr = { name: 'new name' }
			put :update, id: @project.id, project: attr
			@project.name = attr[:name]
			expect(assigns(:project)).to eq(@project)
		end
    end
    
    describe "DELETE #destroy/:id" do
      it "should destroy @project" do
		project = Project.create!(name: "project1", user_id: @user.id)
        expect do
          xhr :delete, :destroy, id: project.id
        end.to change(Project, :count).by(-1)
      end
    end
end
