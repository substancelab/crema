# frozen_string_literal: true

class ServicesController < ApplicationController
  # POST /services
  def create
    @service = Service.new(service_params)

    if @service.save
      flash[:success] = "Service was successfully created."
      redirect_to @service
    else
      render :new
    end
  end

  # DELETE /services/1
  def destroy
    @service = find_service
    @service.destroy
    flash[:success] = "Service was successfully destroyed."
    redirect_to services_url
  end

  # GET /services/1/edit
  def edit
    @service = find_service
  end

  # GET /services
  def index
    @services = Service.default_order
  end

  # GET /services/new
  def new
    @service = Service.new
  end

  # GET /services/1
  def show
    @service = find_service
  end

  # PATCH/PUT /services/1
  def update
    @service = find_service

    if @service.update(service_params)
      flash[:success] = "Service was successfully updated."
      redirect_to @service
    else
      render :edit
    end
  end

  private

  def find_service
    Service.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def service_params
    params.
      require(:service).
      permit(:name, :unit, :price)
  end
end
