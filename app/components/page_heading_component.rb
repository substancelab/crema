# frozen_string_literal: true

class PageHeadingComponent < ViewComponent::Base
  def initialize(title:, actions: [])
    super
    @title = title
    @actions = actions
  end
end
