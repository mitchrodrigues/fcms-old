# This is very ugly but it makes our other things cleaner
# so for now we will leave it as is to refactor later
module Permissable
  extend ActiveSupport::Concern

  def has_read_permission?(permission)
    gp = permission_hunt(permission)
    return false unless gp
    gp.level.read?
  end

  def has_write_permission?(permission)
    gp = permission_hunt(permission)
    return false unless gp
    gp.level.write?
  end

  def permission_hunt(permission)
    permission = lookup_permission(permission)
    return nil unless permission

    gp = lookup_group_permission(permission)
    return nil unless gp

    gp
  end

  def lookup_permission(permission)
    permissions.where(name: permission).first
  end

  def lookup_group_permission(permission)
    group_permissions.highest_for_perm(permission)
  end

  class_methods do
    def has_permissions
      has_many :group_members
      has_many :groups, through: :group_members
      has_many :group_permissions, through: :groups
      has_many :permissions, through: :groups
    end
  end
end
