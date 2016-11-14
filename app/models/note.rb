class Note < ActiveRecord::Base
  belongs_to :creator, polymorphic: true
  has_many   :note_targets

  default_scope ->() { where(active: true) }

  scope :notes_for, ->(user) { where("privacy = 'public' OR creator_id = #{user.id}") }

end
