# frozen_string_literal: true

module PageHeading
  class ActionLinkSecondaryComponent < ViewComponent::Base
    def initialize(label:, url:)
      super
      @label = label
      @url = url
    end
  end
end
