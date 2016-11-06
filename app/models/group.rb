class Group < ActiveRecord::Base
  has_many :group_permissions
  has_many :group_members

  has_many :people, through: :group_members

  has_many :permissions, through: :group_permissions

  belongs_to :organizations

  scope :for_organization, ->(org) { where('organization_id = ? OR organization_id = -1', org.id) }

  has_paper_trail  

  def add_person(person)
    group_members.where(person: person).first_or_create
  end

  def add_permission(permission:, level:)
    gp = group_permissions.where(permission_id: permission.id).first_or_initialize
    gp.level_string = level
    gp.save
  end
end


