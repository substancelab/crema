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

      # Returns the HTML to use for the actual input field element.
      def input_field
        @form.send(
          input_field_type,
          @attribute,
          :class => input_field_classes
        )
      end

      # Returns an array with the CSS classes to apply to the input field
      def input_field_classes
        [
          "block",
          "duration-150",
          "ease-in-out",
          "form-input",
          "transition",
          "w-full",
          "sm:text-sm",
          "sm:leading-5",
        ]
      end

      # Returns the name of the method used to generate HTML for the input field
      def input_field_type
        :text_field
      end
    end
  end
end
