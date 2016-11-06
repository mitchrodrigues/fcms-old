class GroupPermission < ActiveRecord::Base
  LEVELS = { 0 => 'none', 1 => 'ro', 2 => 'rw' }

  has_paper_trail

  belongs_to :permission
  belongs_to :group

  default_scope         ->() { where(active: true) }
  scope :highest_for_perm, ->(perm) { where(permission: perm).order('level DESC').first }

  validates_presence_of :level_string

  def level
    @level ||= ActiveSupport::StringInquirer.new(level_string)
  end

  def level=(val)
    self.level_string = val
    @level = ActiveSupport::StringInquirer.new(val) if val.present?
  end
end
