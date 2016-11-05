class Child < Person
  include Assignable

  assignment_owners case_workers: :staff,
    placements: :facilities,
    relations:  :family
    
end
