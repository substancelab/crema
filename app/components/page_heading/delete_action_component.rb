# frozen_string_literal: true

class PageHeading::DeleteActionComponent < ViewComponent::Base
  def initialize(label:, url:)
    super
    @label = label
    @url = url
  end
end
