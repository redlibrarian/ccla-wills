class WillController < ApplicationController

  def index
    @wills = Will.all
  end

  def new
    @will = Will.new
  end

  def create
    @will = Will.new(will_params)
    if @will.save
      @thank_you = "Thank you for registering with us. You registered the following will:"
      render 'show'
    else
      render 'new'
    end

  end

  def show
    @will = Will.find(params[:id])
  end


  private
  def will_params
    params.require(:will).permit(:first_name, :last_name, :alt_last_name, :dob, :city_of_birth, :province_of_birth, :country_of_birth, :last_resided, :lawyer_name, :firm_name, :lsuc, :telephone)
  end
end
