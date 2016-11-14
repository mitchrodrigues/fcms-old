class Staff < Person
  include Assignable

  assignment_owners employees: :offices

  assignment_resources case_workers: :children
  
  before_create :ensure_staff_flag

  def ensure_staff_flag
    self.staff = true
  end
end
