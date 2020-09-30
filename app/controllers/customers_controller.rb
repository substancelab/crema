# frozen_string_literal: true

class CustomersController < ApplicationController
  # POST /customers
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      flash[:success] = "Customer was successfully created."
      redirect_to @customer
    else
      render :new
    end
  end

  # DELETE /customers/1
  def destroy
    @customer = find_customer
    @customer.destroy
    flash[:success] = "Customer was successfully destroyed."
    redirect_to customers_url
  end

  # GET /customers/1/edit
  def edit
    @customer = find_customer
  end

  # GET /customers
  def index
    @customers = Customer.all
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1
  def show
    @customer = find_customer
  end

  # PATCH/PUT /customers/1
  def update
    @customer = find_customer

    if @customer.update(customer_params)
      flash[:success] = "Customer was successfully updated."
      redirect_to @customer
    else
      render :edit
    end
  end

  private

  def find_customer
    Customer.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def customer_params
    params.
      require(:customer).
      permit(:company_name, :tax_id, :tax_region, :invoice_email, :address, :phone)
  end
end