class Facility < ActiveRecord::Base
  include Assignable
  include Addressable

  belongs_to :office
  belongs_to :organization

  before_create :ensure_organization_id
  
  assignment_resources placements: :children,
    providers: :care_providers

  has_addresses  

  def ensure_organization_id
    self.organization_id ||= office.organization_id
  end

  def available_bed_count
    @av_bed_count  ||= bed_count.to_i - placement_count
  end

  def placement_count
    active_placements.count
  end
end