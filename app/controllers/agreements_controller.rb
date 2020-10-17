# frozen_string_literal: true

class AgreementsController < ApplicationController
  # POST /agreements
  def create
    @agreement = Agreement.new(agreement_params)

    if @agreement.save
      flash[:success] = "Agreement was successfully created."
      redirect_to @agreement
    else
      render :new
    end
  end

  # DELETE /agreements/1
  def destroy
    @agreement = find_agreement
    @agreement.destroy
    flash[:success] = "Agreement was successfully destroyed."
    redirect_to agreements_url
  end

  # GET /agreements/1/edit
  def edit
    @agreement = find_agreement
  end

  # GET /agreements
  def index
    @agreements = Agreement.
      default_order.
      group_by(&:state)
  end

  # GET /agreements/new
  def new
    @agreement = Agreement.new(params.permit(:customer_id))
  end

  # GET /agreements/1
  def show
    @agreement = find_agreement
  end

  # PATCH/PUT /agreements/1
  def update
    @agreement = find_agreement

    if @agreement.update(agreement_params)
      flash[:success] = "Agreement was successfully updated."
      redirect_to @agreement
    else
      render :edit
    end
  end

  private

  def find_agreement
    Agreement.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def agreement_params
    params.
      require(:agreement).
      permit(:customer_id, :service_id, :project_name, :price, :unit, :ends_on, :state, :purchase_order_number)
  end
end
