# frozen_string_literal: true

module PageHeading
  class ActionLinkSecondaryComponent < ViewComponent::Base
    def initialize(label:, url:)
      @label = label
      @url = url
    end
  end
end
