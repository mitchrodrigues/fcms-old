module V1
  class GroupsController < V1::BaseController
    def index
      @groups = Group.for_organization(current_organization)
    end

    def my_groups
    end
  end
end