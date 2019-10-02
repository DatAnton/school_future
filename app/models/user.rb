class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, presence: true
  validates :last_name, presence: true
  # validates :avatar, presence: true

  mount_uploader :avatar, ImageUploader

  belongs_to :form, required: false
  has_many :users_and_subject
  has_many :subjects, through: :users_and_subject
  has_many :notes
  has_many :lessons
  has_many :grades

  def admin?
    user_type == 'admin'
  end

  def self.is_free_for_lessons?(user_lessons, lesson)
    user_lessons.each do |les|
      # if Lesson.less_equal?(les, lesson)
      #   puts "HERE"
      #   return false
      # end
      return false if Lesson.less_equal?(les, lesson)
    end
    true
  end

end
