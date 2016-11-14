require 'action_view'

module V1
  class ChildrenController < BaseController
    before_action :lookup_child, only: [:show, :update, :placement_start, :placement_end, :notes]

    helper ActionView::Helpers::DateHelper

    #######################################################
    # Scaffold API
    #######################################################

    def index
      @children = current_user.organization.children.with_assignments
    end 

    def show
     
    end

    def create
      @child = current_organization.children.new(child_params)
      unless child.save
        return api_render(false, "CHILD.SAVE_FAILED", error: child.errors.full_messages)
      end
      render action: :show
    end

    def update
      unless child.update_attributes(child_params)
        return api_render(false, "CHILD.SAVE_FAILED", error: child.errors.full_messages)
      end
      render action: :show
    end

    #######################################################
    # Current API
    #######################################################

    def case_load
      @children = current_user.children.with_assignments
      render action: :index
    end

    def case_load_search
       @children = children_search(current_user, params[:query])
       render action: :index
    end

    #######################################################
    # Search API
    #######################################################

    def search
      @children = children_search(current_organization, params[:query])               
      render action: :index
    end

    #######################################################
    # Placement API
    # TODO: Perhaps have an assignemnts controller
    #       Also we should probably move this to model logic
    #######################################################

    def placement_start
      with(:facility) do |facility|
        rec = facility.assignment_start(:placement, child)
        return api_render(true, "CHILD.PLACEMENT_STARTED") unless rec.new_record?
        return api_render(false,"CHILD.PLACEMENT_NOT_STARTED", error: rec.errors.full_messages)
      end
    end

    def placement_end
      with(:facility) do |facility|
        if ! facility.assignment_end(:placement, child)
          return  api_render(false, "CHILD.PLACEMENT_NOT_FOUND")
        end
        return api_render(true, "CHILD.PLACEMENT_ENDED")
      end
    end

    #######################################################
    # Placement API
    # TODO: Perhaps have an assignemnts controller
    #       Also we should probably move this to model logic
    #######################################################
    def notes
      with(:child_notes) do |nts|
        return render partial: 'v1/common/notes', locals: { notes: nts }
      end
    end

    def create_note

    end



    #######################################################
    # Mapping
    #######################################################
    def mapping
      mapping = Mapping::Children.new(person: current_user)
      render json: { mapping: mapping.available_fields }
    end

    #######################################################
    # Private
    # TODO: Perhaps have an assignemnts controller
    #       Also we should probably move this to model logic
    #######################################################

    private
      def children_search(ar_relation, query)
        ar_relation.
          children.
          where(Child.name_search_clause(query)).
          with_assignments
      end

      def child_notes
        @child.notes_for(current_user).includes(:creator)
      end

      def facility        
        @facility ||= Facility.where(id: params[:facility_id]).first
      end

      def child_params
        params[:child].permit(*Person::ALLOWED_ATTRIBUTES)
      end

      def lookup_child
        return api_render(false, "ERROR.RECORD_NOT_FOUND") unless child
        child
      end

      def child
        unless @child
          id = params[:child_id] || params[:id]
          @child = Child.find(id) rescue nil
        end
        @child
      end
  end
end