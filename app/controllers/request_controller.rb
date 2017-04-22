class RequestController < ApplicationController

  def index
    status = params[:status] || "All"
    if status == "All"
      @requests = Request.all
    else
      @requests = Request.where(status: status)
    end
    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"requests.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def new
    @request = Request.new
  end

  def edit
    @request = Request.find(params[:id])
  end

  def update
    @request = Request.find(params[:id])
    if @request.update_attributes(request_params)
      render 'show'
    else
      render 'edit'
    end
  end

  def create
    @request = Request.new(request_params)
    if @request.save
      redirect_to @request
    else
      render 'new'
    end

  end

  def show
    @request = Request.find(params[:id])
  end


  private
  def request_params
    params.require(:request).permit(:applicant, :testator_first, :testator_last, :testator_dob, :testator_city, :email, :telephone, :testator_alt, :testator_province, :testator_country, :testator_last_resident, :status)
  end
end
