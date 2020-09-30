# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/agreements", :type => :request do
  let!(:customer) { FactoryBot.create(:customer) }
  let!(:service) { FactoryBot.create(:service) }

  let(:valid_attributes) {
    {
      :customer_id => customer.to_param,
      :project_name => "Google 2",
      :service_id => service.to_param,
    }
  }

  let(:invalid_attributes) {
    {
      :project_name => "",
    }
  }

  describe "GET /index" do
    it "renders a successful response" do
      Agreement.create!(valid_attributes)
      get agreements_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      agreement = Agreement.create!(valid_attributes)
      get agreement_url(agreement)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_agreement_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      agreement = Agreement.create!(valid_attributes)
      get edit_agreement_url(agreement)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Agreement" do
        expect {
          post agreements_url, :params => {:agreement => valid_attributes}
        }.to change(Agreement, :count).by(1)
      end

      it "redirects to the created agreement" do
        post agreements_url, :params => {:agreement => valid_attributes}
        expect(response).to redirect_to(agreement_url(Agreement.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Agreement" do
        expect {
          post agreements_url, :params => {:agreement => invalid_attributes}
        }.to change(Agreement, :count).by(0)
      end

      it "renders the 'new' template" do
        post agreements_url, :params => {:agreement => invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {:project_name => "Even better"}
      }

      it "updates the requested agreement" do
        agreement = Agreement.create!(valid_attributes)
        expect {
          patch agreement_url(agreement), :params => {:agreement => new_attributes}
        }.to change {
          agreement.reload.project_name
        }.to("Even better")
      end

      it "redirects to the agreement" do
        agreement = Agreement.create!(valid_attributes)
        patch agreement_url(agreement), :params => {:agreement => new_attributes}
        agreement.reload
        expect(response).to redirect_to(agreement_url(agreement))
      end
    end

    context "with invalid parameters" do
      it "renders the 'edit' template" do
        agreement = Agreement.create!(valid_attributes)
        patch agreement_url(agreement), :params => {:agreement => invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested agreement" do
      agreement = Agreement.create!(valid_attributes)
      expect {
        delete agreement_url(agreement)
      }.to change(Agreement, :count).by(-1)
    end

    it "redirects to the agreements list" do
      agreement = Agreement.create!(valid_attributes)
      delete agreement_url(agreement)
      expect(response).to redirect_to(agreements_url)
    end
  end
end
