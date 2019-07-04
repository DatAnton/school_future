class Grade < ApplicationRecord
  belongs_to :user
  validates :grade, presence: true, numericality: { more_than: 0, less_than: 13 }
  validates :subject_id, presence: true
  validates :user_id, presence: true
end
