class Assignment < ActiveRecord::Base

  #######################################################
  # Rails STI to Polymorphic hax
  #######################################################
  # This is a bug when mixing sti and abstract_classes
  # however not having abstract breaks the poloymorphic
  # relationing in assignments table. so lets just set it :)
  # why not. This seems to fix the bug well enough.
  self.abstract_class = true
  self.table_name     = 'assignments'
  def self.inherited(subclass)
    super
    subclass.instance_eval do
      default_scope ->() { where(type: subclass.name) }
      def type
        subclass.name
      end
    end
  end

  belongs_to :organization

  belongs_to :owner, polymorphic: true
  belongs_to :resource, polymorphic: true

  before_create :ensure_defaults

  validate :ensure_owner_type, on: :create
  validate :ensure_unique_assignments


  def ensure_unique_assignments
    not_unique = self.class.where({ owner: owner, resource: resource }).where("ended_at IS NULL").exists?
    return true unless not_unique
    errors.add(:base, "Active assignments must be unique")
  end
  
  def ensure_defaults
    self.organization_id ||= owner.organization_id
    self.organization_id ||= resource.organization_id
    self.started_at      ||= Time.now
  end

  def ensure_owner_type
    return true if self.class.agmnt_owner_type.blank?
    if owner_type != self.class.agmnt_owner_type
      errors.add(:base, "Owner type must be #{self.class.agmnt_owner_type}")
    end
  end

  def terminate
    update_attribute(:ended_at, Time.now)
  end

  class << self
    attr_accessor :agmnt_owner_type
    def assignment_owner_type(kls)
      self.agmnt_owner_type = kls.to_s.camelize
    end
  end


end
