class CatRentalRequest < ApplicationRecord
  belongs_to :cat

  STATUS = ['PENDING', 'APPROVED', 'DENIED']
  validates :status, inclusion: { in: STATUS,
    message: "%{value} is not a valid status" }
  validate :overlapping_requests
  def self.status
    STATUS
  end



  def overlapping_requests
    # other_rental = CatRentalRequest.new(cat_id: 1, start_date: Date.yesterday - 10,
    # end_date: Date.tomorrow - 10)
    #get all the other approved rentals on cat with the same id
    #check if any of those overlap this instance
    #if true, do not validate and print out error
    #otherwise allow validation
    requested_cat = Cat.find(cat_id)
    requested_cat.cat_rental_requests.each do |request|
      # debugger
      if overlaps?(request) && request.status == 'APPROVED'
        errors[:status] << 'Request overlaps'
      end
    end
    # value = overlaps?(other_rental)
    # debugger

  end

  private

  def overlaps?(other_rental)
    start_date = other_rental.start_date
    end_date = other_rental.end_date
    (self.start_date - end_date) *
    (start_date - self.end_date) >= 0
  end

end
