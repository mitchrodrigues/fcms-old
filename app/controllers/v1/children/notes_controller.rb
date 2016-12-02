module V1
  module Children
    class NotesController < Children::BaseController
      before_action :lookup_child

      before_action :lookup_note, only: [:destroy, :update, :show]

      def index
        render partial: 'v1/common/notes', 
               locals: { notes: child.notes_for(current_user) }
      end

      def show 
        render partial: 'v1/common/note', locals: { note: note }
      end

      def create
        type    = note_params.delete 'type'
        privacy = note_params.delete 'privacy'
        note    = note_params.delete 'note'

        @note = child.add_note(note, current_user, type, privacy)

        if @note.new_record?
          return api_render(false, Errors::SAVE_FAILED, error: note.errors.full_messages) 
        end
        
        # api_render(true, "NOTE.ADDED")
        return show
      end

      def update
        _ignored = note_params.delete 'type'

        if !note.update_attributes(note_params)
          return api_render(false, Errors::SAVE_FAILED, error: note.error.full_messages)
        end

        return show
        # api_render(false, "NOTE.UPDATED")
      end


      def destroy
        if !note.update_attribute(:active, false)
          return api_render(false, Errors::SAVE_FAILED, error: note.errors.full_messages)
        end

        api_render(true, 'NOTE.DELETED')
      end

      private
      def note_params
        params[:note].permit(:note, :privacy, :type)
      end

      def lookup_note        
        if note.blank?
          return api_render(false, Errors::RECORD_NOT_FOUND)
        end
        note
      end

      def note
        @note ||= Note.where(id: params[:id]).first
      end
    end
  end
end