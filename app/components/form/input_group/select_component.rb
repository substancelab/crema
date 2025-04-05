# frozen_string_literal: true

module Form
  module InputGroup
    class SelectComponent < Form::InputGroup::Component
      def initialize(form:, attribute:, collection:, text_method: :to_s, value_method: :to_s)
        super(:form => form, :attribute => attribute)
        @collection = collection
        @text_method = text_method
        @value_method = value_method
      end

      def input_field
        render(
          ::Flowbite::Input::Select.new(
            @form,
            @attribute,
            @collection,
            @value_method,
            @text_method
          )
        )
      end
    end
  end
end
