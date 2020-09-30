# frozen_string_literal: true

class PageHeadingActionLinkComponent < ViewComponent::Base
  def initialize(label:, url:)
    super
    @label = label
    @url = url
  end
end
