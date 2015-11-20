class Task < ActiveRecord::Base
	validates :name, presence: true, allow_blank: false
	belongs_to :project
	has_many :comments, -> { order('created_at DESC') }, dependent: :destroy
	has_many :attachments, dependent: :destroy
	accepts_nested_attributes_for :comments,
		allow_destroy: true,
		reject_if: proc { |attributes| attributes['content'].blank? }
	accepts_nested_attributes_for :attachments,
		allow_destroy: true
end
