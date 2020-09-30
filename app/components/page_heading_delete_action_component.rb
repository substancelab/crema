# frozen_string_literal: true

class PageHeadingDeleteActionComponent < ViewComponent::Base
  def initialize(label:, url:)
    super
    @label = label
    @url = url
  end
end
