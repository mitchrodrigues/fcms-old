class Child < Person
  include Assignable

  assignment_owners case_workers: :staff,
    placements: :facilities,
    relations:  :family

  scope :with_assignments, ->() { includes(:placements, case_workers: :resource) }
end
