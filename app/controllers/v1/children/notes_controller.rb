module V1
  module Children
    class NotesController < BaseController
      before_action :lookup_child

      before_action :lookup_note, only: [:destroy]

      def index
        render partial: 'v1/common/notes', 
               locals: { notes: child.notes_for(current_user) }
      end


      def create
        note = child.add_note(note_params[:note], 
                 current_user, 
                 (params[:type] || 'general'),
                 (params[:privacy] || 'public'))

        if note.new_record?
          return api_render(false, "NOTE.NOT_ADDED", error: note.errors.full_messages) 
        end
        
        api_render(true, "NOTE.ADDED")
      end


      def destroy
        note.active = false
        if !note.save
          return api_render(false, "ERROR.NOT_DELETED", error: note.errors.full_messages)
        end

        api_render(true, "NOTE.DELETED")
      end

      private
      def note_params
        params[:note].permit(:note)
      end

      def lookup_note        
        if note.blank?
          return api_render(false, "ERROR.RECORD_NOT_FOUND")
        end
        note
      end

      def note
        @note ||= Note.where(id: params[:id]).first
      end
    end
  end
end