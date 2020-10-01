# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/services", :type => :request do
  let(:valid_attributes) {
    {
      :name => "Ad Hoc Work",
      :price => 123,
      :unit => "hour",
    }
  }

  let(:invalid_attributes) {
    {
      :name => "Ad Hoc Work",
      :price => -123,
      :unit => "hour",
    }
  }

  before do
    sign_in_as("tester@substancelab.com")
  end

  describe "GET /index" do
    it "renders a successful response" do
      Service.create! valid_attributes
      get services_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      service = Service.create! valid_attributes
      get service_url(service)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_service_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      service = Service.create! valid_attributes
      get edit_service_url(service)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Service" do
        expect {
          post services_url, :params => {:service => valid_attributes}
        }.to change(Service, :count).by(1)
      end

      it "redirects to the created service" do
        post services_url, :params => {:service => valid_attributes}
        expect(response).to redirect_to(service_url(Service.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Service" do
        expect {
          post services_url, :params => {:service => invalid_attributes}
        }.to change(Service, :count).by(0)
      end

      it "renders the 'new' template" do
        post services_url, :params => {:service => invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {:name => "Better name"}
      }

      it "updates the requested service" do
        service = Service.create! valid_attributes

        expect {
          patch service_url(service), :params => {:service => new_attributes}
        }.to change {
          service.reload.name
        }.from("Ad Hoc Work").to("Better name")
      end

      it "redirects to the service" do
        service = Service.create! valid_attributes
        patch service_url(service), :params => {:service => new_attributes}
        service.reload
        expect(response).to redirect_to(service_url(service))
      end
    end

    context "with invalid parameters" do
      it "renders the 'edit' template" do
        service = Service.create! valid_attributes
        patch service_url(service), :params => {:service => invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested service" do
      service = Service.create! valid_attributes
      expect {
        delete service_url(service)
      }.to change(Service, :count).by(-1)
    end

    it "redirects to the services list" do
      service = Service.create! valid_attributes
      delete service_url(service)
      expect(response).to redirect_to(services_url)
    end
  end
end
