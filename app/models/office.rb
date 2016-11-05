class Office < ActiveRecord::Base
  include Assignable
  include Addressable

  has_addresses

  belongs_to :organization

  has_many :facilities

  assignment_resources employees: :staff

  has_many :children, through: :facilities
end
