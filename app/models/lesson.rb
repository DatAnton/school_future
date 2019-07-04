class Lesson < ApplicationRecord
  belongs_to :subject
  belongs_to :form
  belongs_to :user
  has_many :homeworks
end
