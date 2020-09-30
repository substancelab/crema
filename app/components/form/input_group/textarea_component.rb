# frozen_string_literal: true

module Form
  module InputGroup
    class TextareaComponent < Form::InputGroup::Component
      # Returns the name of the method used to generate HTML for the input field
      def input_field_type
        :text_area
      end
    end
  end
end
