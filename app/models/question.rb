class Question < ApplicationRecord
  belongs_to :quiz
  has_many :possible_answers, dependent: :destroy
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :possible_answers, reject_if: :all_blank, allow_destroy: true
end
