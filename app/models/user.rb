class User < ApplicationRecord
  has_many :registrations, dependent: :destroy## WHY?
  has_many :courses, through: :registrations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :pennkey, presence: true
  validates :password_hash, presence: true
  validates :pennkey, uniqueness: true
  # users.password_hash in the database is a :string
  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.students 
    User.where(is_instructor: false)
  end

  def self.instructors 
    User.where(is_instructor: true)
  end
end
