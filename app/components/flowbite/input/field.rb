# frozen_string_literal: true

module Flowbite
  module Input
    class Field < ViewComponent::Base
      def initialize(form, attribute)
        super
        @attribute = attribute
        @form = form
        @object = form.object
      end

      # Returns the HTML to use for the actual input field element.
      def call
        @form.send(
          input_field_type,
          @attribute,
          :class => input_field_classes
        )
      end

      # Returns an array with the CSS classes to apply to the input field
      def input_field_classes
        [
          "bg-gray-50",
          "border",
          "border-gray-300",
          "text-gray-900",
          "text-sm",
          "rounded-lg",
          "focus:ring-blue-500",
          "focus:border-blue-500",
          "block",
          "w-full",
          "p-2.5",
          "dark:bg-gray-700",
          "dark:border-gray-600",
          "dark:placeholder-gray-400",
          "dark:text-white",
          "dark:focus:ring-blue-500",
          "dark:focus:border-blue-500",
        ]
      end

      # Returns the name of the method used to generate HTML for the input field
      def input_field_type
        :text_field
      end
    end
  end
end
