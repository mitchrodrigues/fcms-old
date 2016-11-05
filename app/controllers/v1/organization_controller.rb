module V1
  class OrganizationController < BaseController
    def index
      render json: current_user.organization
    end
  end
end