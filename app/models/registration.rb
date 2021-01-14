class Registration < ApplicationRecord
  belongs_to :course
  belongs_to :user
  validates :course, uniqueness: { scope: :user }
end
