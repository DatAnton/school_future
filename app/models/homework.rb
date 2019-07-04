class Homework < ApplicationRecord
  belongs_to :lesson

  validates :homework, presence: true
end
