# frozen_string_literal: true

class PageHeading::ActionLinkComponent < ViewComponent::Base
  def initialize(label:, url:)
    super
    @label = label
    @url = url
  end
end
