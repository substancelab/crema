# frozen_string_literal: true

# Page Heading
#
# https://tailwindui.com/components/application-ui/headings/page-headings
module PageHeading
  class Component < ViewComponent::Base
    renders_one :meta

    def initialize(title:, actions: [])
      @title = title
      @actions = actions
    end
  end
end
