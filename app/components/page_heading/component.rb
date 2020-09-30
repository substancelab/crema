# frozen_string_literal: true

# Page Heading
#
# https://tailwindui.com/components/application-ui/headings/page-headings
class PageHeading::Component < ViewComponent::Base
  def initialize(title:, actions: [])
    super
    @title = title
    @actions = actions
  end
end
