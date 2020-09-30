# frozen_string_literal: true

module PageHeading
  class DeleteActionComponent < ViewComponent::Base
    def initialize(label:, url:)
      super
      @label = label
      @url = url
    end
  end
end
