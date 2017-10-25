class CatRentalRequest < ApplicationRecord
  belongs_to :cat

  STATUS = ['PENDING', 'APPROVED', 'DENIED']
  validates :status, inclusion: { in: STATUS,
    message: "%{value} is not a valid status" }
  validate :overlapping_requests
  def self.status
    STATUS
  end

  def approve!
    raise "Only works on pending rentals" if self.status != 'PENDING'
    CatRentalRequest.transaction do
      self.status = 'APPROVED'
      self.save!
      overlapping_approved_requests.each do |request|
        request.status = 'DENIED'
        request.save!
      end
    end
  end

  def overlapping_approved_requests
    #returns array of approved requests for cat_id cat
    overlapped_requests = []
    requested_cat = Cat.find(cat_id)
    requested_cat.cat_rental_requests.each do |request|
      if overlaps?(request) && request.status == 'PENDING'
        overlapped_requests << request
      end
    end
    overlapped_requests
  end

  def overlapping_requests
    # other_rental = CatRentalRequest.new(cat_id: 1, start_date: Date.yesterday - 10,
    # end_date: Date.tomorrow - 10)
    #get all the other approved rentals on cat with the same id
    #check if any of those overlap this instance
    #if true, do not validate and print out error
    #otherwise allow validation
    return if status == 'DENIED'
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
