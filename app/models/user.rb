class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, presence: true
  validates :last_name, presence: true
  # validates :form_id, presence: false


  belongs_to :form
  has_many :users_and_subject
  has_many :subjects, through: :users_and_subject
  has_many :notes
end
