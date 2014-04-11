class Task < ActiveRecord::Base

	validates :label, :presence => true
	validates :category_id, :presence => true

	belongs_to :category
end
