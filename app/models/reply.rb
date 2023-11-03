class Reply < ApplicationRecord
  belongs_to :quiz
  belongs_to :user
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers
end
