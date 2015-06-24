class Question < ActiveRecord::Base
	belongs_to :user
	has_many :points
	accepts_nested_attributes_for :points, :reject_if => :all_blank, :allow_destroy => true
	has_many :answers
	accepts_nested_attributes_for :answers, :reject_if => :all_blank, :allow_destroy => true
end
