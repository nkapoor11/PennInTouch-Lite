class Course < ApplicationRecord
  belongs_to :department
  has_many :registrations, dependent: :destroy## WHY?
  has_many :users, through: :registrations
  validates :code, uniqueness: { scope: :department_id }
  validates :department_id, presence: true
  validates :code, presence: true
  validates :title, presence: true
  validates :description, presence: true

  #validates :department, presence: true

  def full_code
    "#{department.code}-#{code}"
  end

  def instructor
    users.find_by(is_instructor: true)
  end

  def instructor=(user)
    isTrue = user.is_instructor
    if isTrue then users << user end
  end

  def students 
    users.where(is_instructor: false)
  end



end
