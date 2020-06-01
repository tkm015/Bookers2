class Book < ApplicationRecord

	belongs_to :user

	validates :title,:body, presence: true

	validates :title,:body, length: { maximum: 200 }
end
