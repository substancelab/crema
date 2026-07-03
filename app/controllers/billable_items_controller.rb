# frozen_string_literal: true

class BillableItemsController < ApplicationController
  before_action :find_agreement

  def index
    @billable_items = @agreement.billable_items.order(:occurred_at => :desc)
  end

  def destroy
    find_billable_item.destroy
    redirect_to agreement_billable_items_path(@agreement)
  end

  private

  def find_agreement
    @agreement = Agreement.find(params[:agreement_id])
  end

  def find_billable_item
    @agreement.billable_items.find(params[:id])
  end
end
