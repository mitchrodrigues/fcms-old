class Child < Person
  include Assignable

  assignment_owners case_workers: :staff,
    placements: :facilities,
    relations:  :family

  scope :with_assignments, ->() { includes(:placements, case_workers: :resource) }

  def age
    return 0 unless dob.present?
    (Time.now - dob.to_time).to_i / 31557600
  end

  def current_placement
    active_placements.first
  end

  def current_facility
    active_placements.first.resource
  end
end
