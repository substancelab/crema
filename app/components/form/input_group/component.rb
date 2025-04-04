# frozen_string_literal: true

module Form
  module InputGroup
    class Component < ViewComponent::Base
      # Returns the errors for attribute
      def errors
        @object.errors[@attribute] || []
      end

      # Returns true if object has errors for the current attribute
      def errors?
        @object.errors.include?(@attribute)
      end

      def initialize(form:, attribute:)
        super
        @attribute = attribute
        @form = form
        @object = form.object
      end

      # Returns the HTML to use for the actual input field element.
      def input_field
        render(::Flowbite::Input::Field.new(@form, @attribute))
      end

      # Returns the name of the method used to generate HTML for the input field
      def input_field_type
        :text_field
      end

      # Returns an array with the CSS classes to apply to the element that wraps
      # the input field element. This element is basically the one that makes
      # the field look like a field.
      def input_field_wrapper_classes
        classes = [
          "max-w-lg",
          "rounded-md",
          "shadow-sm",
          "sm:max-w-xs",
        ]
        return classes unless errors?

        classes + ["relative"]
      end

      # Returns the HTML to use for the label element
      def label
        @form.label(
          @attribute,
          :class => label_classes
        )
      end

      # Returns an array with the CSS classes to apply to the label element
      def label_classes
        [
          "block",
          "font-medium",
          "leading-5",
          "text-gray-700",
          "text-sm",
          "sm:mt-px",
          "sm:pt-2",
        ]
      end
    end
  end
end
