# frozen_string_literal: true

module PageHeading
  class ActionLinkComponent < ViewComponent::Base
    def initialize(label:, url:)
      super
      @label = label
      @url = url
    end
  end
end
