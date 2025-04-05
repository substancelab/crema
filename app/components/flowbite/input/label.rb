# frozen_string_literal: true

module Flowbite
  module Input
    class Label < ViewComponent::Base
      def call
        @form.label(
          @attribute,
          :class => label_classes
        )
      end

      def initialize(form, attribute)
        super
        @attribute = attribute
        @form = form
        @object = form.object
      end

      # Returns an array with the CSS classes to apply to the label element
      def label_classes
        [
          "block",
          "mb-2",
          "text-sm",
          "font-medium",
          "text-gray-900",
          "dark:text-white",
        ]
      end
    end
  end
end
