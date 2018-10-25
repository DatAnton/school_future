class Form < ApplicationRecord
  has_many :users
  has_many :lessons
end
