# frozen_string_literal: true

class PageHeadingActionLinkSecondaryComponent < ViewComponent::Base
  def initialize(label:, url:)
    super
    @label = label
    @url = url
  end
end
