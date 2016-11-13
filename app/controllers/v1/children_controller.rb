require 'action_view'

module V1
  class ChildrenController < BaseController
    before_action :lookup_child, only: [:show, :update, :placement_start, :placement_end]

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
      facility.assignment_start(:placement, child)
      return api_render(true, "CHILD.PLACEMENT_STARTED")
    end

    def placement_end
      if ! facility.assignment_end(:placement, child)
        return  api_render(false, "CHILD.PLACEMENT_NOT_FOUND")
      end

      api_render(true, "CHILD.PLACEMENT_ENDED")
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

      def facility        
        @facility ||= Facility.find(params[:facility_id])
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