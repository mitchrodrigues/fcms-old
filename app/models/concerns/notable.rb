module Notable
  extend ActiveSupport::Concern


  def add_note(text, creator, type = :general, privacy = :public)
    note = note_type(type).create(note: text, creator: creator, privacy: note_privacy(privacy))
    notes << note

    note
  end

  def notes_for(user)
    notes.notes_for(user)
  end


  private
  def note_type(t)
    type = t || 'general'
    "Notes::#{type.to_s.camelize}".constantize
  end

  def note_privacy(p)
    p || 'public'
  end

  class_methods do
    def has_notes
      has_many :note_targets, as: :noteable
      has_many :notes, through: :note_targets
    end
  end  
end