class Subject < ApplicationRecord
  has_many :lessons
  has_many :users_and_subject
  has_many :users, through: :users_and_subject
end
