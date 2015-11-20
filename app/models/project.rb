class Project < ActiveRecord::Base
	validates :name, presence: true
	belongs_to :user
	has_many :tasks, -> { order(:position) }, dependent: :destroy
	accepts_nested_attributes_for :tasks,
		allow_destroy: true,
		reject_if: proc { |attributes| attributes['name'].blank? }
		
	def get_max_task_position
		if self.id.blank? || self.tasks.blank?
			position = 0 
		else
			position = self.tasks.map{|task| task.position}.max + 1 
		end
	end
end
