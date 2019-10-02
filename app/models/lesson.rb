class Lesson < ApplicationRecord
  belongs_to :subject
  belongs_to :form
  belongs_to :user
  has_many :homeworks

  def self.less_equal?(les1, les2)
    les1.day == les2.day && les1.number == les2.number
  end
end
