# frozen_string_literal: true

module Form
  module InputGroup
    class Component < ViewComponent::Base
      def initialize(form:, attribute:)
        super
        @attribute = attribute
        @form = form
        @object = form.object
      end
    end
  end
end
