module V1
  class OfficesController < BaseController
    before_action :lookup_office, only: [:show, :edit, :update, :destroy]

    # GET /v1/offices
    # GET /v1/offices.json

    def current
      @offices = current_user.offices || []
      render action: :index
    end


    def index
      @offices = Office.all
    end

    # GET /v1/offices/1
    # GET /v1/offices/1.json
    def show
    end

    # GET /v1/offices/new
    def new
      @office = Office.new
    end

    # GET /v1/offices/1/edit
    def edit
    end

    # POST /v1/offices
    # POST /v1/offices.json
    def create
      @office = Office.new(office_params)
      @office.organization_id = current_user.organization_id

      respond_to do |format|
        if @office.save
          format.json { render :show, status: :created, location: v1_office_url(@office) }
        else
          format.json { render json: @office.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /v1/offices/1
    # PATCH/PUT /v1/offices/1.json
    def update
      respond_to do |format|
        if @office.update(office_params)
          format.html { redirect_to @office, notice: 'Office was successfully updated.' }
          format.json { render :show, status: :ok, location: @office }
        else
          format.html { render :edit }
          format.json { render json: @office.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /v1/offices/1
    # DELETE /v1/offices/1.json
    def destroy
      @office.destroy
      respond_to do |format|
        format.html { redirect_to v1_offices_url, notice: 'Office was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def lookup_office
        @office = Office.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def office_params
        params[:office].permit!
      end
  end
end