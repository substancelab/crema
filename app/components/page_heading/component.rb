# frozen_string_literal: true

class PageHeading::Component < ViewComponent::Base
  def initialize(title:, actions: [])
    super
    @title = title
    @actions = actions
  end
end
