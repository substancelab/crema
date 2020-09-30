# frozen_string_literal: true

module Form
  module InputGroup
    class SelectComponent < Form::InputGroup::Component
      def initialize(form:, attribute:, collection:, text_method:, value_method:)
        super(:form => form, :attribute => attribute)
        @collection = collection
        @text_method = text_method
        @value_method = value_method
      end

      def input_field
        @form.send(
          input_field_type,
          @attribute,
          @collection,
          @value_method,
          @text_method,
          {},
          :class => input_field_classes
        )
      end

      # Returns an array with the CSS classes to apply to the input field
      def input_field_classes
        [
          "block",
          "duration-150",
          "ease-in-out",
          "form-select",
          "transition",
          "w-full",
          "sm:text-sm",
          "sm:leading-5",
        ]
      end

      # Returns the name of the method used to generate HTML for the input field
      def input_field_type
        :collection_select
      end
    end
  end
end
