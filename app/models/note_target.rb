class NoteTarget < ActiveRecord::Base
  belongs_to :noteable, polymorphic: true
  belongs_to :note
end
