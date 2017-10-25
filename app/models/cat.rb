class Cat < ApplicationRecord
  has_many :cat_rental_requests,
    dependent: :destroy

  COLORS = ['Black', 'Orange']
  validates :color, inclusion: { in: COLORS,
    message: "%{value} is not a valid color" }
  def self.colors
    COLORS
  end
end
