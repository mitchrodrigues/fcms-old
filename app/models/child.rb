class Child < Person
  assignment_owners case_workers: :staff,
                    placements: :facilities,
                    relations:  :family,
                    wards: :offices

  scope :with_assignments, ->() { includes(:placements, case_workers: :resource) }

  def age
    return 0 unless dob.present?
    (Time.now - dob.to_time).to_i / 31557600
  end
end
