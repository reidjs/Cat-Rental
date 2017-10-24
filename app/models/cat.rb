class Cat < ApplicationRecord
  COLORS = ['Black', 'Orange']
  validates :color, inclusion: { in: COLORS,
    message: "%{value} is not a valid color" }
  def colors
    COLORS
  end
end
