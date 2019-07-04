class Form < ApplicationRecord
  has_many :users
  has_many :lessons, dependent: :destroy
end
