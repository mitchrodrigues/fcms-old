class GroupMember < ActiveRecord::Base
  belongs_to :person, polymorphic: true
  belongs_to :group
end
