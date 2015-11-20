require 'rails_helper'

feature "TodolistManagement", :type => :feature do
  it "signs me up" do
	visit '/users/sign_up'
	fill_in 'Email', :with => 'user123@example.com'
	fill_in 'Password', :with => '123456'
	fill_in 'Password confirmation', :with => '123456'
	click_button 'Sign up'
	expect(page).to have_content 'Hello, user123@example.com'
	click_button 'Add TODO List'
	expect(page).to have_selector('div.project', visible: true)
	fill_in 'Start typing here to create a task...', :with => 'new task'
	click_button 'Add Task'
	expect(page).to have_selector('span.remove_task', visible: true)
	first('span.edit_task').click
	fill_in 'Start typing here to add a comment...', :with => 'new comment'
	click_button 'Add Comment'
	expect(page).to have_selector('span.destroy_comment', visible: true)
	first('span.destroy_comment').click
	first('span.remove_task').click
	first('span.remove_project').click
	expect(page).to_not have_selector('div.project', visible: true)
  end
end
