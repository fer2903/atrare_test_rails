class Quiz < ApplicationRecord
	validates_presence_of :title
    has_many :questions, dependent: :destroy
	has_many :replies, dependent: :destroy
	has_many :count_replies, dependent: :destroy
end
